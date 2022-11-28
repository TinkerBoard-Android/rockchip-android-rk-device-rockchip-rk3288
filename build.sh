#!/bin/bash
ARCH=arm
LUNCH=WW_Tinker_Board-userdebug
UBOOT_DEFCONFIG=rk3288_secure_defconfig
KERNEL_DEFCONFIG=rockchip_defconfig
KERNEL_DTS=rk3288-miniarm
JOBS=$(nproc)

usage()
{
    echo "USAGE: build [-ovj] [-n BUILD_NUMBER] [-d PREVIOUS_TARGET-FILES_ZIPFILE]"
    echo "-o                    -Generate ota package"
    echo "-v                    -Set build version name for output image folder"
    echo "-j                    -Build jobs"
    echo "-n                    -Set the build number"
    echo "-d                    -Set the previous target-files zipfile to build the incremental update"
    exit 1
}

# check pass argument
while getopts "ovj:n:d:" arg
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
            ;;
	d)
            echo "Will build the ota package"
            BUILD_OTA=true
            PREVIOUS_TARGET_FILES=$OPTARG
	    ;;
        ?)
            usage ;;
    esac
done

source device/rockchip/common/build_base.sh -a $ARCH -l $LUNCH -u $UBOOT_DEFCONFIG -k $KERNEL_DEFCONFIG -d $KERNEL_DTS -j $JOBS
