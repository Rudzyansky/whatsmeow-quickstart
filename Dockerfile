FROM golang:1.19.5-buster AS builder
WORKDIR /build
COPY go.sum go.mod main.go ./
RUN go mod download
RUN GOOS=linux go build -o ../main

RUN rm -rf build
RUN go clean -modcache


FROM golang:1.19.5-buster
COPY --from=builder /main /main
ENTRYPOINT ["/main"]
