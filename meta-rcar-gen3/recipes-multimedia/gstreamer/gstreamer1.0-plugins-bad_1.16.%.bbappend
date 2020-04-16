SRC_URI_remove = "https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${PV}.tar.xz"
SRC_URI_append = " gitsm://github.com/iotbzh/gst-plugins-bad.git;branch=RCAR-GEN3/1.16.2"

SRCREV = "7a90ae7df4dc8e39e417646ed3ef5c0ef2c30c7f"

DEPENDS += "weston"

S = "${WORKDIR}/git"

do_configure_prepend() {
    cd ${S}
    ./autogen.sh --noconfigure
    cd ${B}
}
