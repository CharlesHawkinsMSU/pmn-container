pmn:= pmn.sif
pmn-base:= pmn-base.sif
pmn-deps:= pmn-deps.sif

pmn.sif: pmn.def pmn-base.sif
	singularity build -F pmn.sif pmn.def

pmn-base.sif: pmn-base.def pmn-deps.sif
	singularity build -F pmn-base.sif pmn-base.def

pmn-deps.sif: pmn-deps.def
	singularity build -F pmn-deps.sif pmn-deps.def

pmn-ptools.sif: pmn.sif pmn-ptools.def
	singularity build -F pmn-ptools.sif pmn-ptools.def

shell: pmn.sif
	singularity shell pmn.sif
