DESCRIPTION = "CR7 Loader"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.md;md5=9b6b96211116d6143a7f1d681d39b13d"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

S = "${WORKDIR}/git"

BRANCH = "rcar_gen3"
SRC_URI = "git://github.com/CogentEmbedded/cr7-loader.git;branch=${BRANCH}"
SRCREV = "f06b622d9f91771076e755aea1aad5fddcb6f172"

PV = "v1.0+renesas+git"

COMPATIBLE_MACHINE = "eagle|condor|v3msk|v3mzf|v3hsk"
PLATFORM = "rcar"

CR7_OPT_r8a7797 = "LSI=V3M RCAR_DRAM_SPLIT=0 RCAR_KICK_MAIN_CPU=2 RCAR_SECURE_BOOT=0"
CR7_OPT_r8a7798 = "LSI=V3H RCAR_DRAM_SPLIT=0 RCAR_KICK_MAIN_CPU=2 RCAR_SECURE_BOOT=0"

do_compile() {
    wget https://releases.linaro.org/components/toolchain/binaries/5.1-2015.08/arm-eabi/gcc-linaro-5.1-2015.08-x86_64_arm-eabi.tar.xz
    tar xfJ gcc-linaro-5.1-2015.08-x86_64_arm-eabi.tar.xz

    CROSS_COMPILE=./gcc-linaro-5.1-2015.08-x86_64_arm-eabi/bin/arm-eabi- make ${CR7_OPT} clean
    CROSS_COMPILE=./gcc-linaro-5.1-2015.08-x86_64_arm-eabi/bin/arm-eabi- make ${CR7_OPT}
}

do_deploy() {
    # Create deploy folder
    install -d ${DEPLOYDIR}

    # Copy CR7 Loader to deploy folder
    install -m 0644 ${S}/cr7_loader.elf ${DEPLOYDIR}/cr7-${MACHINE}.elf
    install -m 0644 ${S}/cr7_loader.bin ${DEPLOYDIR}/cr7-${MACHINE}.bin
    install -m 0644 ${S}/cr7_loader.srec ${DEPLOYDIR}/cr7-${MACHINE}.srec

    install -m 0644 ${S}/bootparam_sa0.srec ${DEPLOYDIR}/bootparam_sa0.bin
    install -m 0644 ${S}/bootparam_sa0.srec ${DEPLOYDIR}/bootparam_sa0.srec

    install -m 0644 ${S}/cert_header_sa3.srec ${DEPLOYDIR}/cert_header_sa3.srec
}

addtask deploy before do_build after do_compile
