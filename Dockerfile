# Let's build the app here
FROM golang:alpine as builder

WORKDIR /app

COPY go.mod .
COPY main.go .

RUN go mod download

RUN GOOS=linux GOARCH=amd64 go build -o go-web-server

# And then let's run the app from a nice little image
FROM alpine

WORKDIR /app

COPY --from=builder /app .

ENV USER=gouser
ENV UID=1000

RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nothing" \
  --no-create-home \
  --shell "/sbin/nologin" \
  --uid "${UID}" \
  "${USER}"

USER gouser:gouser

EXPOSE 3030

CMD ["/app/go-web-server"]
