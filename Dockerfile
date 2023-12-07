FROM golang:1.21 as builder

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -a -o /bin/app

FROM gcr.io/distroless/base-debian12
COPY --from=builder /bin/app /bin/app
CMD ["app"]
