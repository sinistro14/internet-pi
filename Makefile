PRINT=@echo

define help_message
Usage:
help          		show this message
devcontainer_setup	install required dependencies
setup    	  		install required dependencies
deploy    	  		run ansible playbook
endef
export help_message

.PHONY: help
help:
	$(PRINT) "$$help_message"

.PHONY: devcontainer_setup
devcontainer_setup:
	sudo apt-get update
	sudo apt-get upgrade -y

.PHONY: setup
setup:
	sudo apt-get install -y python3-pip sshpass iputils-ping
	pip3 install ansible passlib
	ansible-galaxy install -r requirements.yml

.PHONY: deploy
deploy:
	ansible-playbook -e @vault.yml --ask-vault-pass main.yml
