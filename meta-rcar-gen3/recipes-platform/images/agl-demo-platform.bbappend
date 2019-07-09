do_rootfs_append_rcar-gen3(){
    import os
    if "bad-bundle" in d.getVar("DISTRO_FEATURES"):
        init_path = os.path.join(d.getVar("IMAGE_ROOTFS"),'sbin/init')
        new_init_path = os.path.join(d.getVar("IMAGE_ROOTFS"),'sbin/init2')
        os.rename(init_path, new_init_path)
}
