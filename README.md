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

## Dockerfile comparison

Here are some metrics that demonstrate how great multi-stage docker builds are when paired with OTP releases. In the metrics below, `Dockerfile` uses the multi-stage build feature and `Dockerfile.base` is a traditional docker build.

In an effort to avoid testing the time to pull parent images, I ran the following commands before building:

    $ docker pull elixir:1.6-alpine && docker pull node:8-alpine && docker pull alpine:3.6

Also, before running the cache busted test, I ran the following line to simulate what typical build time would look like:

    $ echo "# busted" >> mix.exs

Here are the results:

|                           | Dockerfile | Dockerfile.horrible |
|---------------------------|------------|---------------------|
| Image size                | 39.8MB     | 507MB               |
| Build time (no cache)     | 2m 27s     | 2m 28s              |
| Build time (cache busted) | 1m 04s     | 1m 51s              |
| Push time                 | 37s        | 3m 42s              |
| Pull time                 | 10s        | 59s                 |
