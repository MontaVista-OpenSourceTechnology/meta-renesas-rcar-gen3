SRC_URI_remove = "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${PV}.tar.xz"
SRC_URI_append = " gitsm://github.com/iotbzh/gst-plugins-good.git;branch=RCAR-GEN3/1.16.2"

SRCREV = "f471dd242ea02b5fd238703b5962bb5879f89e62"

DEPENDS += "mmngrbuf-user-module"

S = "${WORKDIR}/git"

EXTRA_OECONF_append = " \
    --enable-cont-frame-capture \
    --enable-ignore-fps-of-video-standard \
"

do_configure_prepend() {
    cd ${S}
    ./autogen.sh --noconfigure
    cd ${B}
}
