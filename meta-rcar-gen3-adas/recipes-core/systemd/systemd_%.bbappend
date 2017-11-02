FILESEXTRAPATHS_append := '${THISDIR}/${PN}:'

PACKAGECONFIG += " networkd resolved "

SRC_URI_append = "file://eth0.network"

SRC_URI_append= '${@ " \
    file://dummy0.network \
" if 'surroundview' in '${DISTRO_FEATURES}' else ""}'

FILES_${PN} += "${sysconfdir}/systemd/network/*"
 
USERADD_PARAM_${PN} += "; --system systemd-network "

do_install_append() {

    install -d ${D}${sysconfdir}/systemd/network/

    install -m 0644 ${WORKDIR}/*.network  ${D}${sysconfdir}/systemd/network/
}

PR="r2"
