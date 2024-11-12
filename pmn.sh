#!/bin/bash
# Template for a bash script

# Makes sure the given option has an argument, errors out if not
function needs_arg() {
	if ! [ -v 2 ]; then
		echo "$1 requires an argument"
		exit 1
	fi
}

singleton_stages="newproj shell lisp build update-build full-rebuild"
# Should unset all vars used for command-line arguments and flags here, along with pmn_args (the array of arguments to be passed to pmn-pipeline.py)
unset pmn_args stages singleton_stage
while [[ $# -gt 0 ]]; do
	case "$1" in
		-[^-]?*)
			# This case is to support combining flags, like "-fd" as a shorthand for "-f -d"
			a=("$@")
			set -- "${a[0]:0: -1}" "-${a[0]: -1}" "${a[@]:1}"
			;;
		-*)
			pmn_args+=("$1")
			shift ;;
		*)
			if [ $singleton_stage ]; then
				echo "Stage $singleton_stage cannot be combined with other stages"
				exit 1
			fi
			if [[ $singleton_stages =~ [[:space:]]?${1}[[:space:]]? ]]; then
				if [ $stages ]; then
				echo "Stage $1 cannot be combined with other stages"
				exit 1
				fi
				singleton_stage=$1
			fi
			stages+=("$1")
			pmn_args+=("$1")
			shift ;;
	esac
done

PMN_BUILD_DIR=${PMN_BUILD_DIR-$(dirname $(readlink -f $0))}
PMN_CONTAINER=${PMN_CONTAINER-$PMN_BUILD_DIR/pmn-ptools.sif}
export SINGULARITY_BIND
SINGULARITY_BIND=""

# Having the pgdbs:/pgdbs bind in place makes newproj not work

if [[ -a pgdbs && $singleton_stage != "build" ]]; then
	echo "pgdbs exists, setting bind"
	SINGULARITY_BIND="pgdbs:/pgdbs"
fi

# A fix for a problem on some host distros where the host's /dev/shm is a symlink to /run/shm but the container's /run/shm is a symlink to /dev/shm and this results in circular symlinks in the container

if [[ -h /dev/shm ]]; then
	SINGULARITY_BIND="$SINGULARITY_BIND,/run:/run"
fi
echo $SINGULARITY_BIND

# These singleton stages are executed by this script rather than by pmn-pipeline.py in the container

if [[ $singleton_stage == "shell" ]]; then
	cmd="singularity shell $PMN_CONTAINER"
elif [[ $singleton_stage == "lisp" ]]; then
	cmd="singularity exec $PMN_CONTAINER rlwrap -c -q '\"' -pgreen /pmn/pathway-tools/ptlisp -load /pmn/creation-package/lisp/pmn-lisp-funs.lisp"
elif [[ $singleton_stage == "build" || $singleton_stage == "update-build" || $singleton_stage == "full-rebuild" ]]; then
	cd $PMN_BUILD_DIR
	tmp_fs=$(df /tmp | tail -1 | awk '{print $1}')
	if [[ $tmp_fs == "tmpfs" ]]; then
		tmpdir=$PMN_BUILD_DIR/tmp
		echo "/tmp is mounted on tmpfs and may be too small; using $tmpdir as a temp build dir instead"
		mkdir -p $tmpdir
		export TMPDIR=$tmpdir
		export SINGULARITY_TMPDIR=$tmpdir
	fi
	if [[ $singleton_stage == "update-build" ]]; then
		touch $PMN_BUILD_DIR/pmn-ptools.def
	elif [[ $singleton_stage == "full-rebuild" ]]; then
		touch $PMN_BUILD_DIR/pmn-base.def
	fi
	cmd="make pmn-ptools.sif"
else
	cmd="${PMN_CONTAINER} ${pmn_args[*]}"
fi

echo $cmd
$cmd
