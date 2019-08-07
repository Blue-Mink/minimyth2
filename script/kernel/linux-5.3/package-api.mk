#--Use this for mainline x.y.z kernel-------
ifeq (0,1)
LINUX_MAJOR_VERSION = 5
LINUX_MINOR_VERSION = 2
LINUX_TEENY_VERSION = 3
LINUX_EXTRA_VERSION = 
endif
#-------------------------------------------

#--Use this for rc mainline x.y.z kernel----
ifeq (1,1)
LINUX_MAJOR_VERSION = 5
LINUX_MINOR_VERSION = 3
LINUX_TEENY_VERSION = 
LINUX_EXTRA_VERSION = -rc3
endif
#-------------------------------------------

#--Use this for mainline git-commit kernel--
ifeq (0,1)
GITHASH             = 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
LINUX_MAJOR_VERSION = 4
LINUX_MINOR_VERSION = 20
LINUX_TEENY_VERSION = 0
LINUX_EXTRA_VERSION = 
endif
#-------------------------------------------


LINUX_VERSION      = $(LINUX_MAJOR_VERSION).$(LINUX_MINOR_VERSION)$(if $(LINUX_TEENY_VERSION),.$(LINUX_TEENY_VERSION))$(LINUX_EXTRA_VERSION)
LINUX_FULL_VERSION = $(LINUX_MAJOR_VERSION).$(LINUX_MINOR_VERSION)$(if $(LINUX_TEENY_VERSION),.$(LINUX_TEENY_VERSION),.0)$(LINUX_EXTRA_VERSION)

LINUX_DIR           = $(rootdir)/boot
LINUX_MODULESPREFIX = $(rootdir)/lib/modules
LINUX_MODULESDIR    = $(LINUX_MODULESPREFIX)/$(LINUX_FULL_VERSION)
LINUX_SOURCEDIR     = $(LINUX_MODULESDIR)/source
LINUX_BUILDDIR      = $(LINUX_MODULESDIR)/build

LINUX_MAKEFILE = $(DESTDIR)$(LINUX_SOURCEDIR)/Makefile

LINUX_MAKE_ARGS = \
	ARCH="$(GARCH_FAMILY)" \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	CROSS_COMPILE="$(compiler_prefix)" \
	$(PARALLELMFLAGS)

LINUX_MAKE_ENV = \
	KBUILD_VERBOSE="0"
