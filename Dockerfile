# Let's build the app here
FROM golang:alpine as builder

WORKDIR /app

COPY go.mod .
COPY main.go .

RUN go mod download

RUN go build -o go-web-server

# And then let's run the app from a nice little image
FROM alpine

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3030

CMD ["/app/go-web-server"]
