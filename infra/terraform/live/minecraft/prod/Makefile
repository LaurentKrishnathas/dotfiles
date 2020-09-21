HOSTNAME=hashicorp.com
NAMESPACE=edu
NAME=minecraft
BINARY=terraform-provider-${NAME}
VERSION=0.2
OS_ARCH=darwin_amd64


minecraft/run: minecraft/stop
	docker volume create minecraft-volume
	docker run \
		-d \
		--name minecraft \
		-v $$PWD/plugins:/data/plugins \
		--mount source=minecraft-volume,target=/data \
		-v $$PWD/terraform-minecraft-plugin-1.0.jar:/root/plugins/terraform-minecraft-plugin-1.0.jar \
		--shm-size=2g \
		-p 8080:8080\
		-p 25565:25565 \
		-p 25575:25575  \
		--privileged \
		-e EULA=TRUE \
		-e TZ=Europe/London \
		-e VERSION=LATEST \
		-e TYPE=SPIGOT \
		-e MEMORY=2G \
		itzg/minecraft-server
	docker logs -f minecraft

minecraft/stop:
	docker rm -fv minecraft

minecraft/exec:
	docker exec -u minecraft -it minecraft bash


minecraft/download:
	wget https://github.com/scottwinkler/terraform-provider-minecraft/releases/download/v0.17.1/terraform-provider-minecraft_v0.17.1_darwin_amd64.tar.gz
	wget https://github.com/scottwinkler/terraform-minecraft-plugin/releases/download/v1.0/terraform-minecraft-plugin-1.0.jar ?? plugins



#		-v $$PWD/plugins:/home/minecraft/plugins \

		-#e TYPE=PAPER \
#-e FORGEVERSION=10.13.4.1448
#-e FORGE_INSTALLER=forge-1.11.2-13.20.0.2228-installer.jar


#-e TYPE=BUKKIT or -e TYPE=SPIGOT
#-e DIFFICULTY=hard
#-e WORLD=http://www.example.com/worlds/MySave.zip
#-e MODPACK=http://www.example.com/mods/modpack.zip
