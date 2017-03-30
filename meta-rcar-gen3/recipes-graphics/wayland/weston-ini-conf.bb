LICENSE = "MIT"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = " \
    file://weston.ini \
    file://weston_v4l2.ini \
"

do_install_append() {
    if [ "X${USE_MULTIMEDIA}" = "X1" ]; then
        # install weston.ini as sample settings of v4l2-renderer
        install -d ${D}/${sysconfdir}/xdg/weston
        install -m 644 ${WORKDIR}/weston_v4l2.ini ${D}/${sysconfdir}/xdg/weston/weston.ini
    else
        # install weston.ini as sample settings of gl-renderer
        install -d ${D}/${sysconfdir}/xdg/weston
        install -m 644 ${WORKDIR}/weston.ini ${D}/${sysconfdir}/xdg/weston/
    fi
}

FILES_${PN}_append = " \
    ${sysconfdir}/xdg/weston/weston.ini \
"

