FILESEXTRAPATHS_prepend := "${THISDIR}/wayland-ivi-extension:"
SRCREV := "c9001582b10ce209c37b42dd560947c5aa8928b3"

SRC_URI_remove = "file://test-path.patch"
SRC_URI_append = " file://0001-Fix-ivi-application-lib-install.patch "

# workaround paralellism issue:
PARALLEL_MAKE = ""