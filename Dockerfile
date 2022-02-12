FROM golang@sha256:1a35cc2c5338409227c7293add327ebe42e1ee5465049f6c57c829588e3f8a39 AS builder

WORKDIR /builder

ENV CGO_ENABLED=0

COPY go.mod go.sum /builder/
RUN go mod download

COPY *.go /builder/
RUN go build -v -o /dockpin

FROM scratch

COPY --from=builder /dockpin /bin/dockpin

ENTRYPOINT ["/bin/dockpin"]
