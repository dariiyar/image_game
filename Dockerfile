FROM ruby:2.6.5
RUN apt-get update -qq
RUN apt-get install -y \
      build-essential\
      libffi-dev \
      libc-dev \
      libxml2-dev \
      libxslt-dev \
      libpq-dev\
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      python \
      qt5-default\
      tzdata \
      npm\
      yarn

RUN mkdir /image_game
WORKDIR /image_game
COPY Gemfile /image_game/Gemfile
COPY Gemfile.lock /image_game/Gemfile.lock
RUN bundle install
COPY . /image_game

RUN npm install --global yarn

# Add a script to be executed every time the container starts.
EXPOSE 3000
