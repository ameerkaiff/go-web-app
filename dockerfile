# Stage 1: Build the Go app with correct Go version
FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .
RUN go build -o main .

# Stage 2: Minimal runtime image
FROM gcr.io/distroless/base

WORKDIR /

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
