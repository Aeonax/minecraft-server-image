FROM azul/zulu-openjdk:20.0.2-20.32.11-arm64

RUN apt-get update && apt-get --assume-yes install curl unzip

WORKDIR ${DIRECTORY}

ADD run.sh ${DIRECTORY}/run.sh
RUN chmod +x ${DIRECTORY}/run.sh

# TODO? Port from env
EXPOSE 25565 25565

# TODO: mount world - level-name=world in server.properties
# TODO: ops.json

CMD env EULA=$EULA DIRECTORY="/usr/share/minecraft-$MINECRAFT_VERSION-$FORGE_VERSION" FORGE_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/$MINECRAFT_VERSION-$FORGE_VERSION/forge-$MINECRAFT_VERSION-$FORGE_VERSION-installer.jar" JAVA_OPTIONS="$JAVA_OPTIONS" MOD_URL=$MOD_URL MINECRAFT_VERSION=$MINECRAFT_VERSION FORGE_VERSION=$FORGE_VERSION ${DIRECTORY}/run.sh
