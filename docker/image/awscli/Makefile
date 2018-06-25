# @author Laurent Krishnathas
# @version 2017/10/19

# common variables
container_name=awscli
image_name=laurent_krishnathas/awscli

#image_version=snapshot
image_version=1.1.3
# image_version=snapshot
dockerfile=awscli.Dockerfile

hello:
	echo hello
	
docker_build:
	docker build -t $(image_name):$(image_version) --rm=false -f $(dockerfile) .
	
docker_stop:
	docker stop $(container_name) || echo WARNING $(container_name) may not exist 
	docker rm -f $(container_name) || echo WARNING $(container_name)  may not exist 
	
docker_run: docker_stop docker_build
	docker image ls |grep $(container_name) 
	docker run -d --name $(container_name) -v $$HOME/.aws:/root/.aws  $(image_name):$(image_version)

docker_log: 
	docker image ls |grep $(container_name) 
	docker ps |grep $(container_name) 
	docker logs -f $(container_name) 

docker_push: docker_build
	docker tag $(image_name):$(image_version) $$ECR_REGISTRY_URI/$(image_name):$(image_version)
	docker push $$ECR_REGISTRY_URI/$(image_name):$(image_version)

docker_all: docker_run docker_log

docker_exec:
	# docker exec $(container_name) su awscli -c "/aws/current_script.sh"
	# docker exec $(container_name) tail -f /var/log/script.log
	docker exec -it $(container_name) sh

#tmp: docker_stop docker_build
test: docker_stop docker_build
	docker image ls |grep $(container_name)
	docker run \
			-it \
			--name $(container_name) \
			-e CRON_SCRIPT=/data/test_script.sh \
			-e CROND_REGEX="* * * * *" \
			-e CROND_ARGS="-l 0 -S" \
			-v $$HOME/.aws:/root/.aws  \
			-v $$(pwd):/data \
			$(image_name):$(image_version)


