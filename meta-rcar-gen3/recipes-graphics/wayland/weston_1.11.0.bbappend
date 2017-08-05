require weston.inc

DEPENDS_append = " gstreamer1.0"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH = "rcar-gen3/1.11.0/gl-fallback"

EXTRA_OECONF_append = " --enable-sys-uid"

SRCREV = "a9df84304f6fcf8025beae998adcc4b02d8b968e"

SRC_URI_remove = "https://wayland.freedesktop.org/releases/${BPN}-${PV}.tar.xz"

SRC_URI_append = " \
    git://github.com/renesas-rcar/weston.git;branch=${BRANCH} \
    file://0001-compositor-drm.c-Launch-without-input-devices.patch \ 
    file://0001-Allow-regular-users-to-launch-Weston.patch \
"

S = "${WORKDIR}/git"

PACKAGECONFIG_append = " \
    ${@base_conditional('USE_MULTIMEDIA', '1', ' v4l2', '', d)} \
"
PACKAGECONFIG[v4l2] = " --enable-v4l2, --disable-v4l2,,kernel-module-vsp2driver"
