FROM adoptopenjdk/openjdk8 AS build

WORKDIR /src
COPY . .

RUN apt-get update && apt-get install -y curl gnupg && \
  curl -sL https://nginx.org/keys/nginx_signing.key | apt-key add - && \
  echo "deb https://packages.nginx.org/unit/ubuntu/ focal unit" > /etc/apt/sources.list.d/unit.list && \
  echo "deb-src https://packages.nginx.org/unit/ubuntu/ focal unit" >> /etc/apt/sources.list.d/unit.list && \
  apt-get update && apt-get install -y clang unit-dev libuv1-dev && \
  apt-get purge -y gnupg

RUN ["./sbt", "nativeLink"]


FROM nginx/unit:1.21.0-minimal

RUN apt-get update && apt-get install -y libuv1

COPY /config.json /docker-entrypoint.d/

COPY --from=build /src/target/scala-2.11/hello-snunit-out /app/hello-snunit
