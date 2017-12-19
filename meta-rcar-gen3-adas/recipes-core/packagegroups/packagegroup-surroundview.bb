DESCRIPTION = "Packages required for GPU Surroundview demo"
LICENSE = "GPL"

inherit packagegroup

PACKAGES = " \
    packagegroup-surroundview \
"

RDEPENDS_packagegroup-surroundview = '${@ " \
    spacenavd \
    libspnav \
    glm \
    nlopt \
    gstreamer1.0-omx \
    gstreamer1.0-plugins-base-app libgstapp-1.0 \
    yaml-cpp \
    libmediactl-v4l2 \
" if 'surroundview' in '${DISTRO_FEATURES}' else ""}'
