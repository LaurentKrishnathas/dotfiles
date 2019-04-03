# @author Laurent Krishnathas
# @year 2019


# Get it from terraform output

OUTPUT_JSON=.output.json

NAME=$(shell cat .output.json | jq -r ".name.value")-$(shell cat .output.json | jq -r ".environment.value")

create_output_json:
	terraform output -json>$(OUTPUT_JSON)

debug: create_output_json
	@cat $(OUTPUT_JSON) | jq
	@echo "NAME = $(NAME)"


terraform_debug:
	terraform providers
	terraform show
	terraform output


graph:
	mkdir -p docs
	terraform graph | dot -Tsvg > docs/graph.svg

ssh: create_output_json
	ssh ec2-user@$(shell cat .output.json | jq -r ".ec2_private_ip.value") -i ~/.ssh/$(shell cat .output.json | jq -r ".key_name.value").pem
