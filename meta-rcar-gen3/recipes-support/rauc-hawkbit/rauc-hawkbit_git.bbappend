FILESEXTRAPATHS_prepend_rcar-gen3 := "${THISDIR}/files:"

SRC_URI_append_rcar-gen3 = " \
    file://config.cfg \
    file://rauc_hawkbit.sh \
"

python __anonymous() {
    hawkbit_items = [None] * 5
    hawkbit_items[0] = d.getVar('HAWKBIT_SERVER')
    hawkbit_items[1] = d.getVar('HAWKBIT_TARGET')
    hawkbit_items[2] = d.getVar('HAWKBIT_TOKEN')
    hawkbit_items[3] = d.getVar('HAWKBIT_MAC')
    hawkbit_items[4] = d.getVar('HAWKBIT_DL')

    import re

    def check_valid_ip(ip):
        if ':' in ip:
            ip = ip.split(':')[0]
        is_ip = re.match(r"^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$",ip)
        return bool(is_ip)

    def check_valid_mac(mac):
        is_mac = re.match("[0-9a-f]{2}([-:]?)[0-9a-f]{2}(\\1[0-9a-f]{2}){4}$", mac.lower())
        return bool(is_mac)

    if not check_valid_ip(hawkbit_items[0]):
        hawkbit_items[0] = None

    if not check_valid_mac(hawkbit_items[3]):
        hawkbit_items[3] = None

    i = None

    if all(i is not None for i in hawkbit_items):
        d.setVar('ENABLE_HAWKBIT', '1')
    else:
        d.setVar('ENABLE_HAWKBIT', '0')
}

do_install_append_rcar-gen3 () {
    if [ "${ENABLE_HAWKBIT}" = "1" ]; then
        install -d ${D}${sysconfdir}/rauc
        install -m 0644 ${WORKDIR}/config.cfg ${D}${sysconfdir}/rauc

        sed "s|@hawkbit_server@|${HAWKBIT_SERVER}|g" -i ${D}${sysconfdir}/rauc/config.cfg
        sed "s|@target@|${HAWKBIT_TARGET}|g"         -i ${D}${sysconfdir}/rauc/config.cfg
        sed "s|@token@|${HAWKBIT_TOKEN}|g"           -i ${D}${sysconfdir}/rauc/config.cfg
        sed "s|@MAC@|${HAWKBIT_MAC}|g"               -i ${D}${sysconfdir}/rauc/config.cfg
        sed "s|@location@|${HAWKBIT_DL}|g"           -i ${D}${sysconfdir}/rauc/config.cfg

        install -d ${D}${sysconfdir}/profile.d
        install -m 0755 ${WORKDIR}/rauc_hawkbit.sh ${D}${sysconfdir}/profile.d
    fi
}

FILES_${PN}_append_rcar-gen3 = " \
    ${sysconfdir}/profile.d/rauc_hawkbit.sh \
    ${sysconfdir}/rauc/config.cfg \
"
