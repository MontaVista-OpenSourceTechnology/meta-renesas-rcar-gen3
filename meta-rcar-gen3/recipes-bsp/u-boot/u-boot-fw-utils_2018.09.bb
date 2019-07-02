require u-boot-common_${PV}.inc

SUMMARY = "U-Boot bootloader fw_printenv/setenv utilities"

UBOOT_URL = "git://github.com/renesas-rcar/u-boot.git"
BRANCH = "v2018.09/rcar-3.9.3"

SRC_URI = "${UBOOT_URL};branch=${BRANCH}"
SRCREV = "2b858f59e82177c8aba621b26629d797db2b7cc7"
PV = "2018.09"

COMPATIBLE_MACHINE = "(salvator-x|ebisu|ulcb)"
DEPENDS = "mtd-utils"

INSANE_SKIP_${PN} = "already-stripped"
EXTRA_OEMAKE_class-target = 'CROSS_COMPILE=${TARGET_PREFIX} CC="${CC} ${CFLAGS} ${LDFLAGS}" HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}" V=1'
EXTRA_OEMAKE_class-cross = 'HOSTCC="${CC} ${CFLAGS} ${LDFLAGS}" V=1'

inherit uboot-config

do_compile () {
	oe_runmake ${UBOOT_MACHINE}
	oe_runmake envtools
}

ENVADDR_h3ulcb = "/dev/mmcblk0boot1    0x07e0000    0x20000    0x20000"
ENVADDR_m3ulcb = "/dev/mmcblk0boot1    0x07e0000    0x20000    0x20000"
ENVADDR_m3nulcb = "/dev/mmcblk0boot1    0x1fc0000    0x20000    0x20000"

do_install () {
	install -d ${D}${base_sbindir}
	install -d ${D}${sysconfdir}
	install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_printenv
	install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_setenv
	install -m 0644 ${S}/tools/env/fw_env.config ${D}${sysconfdir}/fw_env.config
    # Set the env address in emmc
	sed 's|^/|#/|' -i ${D}${sysconfdir}/fw_env.config
    echo ${ENVADDR} >> ${D}${sysconfdir}/fw_env.config
}

do_install_class-cross () {
	install -d ${D}${bindir_cross}
	install -m 755 ${S}/tools/env/fw_printenv ${D}${bindir_cross}/fw_printenv
	install -m 755 ${S}/tools/env/fw_printenv ${D}${bindir_cross}/fw_setenv
}

SYSROOT_DIRS_append_class-cross = " ${bindir_cross}"

PACKAGE_ARCH = "${MACHINE_ARCH}"
BBCLASSEXTEND = "cross"