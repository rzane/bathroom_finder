# Bathroom Finder

An app that helps you find nearby bathrooms.

The app is build using Phoenix, Absinthe, and GraphQL.

To run the application:

```
$ mix deps.get
$ yarn install
$ mix ecto.setup
$ mix phx.server
$ open localhost:4000
```

## Deployment with Kubernetes

Use minikube for a local kubernetes cluster:

    $ brew cask install minikube
    $ minikube start
    $ kubectl config use-context minikube

You'll also need the `kubernetes-deploy` tool:

    $ gem install kubernetes-deploy

Next, you'll need to setup your cluster.

    $ make provision

Now, you can deploy:

    $ make deploy
