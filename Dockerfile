FROM python:3.12-slim
RUN apt-get update -qqy && \
    apt-get install -qy \
      python3-requests python3-feedparser python3-lxml \
    && apt-get remove -qy --purge \
       apparmor libapparmor1 \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*

RUN pip install uv
RUN mkdir -p /app
COPY . /app/rss2newsletter
WORKDIR /app
RUN uv pip install --system ./rss2newsletter

# Mount the config files, templates etc into the container
# at the /app directory - we run from there.

ENV PYTHONUNBUFFERED=1
CMD [ "rss2newsletter" ]
