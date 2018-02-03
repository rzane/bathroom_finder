ENV=staging
IMAGE=rzane/bathroom_finder
TAG?=$(shell git rev-parse --short HEAD)
CONTEXT?=$(shell kubectl config current-context)

provision:
	kubectl create namespace $(ENV)
	kubectl create -f infra/postgres.yaml --namespace=$(ENV)

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):latest

rollout:
	REVISION=$(TAG) KUBECONFIG=~/.kube/config kubernetes-deploy $(ENV) $(CONTEXT) --template-dir=./infra

deploy: build push rollout
