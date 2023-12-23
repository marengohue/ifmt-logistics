#!/usr/bin/sh

TEMP_BUILD=$(mktemp --directory)
echo "Using '$TEMP_BUILD' as staging"
cp ./src/info.json $TEMP_BUILD
cp ./src/thumbnail.png $TEMP_BUILD
cp ./src/control/* $TEMP_BUILD
cp ./src/settings/* $TEMP_BUILD
cp ./src/data/* $TEMP_BUILD

MOD_DATA=$(cat ./src/info.json | jq '.name,.version' --raw-output)
MOD_NAME=$(echo $MOD_DATA | cut -d ' ' -f1)
MOD_VERSION=$(echo $MOD_DATA | cut -d ' ' -f2)

TARGET_DIR="./.dist/${MOD_NAME}_${MOD_VERSION}"
echo "Preparing .dist package for ${MOD_NAME} (v${MOD_VERSION})"
rm --recursive --force $TARGET_DIR
mkdir --parents $TARGET_DIR

echo "Copying the artefacts from the staging area."
cp --recursive $TEMP_BUILD/* $TARGET_DIR

echo "Cleaning up the staging area."
rm --recursive --force $TEMP_BUILD

echo "Done!"
