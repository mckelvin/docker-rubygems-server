FROM ruby:2.2.3
MAINTAINER Chris Olstrom <chris@olstrom.com>

VOLUME /srv/gems
EXPOSE 9292

COPY .mirrorrc /root/.gem/.mirrorrc
COPY config.ru /root/.gem/mirror/config.ru
WORKDIR /root/.gem/mirror

CMD ["rackup", "--host", "0.0.0.0"]
