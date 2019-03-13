# baseimage one
FROM node:alpine as builder

# Christ Proxy
ENV http_proxy http://10.60.4.1:8080
ENV https_proxy http://10.60.4.1:8080

WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# use baseimage two
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
