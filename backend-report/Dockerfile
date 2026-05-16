FROM golang:1.25.7-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o backendReport .



FROM alpine:3.21

WORKDIR /app

RUN apk upgrade --no-cache && apk add --no-cache curl 

COPY --from=builder /app/backendReport .

RUN adduser -D backend-report-user && chown -R backend-report-user:backend-report-user /app
USER backend-report-user



EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:8080/api/v1/health

CMD ["./backendReport"]
