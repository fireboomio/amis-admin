FROM golang:1.22-alpine3.19
WORKDIR /app/custom-go
COPY custom-go/go.mod custom-go/go.sum /app/custom-go/
RUN go mod download

EXPOSE 9992

CMD ["go", "run", "main.go"]
