FROM oven/bun:alpine as builder
RUN apk add git
WORKDIR /app
COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile
COPY ./ ./
RUN bun run build

FROM nginx:alpine as production
COPY ./docker/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=builder /app/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT envsubst '${FB_API_URL}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
