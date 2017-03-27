require weston.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH = "rcar-gen3/1.11.0/gl-fallback"

SRCREV = "ef4fdad7fc6549493c244b6e657ec00565408497"

SRC_URI_remove = "https://wayland.freedesktop.org/releases/${BPN}-${PV}.tar.xz"

SRC_URI_append = " \
    git://github.com/renesas-rcar/weston.git;branch=${BRANCH} \
"

S = "${WORKDIR}/git"

PACKAGECONFIG_append = " \
    ${@base_conditional('USE_MULTIMEDIA', '1', ' v4l2', '', d)} \
"
PACKAGECONFIG[v4l2] = " --enable-v4l2, --disable-v4l2,,kernel-module-vsp2driver"
