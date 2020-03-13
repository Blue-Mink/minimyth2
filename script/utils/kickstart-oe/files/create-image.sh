
use_minimyth_python3="no"

#--------------------------------------------------------------------------------------

mm_conf_file="${HOME}/.minimyth2/minimyth.conf.mk"

boards=$1

if [ x${board} = "x" ] ; then
    boards=`  grep "^mm_BOARD_TYPE "       ${mm_conf_file} | sed -e 's/.*\?=//'`
fi

branch=` grep "^mm_MYTH_VERSION "     ${mm_conf_file} | sed -e 's/.*\?=*\s//'`
version=`grep "^mm_VERSION_MINIMYTH " ${mm_conf_file} | sed -e 's/.*\?=*\s//'`
arch=`   grep "^mm_GARCH "            ${mm_conf_file} | sed -e 's/.*\?=*\s//'`
mm_home=`grep "^mm_HOME "             ${mm_conf_file} | sed -e 's/.*\?=*\s//'`
mm_debug=`grep "^mm_DEBUG "           ${mm_conf_file} | sed -e 's/.*\?=*\s//' -e 's/"//g'`

base_dir=${mm_home}/images/build/usr/bin/kickstart
if [ x${mm_debug} = "xyes" ] ; then
    mm_build_dir=${mm_home}/script/meta/minimyth/work/main.d/minimyth-${branch}-${version}-debug/build
else
    mm_build_dir=${mm_home}/script/meta/minimyth/work/main.d/minimyth-${branch}-${version}/build
fi
root_files_loc=${mm_build_dir}/stage/image/rootfs
boot_files_loc=${mm_build_dir}/stage/boot

export BUILDDIR=${mm_build_dir}/stage
export BBPATH=${base_dir}
export PATH=${base_dir}/bitbake/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PYTHONPATH=${base_dir}/bitbake/lib:${PYTHONPATH}

if [ x${use_minimyth_python3} = "xyes" ] ; then 
    export PATH=${mm_home}/images/build/bin:${mm_home}/images/build/usr/bin:${PATH}
    export PYTHONPATH=${mm_home}/images/build/usr/lib/python3.7:${PYTHONPATH}
    export PYTHON=${mm_home}/images/build/usr/bin/python3
    export LD_LIBRARY_PATH=${mm_home}/images/build/usr/lib
else
    export PYTHON=/usr/bin/python3
fi

rm -f ${base_dir}/conf/multiconfig/default.conf
echo "IMAGE_BOOT_FILES ?= \" \"" > ${base_dir}/conf/multiconfig/default.conf
echo "" >> ${base_dir}/conf/multiconfig/default.conf
boards_list=""
rm -f ${base_dir}/MiniMyth2.wks
echo "#----Entries to raw-copy SPL, bootloader, etc " > ${base_dir}/MiniMyth2.wks

for board in ${boards} ; do
    echo "  adding "${board}" to default.config & MiniMyth2.wks"
    cat ${base_dir}/conf/multiconfig/${board}.conf >> ${base_dir}/conf/multiconfig/default.conf
    boards_list=${board}-${boards_list}
    cat ${base_dir}/${board}.wks >> ${base_dir}/MiniMyth2.wks
done
echo "#----Entries to create boot & rootfs partitions" >> ${base_dir}/MiniMyth2.wks

# Skip adding common (for multibords) .wks entries when board is x86pc
if [ -z `echo ${boards} | grep -o "board-x86pc"` ] ; then
    cat ${base_dir}/default.wks >> ${base_dir}/MiniMyth2.wks
fi

sed -i "s%@MM_HOME@%${mm_home}%g" ${base_dir}/MiniMyth2.wks

echo "  boards        : ${boards_list}"
echo "  mm2 home dir  : [${mm_home}]"
echo "  boot files    : [${boot_files_loc}]"
echo "  rootfs files  : [${root_files_loc}]"

cd ${BUILDDIR}
rm -f  ${BUILDDIR}/*.log
rm -f  ${BUILDDIR}/*.direct
rm -f  ${BUILDDIR}/*.vfat
rm -f  ${BUILDDIR}/*.ext4
rm -rf ${root_files_loc}/../pseudo*
# By some reason (bug?) kickstart-oe expects pseudo binary in working tem dir...
mkdir -p ${mm_build_dir}/stage/tmp/sysroots-components/x86_64/pseudo-native/usr/bin
ln -srf ${mm_home}/images/build/usr/bin/pseudo ${mm_build_dir}/stage/tmp/sysroots-components/x86_64/pseudo-native/usr/bin/pseudo

echo '  entering fakeroot enviroment...'
fakeroot -i ${mm_build_dir}/stage/image/rootfs.fakeroot sh -c " \
echo '  WIC output:'
${PYTHON} ${base_dir}/scripts/wic create ${base_dir}/MiniMyth2.wks \
--bootimg-dir=${boot_files_loc} \
--kernel-dir=${boot_files_loc} \
--rootfs-dir=${root_files_loc} \
--native-sysroot=${mm_home}/images/build \
"
#--debug \

echo '  removing working files...'
rm -rf ${root_files_loc}/../pseudo*

echo '  copmpressing SD image...'
rename MiniMyth2-*.direct MiniMyth2-${arch}-${branch}-${version}-${boards_list}SD-Image.img *
bzip2 -zf MiniMyth2-${arch}-${branch}-${version}-${boards_list}SD-Image.img

echo '  SD image creation done!'
echo "  Image is here:${BUILDDIR}/MiniMyth2-${arch}-${branch}-${version}-${boards_list}SD-Image.img.bz2"

exit 0
