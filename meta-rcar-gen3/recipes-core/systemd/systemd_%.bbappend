require include/gles-control.inc

FILESEXTRAPATHS_prepend_rcar-gen3 := "${THISDIR}/files:"

SRC_URI_append_rcar-gen3 = " \
    file://eth0.network \
"

PACKAGECONFIG_remove_rcar-gen3 = "timesyncd"

# Avoid pushing opened device fds into PID1 by logind when restarting
do_install_append_rcar-gen3 () {
    if [ "X${USE_GLES}" = "X1" ]; then
        sed -e 's/FileDescriptorStoreMax=512/FileDescriptorStoreMax=0/' \
            -i ${D}/lib/systemd/system/systemd-logind.service
    fi

    # Set static IP
    if [ ! -z "${STATIC_IP}" ]; then
        install -m 0644 ${WORKDIR}/eth0.network ${D}${sysconfdir}/systemd/network/
        sed "s/@IP@/${STATIC_IP}/g" -i ${D}${sysconfdir}/systemd/network/eth0.network
    fi
}
