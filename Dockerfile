FROM ruby:2.2.3
MAINTAINER Chris Olstrom <chris@olstrom.com>

VOLUME /srv/gems
EXPOSE 3000

COPY .gem/.mirrorrc /root/.gem/
COPY config.ru Gemfile /srv/app/
COPY lib/ /srv/app/lib/
WORKDIR /srv/app
RUN bundle pack

CMD ["bundle", "exec", "reel-rack"]
