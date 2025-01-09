FROM golang:1.19.5-buster AS builder
COPY go.sum go.mod main.go /
RUN go mod download
RUN GOOS=linux go build -o /main


FROM scratch
COPY --from=builder /main /
ENTRYPOINT ["/main"]
