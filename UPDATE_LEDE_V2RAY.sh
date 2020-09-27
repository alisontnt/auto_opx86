#!/bin/bash
# Get V2Ray release version number
TMP_FILE="$(mktemp)"
# DO NOT QUOTE THESE `${PROXY}` VARIABLES!
if ! curl ${PROXY} -sS -H "Accept: application/vnd.github.v3+json" -o "$TMP_FILE" 'https://api.github.com/repos/v2fly/v2ray-core/releases/latest'; then
    "rm" "$TMP_FILE"
    echo 'error: Failed to get release list, please check your network.'
    exit 1
fi
RELEASE_LATEST="$(sed 'y/,/\n/' "$TMP_FILE" | grep 'tag_name' | awk -F '"' '{print $4}')"
"rm" "$TMP_FILE"
VERSION=$(echo ${RELEASE_LATEST#v})
if ! curl -o "$TMP_FILE" https://codeload.github.com/v2fly/v2ray-core/tar.gz/$RELEASE_LATEST; then
    "rm" "$TMP_FILE"
    echo 'error: Failed to get release, please check your network.'
    exit 1
fi
SHA256_LONG=$(sha256sum "$TMP_FILE")
"rm" "$TMP_FILE"
SHA256=$(echo $SHA256_LONG|cut -c1-64)
#change package/lean/v2ray/Makefile
sed -i "/PKG_HASH:=/c PKG_HASH:=$SHA256" package/lean/v2ray/Makefile
sed -i "/PKG_VERSION:=/c PKG_VERSION:=$VERSION" package/lean/v2ray/Makefile
