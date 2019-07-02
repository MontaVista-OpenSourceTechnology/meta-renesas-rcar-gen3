DESCRIPTION = "RAUC Sample U-Boot Script"
LICENSE = "MIT"
LIC_FILES_CHKSUM := "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE = "(salvator-x|ebisu|ulcb)"

S = "${WORKDIR}"

SRC_URI = " \
    file://rauc-ubootscript.txt \
"

DEPENDS += "u-boot-mkimage-native"

DEVICE_TREE_h3ulcb = "r8a7795-h3ulcb.dtb"
DEVICE_TREE_m3ulcb = "r8a7796-m3ulcb.dtb"
DEVICE_TREE_m3nulcb = "r8a77965-m3nulcb.dtb"
do_configure() {
    sed "s/@DEVICE_TREE@/${DEVICE_TREE}/g" -i ${S}/rauc-ubootscript.txt
}

do_compile(){
    mkimage -A arm -T script -C none -d ${S}/rauc-ubootscript.txt ${S}/rauc-ubootscript
}

do_install(){
    install -d ${D}${sysconfdir}/rauc/
    install -m 644 ${S}/rauc-ubootscript ${D}${sysconfdir}/rauc/rauc-ubootscript
}

RDEPENDS_${PN} = "rauc"
PACKAGES = "${PN}"

FILES_${PN} = " \
    ${sysconfdir}/rauc/rauc-ubootscript \
"
