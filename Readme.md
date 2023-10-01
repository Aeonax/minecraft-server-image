## Minecraft server image
No fancy names, just docker image(`aeonaxliar/minecraft-server:0.1`) for installing forge and unpacking modpack in it. Build on top of `arm` version of azul `openjdk 20`. But feel free to fork and tweak it as you wish🌚

Tested only on the latest versions of Minecraft which support Apple M1🤷‍♂️ Intended to be launched in conjunction with curseforge client.

### Usage
This image requires set up env variables: `EULA`, `MOD_URL`, `MINECRAFT_VERSION`, `FORGE_VERSION`, `JAVA_OPTIONS`. `MOD_URL` i took from curseforge manual install - filter by zip in browser network development instpection and copy url from there🤷‍♂️

There is docker compose [example](examples/docker-compose.yml). And maybe this [article](https://waylonwalker.com/modded-minecraft-in-docker/) and reddit [thread](https://www.reddit.com/r/feedthebeast/comments/hfr1zi/anyone_tried_running_a_modded_server_using_docker/) will help you the way they did it for me=) But probably [this](https://docker-minecraft-server.readthedocs.io/en/latest/mods-and-plugins/) image will work for everyone(except M1?) much better😂

### TODO
- [ ] `WORLD_PATH` env support to have it as a Docker volume
- [ ] `PORT` env support
- [ ] `overrides` support which will be merged with server folder after modpack unzipping
- [ ] Clean image from redundant tmp files and so on
- [ ] Maybe split this image into two - first one is minecraft + forge and another with modpack on top of the first one.
- [ ] Ideally `Fabrick` support, but I'm totally out of this scope and too lazy to check it out🤷‍♂️

Probably will return to this after some months\years - there are not much mods I desire for now for Minecraft versions supporting Apple M1 >= `1.19.2`🥲
