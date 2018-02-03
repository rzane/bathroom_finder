ENV?=staging
IMAGE?=rzane/bathroom_finder
CLUSTER?=bathroom-finder
TAG?=$(shell git rev-parse --short HEAD)
CONTEXT?=$(shell kubectl config current-context)

cluster:
	gcloud container clusters create $(CLUSTER) --num-nodes 3 --machine-type f1-micro
	gcloud container clusters get-credentials $(CLUSTER)
	kubectl create namespace $(ENV)

provision:
	kubectl create -f infra/postgres.yaml --namespace=$(ENV)

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):latest

rollout:
	REVISION=$(TAG) KUBECONFIG=~/.kube/config kubernetes-deploy $(ENV) $(CONTEXT) --template-dir=./infra

deploy: build push rollout
