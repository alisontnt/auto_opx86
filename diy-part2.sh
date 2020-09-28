#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Add Adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/lean/luci-app-adguardhome
# Modify default IP
sed -i 's/192.168.1.1/10.7.30.1/g' package/base-files/files/bin/config_generate
#Update Golang to 1.15.2
sed -i "/GO_VERSION_MAJOR_MINOR:=/c GO_VERSION_MAJOR_MINOR:=1.15" feeds/packages/lang/golang/golang/Makefile
sed -i "/GO_VERSION_PATCH:=/c GO_VERSION_PATCH:=2" feeds/packages/lang/golang/golang/Makefile
sed -i "/PKG_HASH:=/c PKG_HASH:=28bf9d0bcde251011caae230a4a05d917b172ea203f2a62f2c2f9533589d4b4d" feeds/packages/lang/golang/golang/Makefile
