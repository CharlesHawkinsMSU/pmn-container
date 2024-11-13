pmn-base:= pmn-base.sif
SINGULARITY?=singularity
ifneq ($(EUID), 0)
	BUILD_FLAGS = --fakeroot
endif

pmn-base.sif: pmn-base.def
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn-base.sif pmn-base.def

pmn-ptools.sif: pmn-base.sif pmn-ptools.def
	$(SINGULARITY) build $(BUILD_FLAGS) -F pmn-ptools.sif pmn-ptools.def
