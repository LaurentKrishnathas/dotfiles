GITHUB_TOKEN=47e46ca72ac00b97c9eb02da771087660682f6c5
GIT_USER=lkatdotmatics

ATLANTIS_HOST=https://6bcb02332d12.ngrok.io
SECRET=hasdgeawdewregaweg

ATLANTIS_IMAGE=lk:atlantis
atlantis/build/docker/image:
	docker build -t $(ATLANTIS_IMAGE)  -f infra/docker/image/atlantis/Dockerfile .


atlantis/run:
	 docker run \
 		-it \
 		-p 4141:4141 \
 		$(ATLANTIS_IMAGE)  \
 		atlantis server --gh-user $(GIT_USER) --gh-token $(GITHUB_TOKEN) --repo-allowlist 'github.com/lkatdotmatics/*' --atlantis-url $(ATLANTIS_HOST) --gh-webhook-secret="$(SECRET)"

atlantis/testdrive:
	docker rm -vf atlantis || true
	 docker run \
 		-it \
 		--name atlantis \
 		-p 4141:4141 \
 		$(ATLANTIS_IMAGE)  \
 		atlantis testdrive

atlantis/exec_root:
	docker exec -it atlantis bash

atlantis/exec:
	docker exec -u atlantis -it atlantis bash

atlantis/url:
	open $(ATLANTIS_HOST)/github-app/setup

atlantis/download:
	mkdir -p build/atlantis
	wget -O build/atlantis/tmp.zip  https://github.com/runatlantis/atlantis/releases/download/v0.15.0/atlantis_darwin_amd64.zip
	unzip build/atlantis/tmp.zip -d build/atlantis

atlantis/tmp:
	build/atlantis/atlantis --help

ngrok/download:
	mkdir -p build/ngrok
	wget -O build/ngrok/tmp.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip
	unzip build/ngrok/tmp.zip -d build/ngrok

ngrok/run:
	chmod +x ./build/ngrok/ngrok
	./build/ngrok/ngrok http 4141
