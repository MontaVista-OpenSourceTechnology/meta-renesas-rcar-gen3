SRC_URI_remove = "http://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${PV}.tar.xz"
SRC_URI_append = " git://github.com/renesas-rcar/gst-plugins-good.git;branch=RCAR-GEN3/1.6.3"

SRCREV = "ef4a8e903673cd0415ac7485b700b022c2e4410a"

DEPENDS += "mmngrbuf-user-module"

S = "${WORKDIR}/git"

EXTRA_OECONF_append = " --enable-cont-frame-capture"

# submodule is extracted before do_populate_lic
addtask do_init_submodule after do_unpack before do_patch

do_init_submodule() {
    cd ${S}
    git submodule init
    git submodule update
}

do_configure_prepend() {
    cd ${S}
    ./autogen.sh --noconfigure
    cd ${B}
}
