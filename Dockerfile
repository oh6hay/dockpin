FROM ubuntu:latest
RUN apt-get update && apt-get -y install golang ca-certificates bash

WORKDIR /dockpin

ENV CGO_ENABLED=0

COPY go.mod go.sum /dockpin/
RUN go mod download

COPY *.go /dockpin/
RUN go build -v -o /dockpin

COPY /dockpin /bin/dockpin
WORKDIR /
