FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 443

COPY ./requirements/nginx/tools/* /etc/nginx/ssl/

COPY ./requirements/nginx/conf/* /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
