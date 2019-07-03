inherit bundle

RAUC_BUNDLE_COMPATIBLE = "${MACHINE}"

RAUC_BUNDLE_SLOTS = "rootfs"

RAUC_SLOT_rootfs = "agl-demo-platform"

RAUC_KEY_FILE := "${THISDIR}/files/rauc-sample.key.pem"
RAUC_CERT_FILE := "${THISDIR}/files/rauc-sample.cert.pem"
