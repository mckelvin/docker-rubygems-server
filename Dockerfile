FROM ruby:2.2.3
MAINTAINER Chris Olstrom <chris@olstrom.com>

VOLUME /srv/gems
EXPOSE 9292

COPY .mirrorrc /root/.gem/
COPY config.ru Gemfile /srv/app/
WORKDIR /srv/app
RUN bundle pack

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
