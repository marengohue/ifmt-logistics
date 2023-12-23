#!/usr/bin/sh


MOD_DATA=$(cat ./src/info.json | jq '.name,.version' --raw-output)
MOD_NAME=$(echo $MOD_DATA | cut -d ' ' -f1)
MOD_VERSION=$(echo $MOD_DATA | cut -d ' ' -f2)

MOD_DIR_NAME="${MOD_NAME}_${MOD_VERSION}"
TARGET_DIR="./.dist/${MOD_DIR_NAME}"
MODS_GAME_DIR="${HOME}/.factorio/mods"

echo "Cleaning up existing installation"
rm --recursive --force "${MODS_GAME_DIR}/${MOD_DIR_NAME}"

echo "Copying .dist package for ${MOD_NAME} (v${MOD_VERSION}) into the mods directory ('${MODS_GAME_DIR}')"
cp --recursive $TARGET_DIR $MODS_GAME_DIR

echo "Done!"

