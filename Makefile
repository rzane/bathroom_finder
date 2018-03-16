ENV?=staging
PROJECT?=$(shell gcloud config get-value project)
IMAGE?=gcr.io/$(PROJECT)/bathroom_finder
CLUSTER?=bathroom-finder
TAG?=$(shell git rev-parse --short HEAD)
CONTEXT?=$(shell kubectl config current-context)

cluster:
	gcloud container clusters create $(CLUSTER) \
		--machine-type f1-micro \
		--num-nodes 3 \
		--enable-autoscaling \
		--min-nodes 3 \
		--max-nodes 5

credentials:
	gcloud container clusters get-credentials $(CLUSTER)

namespace:
	kubectl create namespace $(ENV)

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(TAG) .

push:
	gcloud docker -- push $(IMAGE):$(TAG)
	gcloud docker -- push $(IMAGE):latest

rollout:
	REVISION=$(TAG) KUBECONFIG=~/.kube/config kubernetes-deploy $(ENV) $(CONTEXT) --template-dir=./infra

deploy: build push rollout
provision: namespace postgres deploy
