DESCRIPTION = "OpenCV SDK packages"
LICENSE = "GPL"

inherit packagegroup

PACKAGES = " \
    packagegroup-opencv-sdk \
"

RDEPENDS_packagegroup-opencv-sdk = '${@ " \
    opencv \
    opencv-apps \
    opencv-dbg \
    libopencv-calib3d \
    libopencv-core \
    libopencv-features2d \
    libopencv-flann \
    libopencv-highgui \
    libopencv-imgproc \
    libopencv-ml \
    libopencv-objdetect \
    libopencv-photo \
    libopencv-stitching \
    libopencv-superres \
    libopencv-video \
    libopencv-videostab \
    gstreamer1.0-plugins-base-app \
" if 'opencv-sdk' in '${DISTRO_FEATURES}' else ""}'
