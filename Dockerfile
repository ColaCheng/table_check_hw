FROM elixir:1.14-otp-25-alpine AS builder
ENV MIX_ENV=prod
WORKDIR /usr/local/table_check_hw

# This step installs all the build tools we'll need
RUN apk add --no-cache git && \
    mix local.rebar --force && \
    mix local.hex --force

# Copies our app source code into the build container
COPY . .

# Compile Elixir
RUN mix do deps.get, deps.compile, compile

# Build Release
RUN mkdir -p /opt/release \
    && mix release \
    && mv _build/${MIX_ENV}/rel/table_check_hw /opt/release

# Create the runtime container
FROM erlang:25.2-alpine as runtime
WORKDIR /usr/local/table_check_hw

COPY --from=builder /opt/release/table_check_hw .

CMD ["bin/table_check_hw", "start"]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 \
    CMD nc -vz -w 2 localhost ${HTTP_PORT} || exit 1
