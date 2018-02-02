FROM elixir:1.6-alpine as deps

ENV HOME=/opt/app \
    MIX_ENV=prod

WORKDIR $HOME

# Install requirements for compile
RUN apk --no-cache add git build-base

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# Cache and install Elixir deps
COPY config/ $HOME/config/
COPY mix.exs mix.lock $HOME/
RUN mix deps.get --only $MIX_ENV

##############################################################################

FROM node:8-alpine as assets

ENV HOME=/opt/app

# Copy the deps directory into this container
COPY --from=deps $HOME/deps/ $HOME/deps/

# Go into the assets directory
WORKDIR $HOME/assets

# Install node modules
COPY assets/ ./
RUN yarn install

# Compile assets
RUN yarn build

##############################################################################

FROM deps as release

# Compile all dependencies
RUN mix deps.compile

# Copy in the rest of the source code
COPY . $HOME/

# Copy in the compiled assets and create our cache_manifest.json
COPY --from=assets $HOME/priv/static/ $HOME/priv/static/
RUN mix phx.digest

# Build a release
RUN mix release --no-tar

##############################################################################

FROM alpine:3.6

EXPOSE 4000
ENV LANG=en_US.UTF-8 \
    HOME=/opt/app/ \
    TERM=xterm \
    SHELL=/bin/sh \
    PORT=4000 \
    BATHROOM_FINDER_VERSION=0.0.1

WORKDIR $HOME

# Install runtime requirements
RUN apk add --no-cache openssl bash

# Copy the release into the container
COPY --from=release $HOME/_build/prod/rel/bathroom_finder/ $HOME

ENTRYPOINT ["/opt/app/bin/bathroom_finder"]
CMD ["foreground"]
