FILESEXTRAPATHS_prepend_rcar-gen3 := "${THISDIR}/${PN}:"

SRC_URI_append_rcar-gen3 = " \
    file://system.conf \
    file://rauc_enable_fw_set \
    file://Add-bin-image-for-boot-emmc.patch \
    file://Disable-toggle-active-eMMC-boot-partition.patch \
    file://0001-update-handler-Avoid-cleaning-all-eMMC-partition.patch \
"

RAUC_KEYRING_FILE_rcar-gen3 := "${THISDIR}/${PN}/rauc-sample-ca.cert.pem"

do_install_append_rcar-gen3(){
    # Compatible target of system.conf
    sed "s/@MACHINENAME@/${MACHINE}/g" -i ${D}/etc/rauc/system.conf
    # Script to unlock writing to eMMC
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/rauc_enable_fw_set ${D}${bindir}/rauc_enable_fw_set
    # Enable to run that script before marking stot status
    sed "/\[Service\]/ a ExecStartPre=/usr/bin/rauc_enable_fw_set" -i ${D}${systemd_unitdir}/system/rauc-mark-good.service
    sed "/start)/ a         /usr/bin/rauc_enable_fw_set" -i ${D}${sysconfdir}/init.d/rauc-mark-good
}

RDEPENDS_${PN}-mark-good_rcar-gen3 += "bash"
FILES_${PN}-mark-good_append_rcar-gen3 = " \
    ${bindir}/rauc_enable_fw_set \
"
