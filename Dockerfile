FROM golang:1.22 AS builder
WORKDIR /app/
COPY go.mod go.sum /app/
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v

FROM python:alpine
RUN apk update && apk upgrade && apk add --no-cache ffmpeg
COPY --from=builder /app/yt-dlp-telegram-bot /app/yt-dlp-telegram-bot
COPY --from=builder /app/yt-dlp.conf /root/yt-dlp.conf

ENTRYPOINT ["/app/yt-dlp-telegram-bot"]
ENV API_ID=26439364 API_HASH=0096e8e4f8dff459a40dec03ce9a7530 BOT_TOKEN=7512878285:AAF22KPfNJ45mQzHggNsnsI46faw1Cp33Hc ALLOWED_USERIDS=5874966233 ADMIN_USERIDS=5874966233 ALLOWED_GROUPIDS= YTDLP_COOKIES=
