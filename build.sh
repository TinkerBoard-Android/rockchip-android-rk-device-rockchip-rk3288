#!/bin/bash

ARCH=arm
LUNCH=WW_Tinker_Board-userdebug
UBOOT_DEFCONFIG=rk3288_secure_defconfig
KERNEL_DEFCONFIG=rockchip_defconfig
KERNEL_DTS=rk3288-miniarm
JOBS=$(nproc)

usage()
{
    echo "USAGE: build [-ovj] [-n BUILD_NUMBER] [-d TARGET_FILES_OLD]"
    echo "-o                    -Generate ota package"
    echo "-v                    -Set build version name for output image folder"
    echo "-j                    -Build jobs"
    echo "-n                    -Set build number"
    echo "-d                    -Set old target files for delta package"
    exit 1
}

BUILD_NUMBER="eng"-"$(date  +%Y%m%d.%H%M)"
RELEASE_NAME=Tinker_Board-AndroidN-"$BUILD_NUMBER"

# check pass argument
while getopts "ov:j:n:d:" arg
do
    case $arg in
        o)
            echo "will build ota package"
            BUILD_OTA=true
            ;;
        v)
            BUILD_VERSION=$OPTARG
            ;;
        j)
            JOBS=$OPTARG
            ;;
	n)
            BUILD_NUMBER="$OPTARG"-"$(date  +%Y%m%d)"
            RELEASE_NAME=Tinker_Board-AndroidN-V"$BUILD_NUMBER"
            ;;
	d)
            TARGET_FILES_OLD=$OPTARG
	    ;;
        ?)
            usage ;;
    esac
done

source device/rockchip/common/build_base.sh -a $ARCH -l $LUNCH -u $UBOOT_DEFCONFIG -k $KERNEL_DEFCONFIG -d $KERNEL_DTS -j $JOBS -n $BUILD_NUMBER -r $RELEASE_NAME -e $TARGET_FILES_OLD
