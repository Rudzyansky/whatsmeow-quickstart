FROM golang:1.20-buster AS builder
WORKDIR /build
COPY go.sum go.mod main.go ./

RUN go clean -modcache
RUN go mod tidy
RUN go mod download
RUN GOOS=linux go build -o ../main

RUN rm -rf build
RUN go clean -modcache


FROM golang:1.20-buster
COPY --from=builder /main /main
ENTRYPOINT ["/main"]
