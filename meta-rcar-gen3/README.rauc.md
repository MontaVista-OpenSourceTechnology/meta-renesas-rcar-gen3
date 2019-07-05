# Software/Firmware update over-the-air using RAUC

This layer provides OTA update feature using RAUC.

## **Dependency**

This feature depends on:

```
    Layer: meta-rauc
    URL: git://github.com/rauc/meta-rauc
    Branch: master
```

## **Basic usage**

### **1. How to build**

The target which installs RAUC packages must have a configuration file called `system.conf` and a keyring file called `ca.cert.pem` for bundle authentication.

A sample `system.conf` can be found in `recipes-core/rauc/rauc/system.conf`. This assumes that the rootfs uses 2 ext4 partitions on eMMC to perform symmetric (or A/B) update and the bootloader is in eMMC boot partition (`/dev/mmcblk0bootX`).

The development keyring and bundle private key and certificate can be generated using a script in `meta-rauc/scripts/openssl-ca.sh` (see https://github.com/rauc/meta-rauc/blob/master/scripts/README for detail)

To enable RAUC and its related packages in the target image build, add to `local.conf`:

```bash
IMAGE_INSTALL_append = " rauc-packagegroup"
```

### **2. Update bundle**

This layer contains sample bundle recipes for agl-demo-platform and agl-image-minimal in `recipes-core/bundles/`.
To build the bundle, please add RAUC packages as **1. How to build** and run Bitbake command:

```shell
$ bitbake agl-demo-bundle
```

The built bundle has the extension .raucb. To install it in the target device, use rauc command as following:

```shell
$ rauc install /path/to/agl-demo-bundle.raucb
```

Then reboot to switch to the new updated rootfs.

To create a bundle recipe for a custom image. Please follow the guideline in: https://rauc.readthedocs.io/en/latest/integration.html

### **3. RAUC-hawkBit support**

This also supports hawkBit as an OTA update server. The guideline to install a hawkBit server can be found in: https://github.com/eclipse/hawkbit

There is a sample RAUC-hawkBit client program which support polling, downloading, installing the bundle from hawkBit server. Enable it by adding to `local.conf`:

```bash
IMAGE_INSTALL_append = " rauc-hawkbit"
```

The client must first be configured with the device, server address, authentication token in `recipes-support/rauc-hawkbit/rauc-hawkbit/config.cfg` (see how to configure at: https://github.com/rauc/rauc-hawkbit)

To enable network connection with a static IP, add to `local.conf`:

```bash
STATIC_IP = "<your_ip_addr>"
```

To configure and run `rauc-hawkbit-client` automatically after booting up board, add the following variables to `local.conf`:

```bash
HAWKBIT_SERVER = "<The Hawkbit Server IP>"
HAWKBIT_TARGET = "<The target_name is defined in Hawkbit Server>"
HAWKBIT_TOKEN  = "<The auth_token of target>"
HAWKBIT_MAC    = "<The MAC address of target board>"
HAWKBIT_DL     = "<The bundle download location in target board>"
```

**Note:** The above variables are mandatory, the setup will be skipped if any empty variables, wrong IP format or MAC address.

### **4. Performing system roll-back**

If the updated rootfs failed to boot, system will return back to the previous success rootfs after 3 times booting failure.

There is a sample bundle in this layer to demonstrate the failure by removing the `/sbin/init` which causes the rootfs cannot be initialized.

To build this bundle, add this to `local.conf`:

```bash
DISTRO_FEATURES_append = " bad-bundle"
```

Then run:

```shell
$ bitbake bad-agl-demo-bundle
```

### **5. Firmware update for U-Boot**

The sample `system.conf` contains a slot configuration for bootloader in eMMC device, in this case U-Boot is in `/dev/mmcblk0p1` partition:

```ini
[slot.bootloader.0]
device=/dev/mmcblk0
type=boot-emmc
img_block=1024
```

Where `img_block` is the size which RAUC will clean before updating new U-Boot image (1 block = 1KB). This size should be greater than the U-Boot image file and not reach the area where U-Boot environment variables are stored.

If `img_block=0` or not set, the whole parition will be cleared.

There is a sample bundle recipe for U-Boot: `recipes-core/bundles/u-boot-bundle.bb`

Build it by:

```shell
$ bitbake u-boot-bundle
```

## **Note**

To use eMMC for bootloader, Arm Trusted Firmware needs to be built with `RCAR_SA6_TYPE=1`. Enable it by adding to `local.conf`:

```bash
DISTRO_FEATURES_append = " emmc-boot"
```

## **Reference**

RAUC documentation: https://rauc.readthedocs.io/en/latest

hawkBit on Github: https://github.com/eclipse/hawkbit
