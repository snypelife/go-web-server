# Let's build a basic go image shall we
FROM golang:alpine

WORKDIR /app

COPY go.mod .
COPY main.go .

RUN go mod download

RUN go build -o go-web-server

EXPOSE 3030

CMD ["/app/go-web-server"]
