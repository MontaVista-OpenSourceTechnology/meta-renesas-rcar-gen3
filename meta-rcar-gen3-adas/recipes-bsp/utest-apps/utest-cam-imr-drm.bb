SUMMARY = "Unit test for VIN-IMR-DRM camera capture pipe"
LICENSE = "CLOSED"

inherit cmake

S = "${WORKDIR}/utest-cam-imr-drm"

SRC_URI = " \
    file://utest-cam-imr-drm.tar.gz \
"

DEPENDS = " \
    libspnav \
    libdrm \
    gstreamer1.0-plugins-base \
    mmngr-user-module \
    mmngrbuf-user-module \
"

do_install() {
    install -d ${D}${bindir}
    install -m 755 ${S}/../build/utest/utest-cam-imr-drm ${D}${bindir}
}

EXTRA_OECMAKE += " -DCMAKE_SYSROOT=${STAGING_DIR_TARGET} "
