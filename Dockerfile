FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
# optional: a small healthcheck
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost || exit 1