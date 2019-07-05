# U-oot bundle

inherit bundle

RAUC_BUNDLE_COMPATIBLE ?= "${@d.getVar('MACHINE')}"

RAUC_BUNDLE_SLOTS ?= "bootloader"

RAUC_SLOT_bootloader ?= "u-boot"
RAUC_SLOT_bootloader[type] ?= "boot"
RAUC_SLOT_bootloader[file] ?= "u-boot.bin"

RAUC_KEY_FILE = "${THISDIR}/files/rauc-sample.key.pem"
RAUC_CERT_FILE = "${THISDIR}/files/rauc-sample.cert.pem"
