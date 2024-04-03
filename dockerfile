FROM alpine:3.19
RUN apk update \
  && apk upgrade \
  && apk add --no-cache python3 py3-pip --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
  && rm -rf /var/cache/apk/*
COPY app.py requirements.txt tailwind.config.js LICENSE /app/
COPY static /app/static
COPY templates /app/templates
WORKDIR /app
RUN python3 -m venv .env && source .env/bin/activate && pip install flask prometheus_client redis --no-cache-dir
ENV PATH="/app/.env/bin:$PATH"
ARG REDIS_HOST
ENV REDIS_HOST=$REDIS_HOST
EXPOSE 5000/tcp
CMD ["flask", "run", "--host=0.0.0.0"]