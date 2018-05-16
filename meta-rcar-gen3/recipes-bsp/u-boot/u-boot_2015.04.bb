require recipes-bsp/u-boot/u-boot-common_${PV}.inc
require recipes-bsp/u-boot/u-boot.inc
require include/uboot-control.inc

DEPENDS += "dtc-native"

UBOOT_URL = "git://github.com/renesas-rcar/u-boot.git"
BRANCH = "v2015.04/rcar-3.6.2"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=c7383a594871c03da76b3707929d2919"

SRC_URI = "${UBOOT_URL};branch=${BRANCH}"
SRCREV = "fb858758470b6ca8e829c9ad455ecac3dbb9774c"

PV = "v2015.04+git${SRCPV}"

EXTRA_OEMAKE_append = " KCFLAGS=-fgnu89-inline"

# Add u-boot options for H3
EXTRA_OEMAKE_append_r8a7795 = " ${@get_uboot_config_opt(d)}"

UBOOT_SREC ?= "u-boot-elf.srec"
UBOOT_SREC_IMAGE ?= "u-boot-elf-${MACHINE}-${PV}-${PR}.srec"
UBOOT_SREC_SYMLINK ?= "u-boot-elf-${MACHINE}.srec"

do_deploy_append() {
    install -m 644 ${B}/${UBOOT_SREC} ${DEPLOYDIR}/${UBOOT_SREC_IMAGE}
    cd ${DEPLOYDIR}
    rm -f ${UBOOT_SREC} ${UBOOT_SREC_SYMLINK}
    ln -sf ${UBOOT_SREC_IMAGE} ${UBOOT_SREC_SYMLINK}
    ln -sf ${UBOOT_SREC_IMAGE} ${UBOOT_SREC}
}
