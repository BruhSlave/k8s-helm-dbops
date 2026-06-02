FROM node:10-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build 



FROM nginx:1.28-alpine

RUN apk upgrade --no-cache && apk add --no-cache curl 

ENV BACKEND_URL=http://backend:8080

COPY nginx.tmpl /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist/frontend /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/api/products || exit 1

CMD ["nginx", "-g", "daemon off;"]
