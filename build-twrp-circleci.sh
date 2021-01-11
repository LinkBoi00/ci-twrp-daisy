#!bin/bash

# Go to the working directory
cd ~/SHRP-9
# Configure git
git config --global user.email "50962670+LinkBoi00@users.noreply.github.com"
git config --global user.name "LinkBoi00"
git config --global color.ui false
# Sync the source
repo init --depth=1 -u git://github.com/SHRP/platform_manifest_twrp_omni.git -b v3_9.0
repo sync -f --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
# Clone device tree tree
git clone --depth=1 https://github.com/LinkBoi00/shrp_device_xiaomi_daisy device/xiaomi/daisy
# Build recovery image
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch omni_daisy-eng; mka recoveryimage
# Rename and copy the files
cd out/target/product/daisy
date_time=$(date +"%d%m%Y%H%M")
mkdir ~/final
cp recovery.img ~/final/shrp-"$date_time"-recovery.img
cp SHRP_v*.zip ~/final
# Upload to oshi.at
curl -T ~/final/*.img https://oshi.at 
curl -T ~/final/*.zip https://oshi.at