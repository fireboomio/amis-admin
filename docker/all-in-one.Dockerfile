FROM golang:alpine as builder

RUN apk add curl bash ca-certificates
WORKDIR /app

# COPY dist html
COPY backend backend
COPY oidc/update.sh oidc/update.sh
COPY start.sh .

RUN cd backend && bash update.sh && gzip fireboom
RUN cd oidc && bash update.sh && gzip oidc
RUN cd backend/custom-go && go mod tidy && go build -o ./fb-hook && gzip fb-hook

FROM alpine as prod
RUN apk add bash curl git
WORKDIR /app
COPY --from=builder /app .
EXPOSE 9123 9991
VOLUME [ "/app/backend", "/app/oidc" ]
HEALTHCHECK --interval=2m --timeout=10s --start-period=5s --retries=3 CMD (curl -f http://localhost:9991/ && curl -f http://localhost:9992/ && curl -f http://localhost:9825/ ) || exit 1
CMD [ "bash", "start.sh"]
