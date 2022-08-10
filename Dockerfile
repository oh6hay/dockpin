FROM golang@sha256:d72a2944621f0f4027983e094bdf9464d26459c17efe732320043b84c91e51e7 AS builder

WORKDIR /builder

ENV CGO_ENABLED=0

COPY go.mod go.sum /builder/
RUN go mod download

COPY *.go /builder/
RUN go build -v -o /dockpin

FROM scratch

COPY --from=builder /dockpin /bin/dockpin

ENTRYPOINT ["/bin/dockpin"]
