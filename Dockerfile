FROM ruby:2.2.3
MAINTAINER Chris Olstrom <chris@olstrom.com>

VOLUME /srv/gems
EXPOSE 9292

COPY .mirrorrc /root/.gem/
COPY config.ru Gemfile /srv/app/
WORKDIR /srv/app

CMD ["rackup", "--host", "0.0.0.0"]
