SUMMARY = "Packages required to use with RAUC update"
LICENSE = "LGPLv2.1 & MIT"

COMPATIBLE_MACHINE = "(salvator-x|ebisu|ulcb)"

inherit packagegroup

DEPENDS = " \
    rauc \
    u-boot-rauc-script \
    u-boot-fw-utils \
    e2fsprogs \
"

PACKAGES = "rauc-packagegroup"

RDEPENDS_rauc-packagegroup = " \
    rauc \
    rauc-mark-good \
    u-boot-rauc-script \
    u-boot-fw-utils \
    e2fsprogs e2fsprogs-mke2fs \
"
