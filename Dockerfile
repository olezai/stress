FROM golang:latest AS builder

WORKDIR /

COPY main.go /.

RUN GOBIN=/ go get

RUN GOBIN=/ CGO_ENABLED=0 go build --ldflags '-extldflags "-static"' -o stress

LABEL maintainer="l3xxmeiter@gmail.com"

COPY --from=builder  /stress /

ENTRYPOINT ["/stress", "-logtostderr"]
