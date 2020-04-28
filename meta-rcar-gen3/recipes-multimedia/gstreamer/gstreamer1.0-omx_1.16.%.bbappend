FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"

SRC_URI_remove = "https://gstreamer.freedesktop.org/src/gst-omx/gst-omx-${PV}.tar.xz"
SRC_URI_append = " \
    gitsm://github.com/iotbzh/gst-omx.git;branch=RCAR-GEN3/1.16.2 \
    file://gstomx.conf \
"

#    file://fix_meson_build.diff 
    
require include/rcar-gen3-path-common.inc

DEPENDS += "omx-user-module mmngrbuf-user-module"

#SRCREV = "4b4d3b4e7682e1c80c0c94f1b997b815a3e7740b"
SRCREV = "476814f3f19902f919bd86ae880bce0e50984900"

LIC_FILES_CHKSUM = "file://COPYING;md5=4fbd65380cdd255951079008b364516c \
    file://omx/gstomx.h;beginline=1;endline=22;md5=d411057db0aa43d31f1ec9d6a980a216 \
"

S = "${WORKDIR}/git"

#GSTREAMER_1_0_OMX_TARGET = "rcar"
GSTREAMER_1_0_OMX_CORE_NAME = "${libdir}/libomxr_core.so"
EXTRA_OECONF_append = " --enable-experimental"

python __anonymous () {
    d.appendVar("CFLAGS", " -I${S}/omx/openmax")
    d.appendVar("CFLAGS", " -I${S}/omx")
}



VIRTUAL-RUNTIME_libomxil = "omx-user-module"

