#!/bin/bash
set -e

echo "INIT RUN.SH
      DIRECTORY: $DIRECTORY
      MINECRAFT_VERSION: $MINECRAFT_VERSION
      FORGE_VERSION: $FORGE_VERSION
      JAVA_OPTIONS: $JAVA_OPTIONS
      FORGE_URL: $FORGE_URL
      MOD_URL: $MOD_URL"

if [ ! -d ${DIRECTORY}/server ];
then
    echo "Fetching forge installer"
    curl --create-dirs -sLo ${DIRECTORY}/tmp/forge-installer.jar ${FORGE_URL}

    echo "Installing server"
    java -jar ${DIRECTORY}/tmp/forge-installer.jar --installServer ${DIRECTORY}/server
fi

if [ ! -d ${DIRECTORY}/server/mods ];
then
    echo "Fetching modpack"
    curl --create-dirs -Lo ${DIRECTORY}/tmp/modpack.zip ${MOD_URL}

    echo "Unzipping modpack"
    temp_dir=$(mktemp -d)
    unzip -q ${DIRECTORY}/tmp/modpack.zip -d "$temp_dir"
    LINES=$(ls -1 "$temp_dir" | wc -l)

    if [ $LINES == 1 ]; then
        for item in "$temp_dir"/*; do
            if [ -e "$item" ]; then
                if [ -d "$item" ]; then
                    mv "$item"/* ${DIRECTORY}/server
                elif [ -f "$item" ]; then
                    mv "$item" ${DIRECTORY}/server
                fi
            fi
        done
    else
        mv "$temp_dir"/* ${DIRECTORY}/server
    fi

    echo "Cleaning tmp"
    rm -rf "$temp_dir"
    rm -r tmp
fi

if [[ ! -z $EULA ]];
then
    if [[ ! -e "$DIRECTORY/server/eula.txt" ]];
    then
        echo "Setting up EULA"
        echo "eula=true" >> ${DIRECTORY}/server/eula.txt
    fi
fi

echo "Run Server"
cd ${DIRECTORY}/server
echo "java $JAVA_OPTIONS @libraries/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/unix_args.txt --nogui"

java $JAVA_OPTIONS @libraries/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/unix_args.txt --nogui

