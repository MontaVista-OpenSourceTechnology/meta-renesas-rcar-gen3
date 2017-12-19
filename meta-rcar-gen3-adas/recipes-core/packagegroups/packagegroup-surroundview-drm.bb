DESCRIPTION = "Packages required for DRM Surroundview demo"
LICENSE = "GPL"

inherit packagegroup

PACKAGES = " \
    packagegroup-surroundview-drm \
"

RDEPENDS_packagegroup-surroundview-drm = '${@ " \
    spacenavd \
    libspnav \
    gstreamer1.0-plugins-base libgstallocators-1.0 \
    gstreamer1.0-plugins-base-app libgstapp-1.0 \
    libdrm \
    kernel-module-mmngr \
    kernel-module-mmngrbuf \
    mmngr-user-module \
" if 'surroundview' in '${DISTRO_FEATURES}' else ""}'
