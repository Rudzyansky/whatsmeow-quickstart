FROM golang:1.19.5-buster AS builder
WORKDIR /build
COPY go.sum go.mod main.go ./
RUN go mod download
RUN GOOS=linux go build -o ./main


FROM alpine:latest
COPY --from=builder /build/main /main
