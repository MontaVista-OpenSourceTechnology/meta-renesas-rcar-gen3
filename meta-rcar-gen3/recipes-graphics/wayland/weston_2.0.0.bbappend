require weston.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH = "rcar-gen3/2.0.0/gl-fallback"

SRCREV = "27546e90d8c06717ec9c1244520ebb237d7b5118"

SRC_URI_remove = "https://wayland.freedesktop.org/releases/${BPN}-${PV}.tar.xz"

SRC_URI_append = " \
    git://github.com/renesas-rcar/weston.git;branch=${BRANCH} \
    file://weston.png \
    file://weston.desktop \
    file://xwayland.weston-start \
    file://weston_v4l2.ini \
"

S = "${WORKDIR}/git"

PACKAGECONFIG_append = " \
    ${@base_conditional('USE_MULTIMEDIA', '1', ' v4l2', '', d)} \
"
PACKAGECONFIG[v4l2] = " --enable-v4l2, --disable-v4l2,,kernel-module-vsp2driver"


