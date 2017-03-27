require weston.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH = "rcar-gen3/1.11.0/gl-fallback"

SRCREV = "1a8e5cd9e2e100d100e076dba3d937a5dc60093d"

SRC_URI_remove = "https://wayland.freedesktop.org/releases/${BPN}-${PV}.tar.xz"

SRC_URI_append = " \
    git://github.com/renesas-rcar/weston.git;branch=${BRANCH} \
"

S = "${WORKDIR}/git"

PACKAGECONFIG_append = " \
    ${@base_conditional('USE_MULTIMEDIA', '1', ' v4l2', '', d)} \
"
PACKAGECONFIG[v4l2] = " --enable-v4l2, --disable-v4l2,,kernel-module-vsp2driver"
