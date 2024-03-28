FROM alpine:3.19
RUN apk update \
  && apk upgrade \
  && apk add --no-cache python3 py3-pip redis --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
  && rm -rf /var/cache/apk/*
COPY static/ templates/ app.py requirements.txt tailwind.config.js LICENCE /app/
WORKDIR /app
ENV REDIS_HOST=localhost
RUN pip install -r requirements.txt
EXPOSE 80/tcp
ENTRYPOINT ["flask run --host=0.0.0.0"]