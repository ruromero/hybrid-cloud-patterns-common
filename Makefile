NAME=$(shell basename `pwd`)
TARGET_REPO=$(shell git remote show origin | grep Push | sed -e 's/.*URL://' -e 's%:%/%' -e 's%git@%https://%')
TARGET_BRANCH=$(shell git branch --show-current)
show:
	helm template install/ --name-template $(NAME) -f ~/values-secret.yaml --set main.git.repoURL="$(TARGET_REPO)" --set main.git.revision=$(TARGET_BRANCH)

deploy:
	helm install $(NAME) install/ -f ~/values-secret.yaml --set main.git.repoURL="$(TARGET_REPO)" --set main.git.revision=$(TARGET_BRANCH)

upgrade:
	helm upgrade $(NAME) install/ -f ~/values-secret.yaml --set main.git.repoURL="$(TARGET_REPO)" --set main.git.revision=$(TARGET_BRANCH)

uninstall:
	helm uninstall $(NAME) 

.phony: install