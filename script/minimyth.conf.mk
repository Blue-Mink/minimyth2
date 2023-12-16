#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth2/minimyth.conf.mk'
#-------------------------------------------------------------------------------

-include $(HOME)/.minimyth2/minimyth.conf.mk

# Indicates the directory where the GAR MiniMyth build system is installed.
mm_HOME                   ?= /home/minimyth/minimyth2

# The version of MiniMyth2.
mm_VERSION_MINIMYTH ?=       12.21.1.r596

# The version of Myth to use.
# Valid values are '32', '33', 'master' and 'test'
mm_MYTH_VERSION           ?= master

# Lists the software to be included in image.
# Valid values for MM_SOFTWARE are zero or more of list below:
mm_SOFTWARE               ?= \
                            python3 \
                            perl \
                            mythfrontend \
                            mythplugins \
                            airplay \
                            avahi \
                            udisks2 \
                            dvdcss \
                            gstreamer \
                            mc \
                            lcdproc \
                            voip \
                            makemkv \
                            connman \
                            weston \
                            iwd \
                            bootloader \
                            openvfd \
                            monitorix \
                            $(if $(filter $(mm_DEBUG),yes),debug)

#                             mythnetvision \
#                             mythwebbrowser \
#                             udisks1 \
#                             mednafen \
#                             stella \
#                             jzintv \
#                             mame \
#                             stella \
#                             visualboyadvance \
#                             bumblebee \
#                             mplayer-svn \
#                             netflix \
#                             ipxe \
#                             gdb \
#                             apitrace \
#                             valgrind \
#                             xscreensaver \
#                             kodi \
#                             termbin \
#                             kmsvnc \
#                             nvtop \

# Indicates bootloader board type. Valid values are:
# 'board-rpi2'
# 'board-rpi3.mainline32'
# 'board-rpi3.mainline64'
# 'board-rpi3.rpi32'
# 'board-rpi4.mainline64'
# 'board-rpi34.mainline64'
# 'board-rpi4.rpi32'
# 'board-rpi4.rpi64'
# 'board-s905'
# 'board-s912'
# 'board-g12.radxa_zero'
# 'board-sm1.x96_air2g'
# 'board-sm1.tanix_tx5_plus'
# 'board-rk3328.beelink_a1'
# 'board-rk3399.rockpi4-b'
# 'board-rk3399.rockpi4-se'
# 'board-rk3399.orangepi_4'
# 'board-rk3399.orangepi_4_lts'
# 'board-rk3528.vontar_r3'
# 'board-rk3566.x96_x6'
# 'board-rk3566.quartz64-b'
# 'board-rk3566.urve-pi'
# 'board-rk3568.rock3-a'
# 'board-rk3568.rock3-b'
# 'board-rk3566.rock3-c'
# 'board-rk3566.orangepi_3b'
# 'board-rk3588.rock5-b
# 'board-rk3588.orangepi_5_plus'
# 'board-rk3588s.rock5-a
# 'board-rk3588s.orangepi_5'
# 'board-h6.beelink_gs1'
# 'board-h6.eachlink_mini'
# 'board-h6.tanix_tx6'
# 'board-h6.tanix_tx6_mini'
# 'board-h6.orangepi_3'
# 'board-h6.orangepi_3_lts'
# 'board-h616.tanix_tx6s'
# 'board-h616.tanix_tx6s_lpddr3'
# 'board-h616.tanix_tx6s_axp313'
# 'board-h616.t95'
# 'board-h616.x96_mate'
# 'board-h616.orangepi_zero2'
# 'board-h616.pendoo_x12pro'
# 'board-h618.orangepi_zero3'
# 'board-h618.vontar_h618'
# 'board-h618.orangepi_zero2w'
# 'board-h313.x96_q'
# 'board-h313.x96_q_lpddr3'
# 'board-h313.x96_q_lpddr3_v1.3'
# 'board-x86pc.bios'
# 'board-x86pc.efi64'
# 'board-x86pc.bios_efi64'
# Note: some combinations for multiboard are not allowed.
# (due bootloader or architecture conflict):
# 1. 'board-rpi3*' and 'board-rk3328'
# 2. 'board-h6' and 'board-rk3328'
# 3. 'board-rpi2' and 'board-*'
# 4. 'board-s*' and 'board-s*' or 'board-g12'
# 5. Any multiple H6 boards combination
mm_BOARD_TYPE             ?= board-x86pc.bios_efi64

# Indicates whether or not to create the share distribution. Share distribution
# is full set of files generated by build process. Set of this files will be
# installed in mm_SHARE_FILES location by install process
mm_DISTRIBUTION_SHARE     ?= no

# Indicates where to put DISTRIBUTION_SHARE files
mm_SHARE_FILES            ?= ${HOME}/build/share/$(mm_GARCH_FAMILY)/$(mm_MYTH_VERSION)

# Indicates whether or not to instal files for on-line updates. Set of this files will be
# installed in mm_ONLINE_UPDATES location by install process
mm_INSTALL_ONLINE_UPDATES ?= no

# Indicates where to put mm_ONLINE_UPDATES files
mm_ONLINE_UPDATES         ?= ${HOME}/build/online-updates/$(mm_GARCH_FAMILY)/$(mm_MYTH_VERSION)

# Indicates whether or not to create the RAM based part of the share distribution.
mm_DISTRIBUTION_RAM       ?= yes

# Indicates whether or not to install the MiniMyth files needed to network boot
# with a RAM root file system. This will cause files to be installed in
# directory $(mm_TFTP_ROOT)/$(mm_VERSION_MINIMYTH)/
# Valid values for mm_INSTALL_RAM_BOOT are 'yes' and 'no'.
mm_INSTALL_RAM_BOOT       ?= no

# Indicates the pxeboot TFTP directory.
# The MiniMyth kernel, the MiniMyth file system image and MiniMyth themes are
# installed in this directory. The files will be installed in a subdirectory
# named '$(mm_VERSION_MINIMYTH)'.
mm_TFTP_ROOT              ?= ${HOME}/build/tftp/$(mm_GARCH_FAMILY)

# Indicates whether or not to create the NFS based part of the share distribution.
mm_DISTRIBUTION_NFS       ?= no

# Indicates whether or not to install the MiniMyth files needed to network boot
# with an NFS root file system. This will cause files to be installed in
# $(mm_NFS_ROOT)/nfs-$(mm_GARCH_FAMILY)-minimyth2-$(mm_VERSION).
# Valid values for mm_INSTALL_NFS_BOOT are 'yes' and 'no'.
mm_INSTALL_NFS_BOOT       ?= no

# Indicates the directory in which the directory containing the MiniMyth root
# file system for mounting using NFS. The MiniMyth root file system will be
# installed in a subdirectory named 'nfs-$(mm_GARCH_FAMILY)-minimyth2-$(mm_VERSION)'.
mm_NFS_ROOT               ?= ${HOME}/build

# Indicates whether or not to create the SD card image. Generated image will
# be installed in mm_SDCARD_FILES location by install process
mm_DISTRIBUTION_SDCARD    ?= no

# Indicates the directory in which SD Card image will be installed.
mm_SDCARD_FILES           ?= ${HOME}/build

# Indicates whether or not to enable debugging in the image.
# Valid values for mm_DEBUG are 'yes' and 'no'.
mm_DEBUG                  ?= no

# Indicates whether or not to enable debugging in the build system.
# Valid values for mm_DEBUG_BUILD are 'yes' and 'no'.
mm_DEBUG_BUILD            ?= no

# Indicates whether or not to strip libs, perl and python in build image.
# Valid values for mm_STRIP_IMAGE are 'yes' and 'no'.
mm_STRIP_IMAGE            ?= yes

#-------------------------------------------------------------------------------
# Variables defining key version of software components.
#-------------------------------------------------------------------------------

# Indicates the microprocessor architecture.
# Valid values for mm_GARCH are 'pentium-mmx', 'x86-64', 'armv7', 'armv8'.
mm_GARCH                  ?= x86-64

# Lists the graphics drivers supported.
# Valid values for mm_GRAPHICS are one or more of:
# 'intel'
# 'nvidia'
# 'nvidia-legacy'
# 'radeon'
# 'vmware'
# 'nouveau'
# 'meson'
# 'rockchip'
# 'sun4i'
# 'vc4'
mm_GRAPHICS               ?= intel nouveau radeon vmware

# Selects OpenGL provider used by qt and mythtv. Valid values for
# mm_OPENGL_PROVIDER are:.
# 'mesa' (official mesa library),
# 'mesa-git' (mesa code from git),
mm_OPENGL_PROVIDER        ?= mesa

# Selects Qt version used by mythtv. Valid values for
# mm_QT_VERSION are:
# 'qt5',
# 'qt6',
mm_QT_VERSION             ?= qt5

# Selects Python version used by mythtv. Valid values for
# mm_PYTHON_VERSION are:
# 'py2',
# 'py3',
mm_PYTHON_VERSION         ?= py3

# Selects shell used by MiniMyth2. Valid values for
# mm_SHELL are:
# 'busybox',
# 'bash',
# 'dash',
mm_SHELL                  ?= busybox

# The version of kernel to use.
# Valid values are: '6.5' '6.6'
mm_KERNEL_VERSION         ?= 6.6

# The kernel configuration file to use.
# When set, the kernel configuration file $(HOME)/.minimyth/$(mm_KERNEL_CONFIG) will be used.
# When not set, a built-in kernel configuration file will be used.
mm_KERNEL_CONFIG          ?=

# Valid values are '440.44'
mm_NVIDIA_VERSION         ?= 470.63

# The version of the NVIDIA legacy driver.
# Valid values are '340.108'
mm_NVIDIA_LEGACY_VERSION  ?= 340.108

# The version of xorg to use.
# Valid values are '7.6'.
mm_XORG_VERSION           ?= 7.6

# Lists additional packages to build when minimyth is built.
mm_USER_PACKAGES          ?=

# Lists additional binaries to include in the MiniMyth image
# by adding to the lists found in minimyth-bin-list and bins-share-list
mm_USER_BIN_LIST          ?=

# Lists additional configs to include in the MiniMyth image
# by adding to the lists found in minimyth-etc-list and extras-etc-list
mm_USER_ETC_LIST          ?=

# Lists additional libraries to include in the MiniMyth image
# by adding to the lists found in minimyth-lib-list and extras-lib-list
mm_USER_LIB_LIST          ?=

# Lists additional data to include in the MiniMyth image
# by adding to the lists found in minimyth-share-list and extras-share-list
mm_USER_REMOVE_LIST       ?=

# Lists additional files to remove from the MiniMyth image
# by adding to the lists found in minimyth-remove-list*.
mm_USER_SHARE_LIST        ?=

#-------------------------------------------------------------------------------
# Variables that you are not likely to override.
#-------------------------------------------------------------------------------

mm_VERSION                ?= $(mm_VERSION_MYTH)-$(mm_VERSION_MINIMYTH)$(mm_VERSION_EXTRA)
mm_VERSION_MYTH           ?= $(strip \
                                $(if $(filter 32     ,      $(mm_MYTH_VERSION)),32                            ) \
                                $(if $(filter 33     ,      $(mm_MYTH_VERSION)),33                            ) \
                                $(if $(filter master ,      $(mm_MYTH_VERSION)),master                        ) \
                                $(if $(filter test   ,      $(mm_MYTH_VERSION)),test                          ) \
                              )

mm_VERSION_EXTRA          ?= $(strip \
                                $(if $(filter yes,$(mm_DEBUG)),-debug) \
                              )

# Configuration file (minimyth.conf) version.
mm_CONF_VERSION           ?= 48

# arch used by kerel arch
mm_GARCH_FAMILY           ?= $(strip \
                                 $(if $(filter pentium-mmx,$(mm_GARCH)),i386  ) \
                                 $(if $(filter x86-64     ,$(mm_GARCH)),x86_64) \
                                 $(if $(filter armv7      ,$(mm_GARCH)),arm   ) \
                                 $(if $(filter armv8      ,$(mm_GARCH)),arm64 ) \
                              )
# arch used by i.e. glibc
mm_GARHOST                ?= $(strip \
                                 $(if $(filter pentium-mmx,$(mm_GARCH)),i586-minimyth-linux-gnu        ) \
                                 $(if $(filter x86-64     ,$(mm_GARCH)),x86_64-minimyth-linux-gnu      ) \
                                 $(if $(filter armv7      ,$(mm_GARCH)),arm-minimyth-linux-gnueabi     ) \
                                 $(if $(filter armv8      ,$(mm_GARCH)),aarch64-minimyth-linux-gnu     ) \
                              )
mm_CFLAGS                 ?= $(strip \
                                 -pipe                                                                                        \
                                 $(if $(filter pentium-mmx ,$(mm_GARCH)),-march=pentium-mmx -mtune=generic              -O3 ) \
                                 $(if $(filter x86-64      ,$(mm_GARCH)),-march=x86-64 -mtune=generic -mfpmath=sse      -O3 ) \
                                 $(if $(filter armv7       ,$(mm_GARCH)),-mthumb -march=armv7-a+simd -mfloat-abi=softfp -O3 ) \
                                 $(if $(filter armv8       ,$(mm_GARCH)),-march=armv8-a+fp+simd                         -O3 ) \
                                 -flto                                                                                    \
                                 $(if $(filter i386  ,$(mm_GARCH_FAMILY)),-m32)                                           \
                                 $(if $(filter x86_64,$(mm_GARCH_FAMILY)),-m64)                                           \
                                 $(if $(filter yes,$(mm_DEBUG)),-g)                                                       \
                              )
mm_CXXFLAGS               ?= $(mm_CFLAGS)
mm_DESTDIR                ?= $(mm_HOME)/images/mm

# For ARM target MiniMyth2 GCC9.3 multi-lib capabilities allows to compile for
# following ARM target variants:
# -marm   -march=armv5te+fp   -mfloat-abi=softfp
# -mthumb -march=armv7-a      -mfloat-abi=soft
# -mthumb -march=armv7-a+fp   -mfloat-abi=softfp
# -mthumb -march=armv7-a+simd -mfloat-abi=softfp
# -mthumb -march=armv7ve+simd -mfloat-abi=softfp

#-------------------------------------------------------------------------------
# Variables that you cannot override.
#-------------------------------------------------------------------------------
# Set the language for gettext to English so the configure scripts for packages
# such as lib/libjpeg do not yield incorrect results.
LANGUAGE=en
export LANGUAGE

# Stop attempts to check out patches from perforce.
PATCH_GET=0
export PATCH_GET

# Set the number of parallel makes to the number of processors + 1.
CPUS=$(shell cat /proc/cpuinfo | grep -c '^processor[[:cntrl:]]*:')
PARALLELMFLAGS=-j$(shell expr $(CPUS) + 1)
XZ_DEFAULTS=-T $(CPUS)
export CPUS
export PARALLELMFLAGS
export XZ_DEFAULTS
