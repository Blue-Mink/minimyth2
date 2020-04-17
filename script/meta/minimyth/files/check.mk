GARNAME    ?= minimyth
GARVERSION ?= $(mm_VERSION)

all: mm-all

GAR_EXTRA_CONF += kernel/linux-$(mm_KERNEL_VERSION)/package-api.mk devel/build-system-bins/package-api.mk
include ../../gar.mk

mm-all:
	@echo "checking ..."
	@# Check build environment.
	@echo "  build system binaries ..."
	@$(foreach pkg,$(build_system_bins), \
		$(foreach bin,$(sort $(build_system_bins_$(subst -,_,$(pkg)))), \
			echo "    '$(bin)' (from package '$(pkg)')" ; \
			which $(bin) > /dev/null 2>&1 ; \
			if [ ! "$$?" = "0" ] ; then \
				echo "error: your system does not contain the program '$(bin)' (from package '$(pkg)')." ; \
				echo "exit 1" ; \
			fi ; \
		) \
	)
	@echo "  build user uid and gid"
	@if [ `id -u` -eq 0 ] || [ `id -g` -eq 0 ] ; then \
		echo "error: gar-minimyth cannot be run by the user 'root'." ; \
		exit 1 ; \
	fi
	@echo "  / and /usr directory access"
	@for dir in /          /lib                              /bin           /sbin \
	            /usr       /usr/lib       /usr/libexec       /usr/bin       /usr/sbin \
	            /usr/local /usr/local/lib /usr/local/libexec /usr/local/bin /usr/local/sbin\
	            /opt ; do \
		if [ -e "$${dir}" ] && [ -w "$${dir}" ] ; then \
			echo "error: gar-minimyth cannot be run by a user with write access to '$${dir}'." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "  build system binaries ... done"
	@# Check build parameters.
	@echo "  build parameters ..."
	@echo "    HOME"
	@echo "    mm_GARCH"
	@if [ ! "$(mm_GARCH)" = "pentium-mmx" ] && \
	    [ ! "$(mm_GARCH)" = "armv7"       ] && \
	    [ ! "$(mm_GARCH)" = "armv8"       ] && \
	    [ ! "$(mm_GARCH)" = "x86-64"      ] ; then \
		echo "error: mm_GARCH=\"$(mm_GARCH)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_HOME"
	@if [ ! "$(mm_HOME)" = "`cd $(GARDIR)/.. ; pwd`" ] ; then \
		echo "error: mm_HOME must be set to \"`cd $(GARDIR)/.. ; pwd`\" but has been set to \"$(mm_HOME)\"."; \
		exit 1 ; \
	fi
	@if [ "$(firstword $(strip $(subst /, ,$(mm_HOME))))" = "$(firstword $(strip $(subst /, ,$(qt5prefix))))" ] ; then \
		echo "error: MiniMyth cannot be built in a subdirectory of \"/$(firstword $(strip $(subst /, ,$(qt5prefix))))\"."; \
		exit 1 ; \
	fi
	@if [ "$(firstword $(strip $(subst /, ,$(mm_HOME))))" = "$(firstword $(strip $(subst /, ,$(qt4prefix))))" ] ; then \
		echo "error: MiniMyth cannot be built in a subdirectory of \"/$(firstword $(strip $(subst /, ,$(qt4prefix))))\"."; \
		exit 1 ; \
	fi
	@echo "    mm_DEBUG"
	@if [ ! "$(mm_DEBUG)" = "yes" ] && [ ! "$(mm_DEBUG)" = "no" ] ; then \
		echo "error: mm_DEBUG=\"$(mm_DEBUG)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DEBUG_BUILD"
	@if [ ! "$(mm_DEBUG_BUILD)" = "yes" ] && [ ! "$(mm_DEBUG_BUILD)" = "no" ] ; then \
		echo "error: mm_DEBUG_BUILD=\"$(mm_DEBUG_BUILD)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_GRAPHICS"
	@for graphic in $(mm_GRAPHICS) ; do \
		if [ ! "$${graphic}" = "intel"         ] && \
		   [ ! "$${graphic}" = "nvidia"        ] && \
		   [ ! "$${graphic}" = "nvidia-legacy" ] && \
		   [ ! "$${graphic}" = "radeon"        ] && \
		   [ ! "$${graphic}" = "radeonhd"      ] && \
		   [ ! "$${graphic}" = "armsoc"        ] && \
		   [ ! "$${graphic}" = "meson"         ] && \
		   [ ! "$${graphic}" = "rockchip"      ] && \
		   [ ! "$${graphic}" = "sun4i"         ] && \
		   [ ! "$${graphic}" = "vc4"           ] && \
		   [ ! "$${graphic}" = "vmware"        ] ; then \
			echo "error: mm_GRAPHICS=\"$${graphic}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "    mm_OPENGL_PROVIDER"
	@for opengl in $(mm_OPENGL_PROVIDER) ; do \
		if [ ! "$${opengl}" = "lima"            ] && \
		   [ ! "$${opengl}" = "mali450-dummy"   ] && \
		   [ ! "$${opengl}" = "mali450-fbdev"   ] && \
		   [ ! "$${opengl}" = "mali450-wayland" ] && \
		   [ ! "$${opengl}" = "mali450-x11"     ] && \
		   [ ! "$${opengl}" = "brcm-vc4"        ] && \
		   [ ! "$${opengl}" = "mesa-git"        ] && \
		   [ ! "$${opengl}" = "mesa"            ] ; then \
			echo "error: mm_OPENGL_PROVIDER=\"$${opengl}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "    mm_SOFTWARE"
	@for software in $(mm_SOFTWARE) ; do \
		if [ ! "$${software}" = "mythplugins"    ] && \
		   [ ! "$${software}" = "mplayer-svn"    ] && \
		   [ ! "$${software}" = "mplayer"        ] && \
		   [ ! "$${software}" = "mpv"            ] && \
		   [ ! "$${software}" = "vlc"            ] && \
		   [ ! "$${software}" = "perl"           ] && \
		   [ ! "$${software}" = "python"         ] && \
		   [ ! "$${software}" = "airplay"        ] && \
		   [ ! "$${software}" = "avahi"          ] && \
		   [ ! "$${software}" = "udisks"         ] && \
		   [ ! "$${software}" = "mc"             ] && \
		   [ ! "$${software}" = "dvdcss"         ] && \
		   [ ! "$${software}" = "bdaacs"         ] && \
		   [ ! "$${software}" = "makemkv"        ] && \
		   [ ! "$${software}" = "voip"           ] && \
		   [ ! "$${software}" = "bumblebee"      ] && \
		   [ ! "$${software}" = "gstreamer"      ] && \
		   [ ! "$${software}" = "chrome"         ] && \
		   [ ! "$${software}" = "firefox"        ] && \
		   [ ! "$${software}" = "lcdproc"        ] && \
		   [ ! "$${software}" = "jzintv"         ] && \
		   [ ! "$${software}" = "mame"           ] && \
		   [ ! "$${software}" = "mednafen"       ] && \
		   [ ! "$${software}" = "stella"         ] && \
		   [ ! "$${software}" = "visualboyadvance" ] &&  \
		   [ ! "$${software}" = "ipxe"           ] && \
		   [ ! "$${software}" = "bootloader"     ] && \
		   [ ! "$${software}" = "glmark2"        ] && \
		   [ ! "$${software}" = "kmscube"        ] && \
		   [ ! "$${software}" = "mesa-demos"     ] && \
		   [ ! "$${software}" = "ffmpeg-drm"     ] && \
		   [ ! "$${software}" = "debug"          ] ; then \
			echo "error: mm_SOFTWARE=\"$${software}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "    mm_KERNEL_VERSION"
	@if [ ! "$(mm_KERNEL_VERSION)" = "5.6"           ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "5.7"           ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "5.8"           ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "5.9"           ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "rpi-4.19"      ] ; then \
		echo "error: mm_KERNEL_VERSION=\"$(mm_KERNEL_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_MYTH_VERSION"
	@if [ ! "$(mm_MYTH_VERSION)" = "29"         ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "30"         ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "31"           ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "32"           ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "master"       ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "test"         ] ; then \
		echo "error: mm_MYTH_VERSION=\"$(mm_MYTH_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_NVIDIA_VERSION"
	@if [ ! "$(mm_NVIDIA_VERSION)" = "440.64"    ] && \
	    [ ! "$(mm_NVIDIA_VERSION)" = "440.84"    ] ; then \
		echo "error: mm_NVIDIA_VERSION=\"$(mm_NVIDIA_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_NVIDIA_LEGACY_VERSION"
	@if [ ! "$(mm_NVIDIA_LEGACY_VERSION)" = "340.108"    ] && \
	    [ ! "$(mm_NVIDIA_LEGACY_VERSION)" = "340.109"    ] ; then \
		echo "error: mm_NVIDIA_LEGACY_VERSION=\"$(mm_NVIDIA_LEGACY_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_XORG_VERSION"
	@if [ ! "$(mm_XORG_VERSION)" = "7.6" ] && \
	    [ ! "$(mm_XORG_VERSION)" = "7.7" ] ; then \
		echo "error: mm_XORG_VERSION=\"$(mm_XORG_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "  build parameters ... done"
	@# Check build system parameters.
	@echo "  build system parameters ..."
	@if [ ! "$(build_GARCH_FAMILY)" = "i386"   ] && \
            [ ! "$(build_GARCH_FAMILY)" = "x86_64" ] ; then \
		echo "error: build_GARCH_FAMILY=\"$(build_GARCH_FAMILY)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@# Check distribution parameters.
	@echo "  distribution parameters ..."
	@echo "    mm_DISTRIBUTION_RAM"
	@if [ ! "$(mm_DISTRIBUTION_RAM)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_RAM)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_RAM=\"$(mm_DISTRIBUTION_RAM)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_NFS"
	@if [ ! "$(mm_DISTRIBUTION_NFS)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_NFS)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_NFS=\"$(mm_DISTRIBUTION_NFS)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_SDCARD"
	@if [ ! "$(mm_DISTRIBUTION_SDCARD)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_SDCARD)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_SDCARD=\"$(mm_DISTRIBUTION_SDCARD)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_SHARE"
	@if [ ! "$(mm_DISTRIBUTION_SHARE)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_SHARE)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_SHARE=\"$(mm_DISTRIBUTION_SHARE)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_RAM_BOOT"
	@# Check install parameters.
	@if [ ! "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ ! "$(mm_INSTALL_RAM_BOOT)" = "no" ] ; then \
		echo "error: mm_INSTALL_RAM_BOOT=\"$(mm_INSTALL_RAM_BOOT)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_NFS_BOOT"
	@if [ ! "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! "$(mm_INSTALL_NFS_BOOT)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS_BOOT=\"$(mm_INSTALL_NFS_BOOT)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! -d "$(mm_NFS_ROOT)"  ] ; then \
		echo "error: the directory specified by mm_NFS_ROOT=\"$(mm_NFS_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_RAM"
	@if [ "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_RAM)" = "no" ] ; then \
		echo "error: mm_INSTALL_RAM_ROOT=\"yes\" but mm_DISTRIBUTION_RAM=\"no\"." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_NFS"
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_NFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS_ROOT=\"yes\" but mm_DISTRIBUTION_NFS=\"no\"." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_SDCARD"
	@if [ ! "$(mm_DISTRIBUTION_SDCARD)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_SDCARD)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_SDCARD=\"$(mm_DISTRIBUTION_SDCARD)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_DISTRIBUTION_SDCARD)" = "yes" ] && [ ! -d "$(mm_SDCARD_FILES)" ] ; then \
		echo "error: the directory specified by mm_SDCARD_FILES=\"$(mm_SDCARD_FILES)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_BOARD_TYPE"
	@for board in $(mm_BOARD_TYPE) ; do \
		if [ ! "$${board}" = "board-g12"               ] && \
		   [ ! "$${board}" = "board-h6.beelink_gs1"    ] && \
		   [ ! "$${board}" = "board-h6.eachlink_mini"  ] && \
		   [ ! "$${board}" = "board-h6.tanix_tx6"      ] && \
		   [ ! "$${board}" = "board-rk3328.beelink_a1" ] && \
		   [ ! "$${board}" = "board-rk3399.rockpi4-b"  ] && \
		   [ ! "$${board}" = "board-rpi2"              ] && \
		   [ ! "$${board}" = "board-rpi3.mainline32"   ] && \
		   [ ! "$${board}" = "board-rpi3.mainline64"   ] && \
		   [ ! "$${board}" = "board-rpi3.rpi32"        ] && \
		   [ ! "$${board}" = "board-s905"              ] && \
		   [ ! "$${board}" = "board-s912"              ] && \
		   [ ! "$${board}" = "board-sm1"               ] && \
		   [ ! "$${board}" = "board-x86pc.bios"        ] && \
		   [ ! "$${board}" = "board-x86pc.bios_efi64"  ] && \
		   [ ! "$${board}" = "board-x86pc.efi64"       ] ; then \
			echo "error: mm_BOARD_TYPE=\"$${board}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "  distribution parameters ... done"
	@echo "checking ... done"

.PHONY: all mm-all
