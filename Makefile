pmn:= pmn.sif
pmn-base:= pmn-base.sif
pmn-deps:= pmn-deps.sif
SINGULARITY_TMPDIR=${SINGULARITY_TMPDIR-$PWD/tmp}
SINGULARITY=singularity
ifneq ($(EUID), 0)
	BUILD_FLAGS = --fakeroot
endif
pmn.sif: pmn.def pmn-base.sif
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn.sif pmn.def

pmn-base.sif: pmn-base.def pmn-deps.sif
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn-base.sif pmn-base.def

pmn-deps.sif: pmn-deps.def
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn-deps.sif pmn-deps.def

pmn-ptools.sif: pmn.sif pmn-ptools.def
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn-ptools.sif pmn-ptools.def

shell: pmn.sif
	$(SINGULARITY) shell pmn.sif
