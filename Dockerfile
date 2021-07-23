FROM ruby:3.0.2-slim AS builder

#ENV LANG en_US.UTF-8

RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install git make gcc g++ libpq-dev curl wait-for-it --no-install-recommends -y ; \
    curl -sL https://deb.nodesource.com/setup_14.x | bash -; \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ; \
    apt-get update -y ; \
    apt-get install nodejs yarn --no-install-recommends -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

#RUN apt-get update -qq \
#  && apt-get install -y \
#  apt-transport-https \
#  build-essential \
#  ca-certificates \
#  curl \
#  git \
#  libpq-dev \
#  && curl -sL https://deb.nodesource.com/setup_10.x | bash \
#  && apt-get update -qq \
#  && apt-get install -y nodejs \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app

COPY .ruby-version .ruby-version

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV production

ENV RAILS_LOG_TO_STDOUT true

ENV RUBYGEMS_VERSION 3.2.24

RUN gem update --system "$RUBYGEMS_VERSION"

ENV BUNDLER_VERSION 2.2.24

# skipcq: DOK-DL3028
RUN gem install bundler --version "$BUNDLER_VERSION" --force

RUN gem --version

RUN bundle --version

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config set --global frozen 1

# two jobs
RUN bundle config set --global jobs 2

# install only production gems without development and test
RUN bundle config set --global without development test

# retry 5 times before fail
RUN bundle config set --global retry 5

RUN bundle install


#13 4.840
#13 4.840 ------------------------------------------------------------------------------
#13 4.840
#13 4.840 RubyGems installed the following executables:
#13 4.840 	/usr/local/bin/gem
#13 4.840 	/usr/local/bin/bundle
#13 4.840 	/usr/local/bin/bundler

#21 36.42 inspection.
#21 36.42 Results logged to
#21 36.42 /usr/local/bundle/extensions/x86_64-linux/3.0.0/pg-1.2.3/gem_make.out



#COPY Gemfile* /app/
#RUN gem install bundler \
#  && bundle config --global frozen 1 \
#  && bundle config --global without "development test" \
#  && bundle install -j4 --retry 3 \
#  && rm -rf /usr/local/bundle/cache/*.gem \
#  && find /usr/local/bundle/gems/ -name "*.c" -delete \
#  && find /usr/local/bundle/gems/ -name "*.o" -delete
#
#COPY . /app
#
## The SECRET_KEY_BASE here isn't used. Precomiling assets doesn't use your
## secret key, but Rails will fail to initialize if it isn't set.
#RUN RAILS_ENV=production \
#  PRECOMPILE=true \
#  SECRET_KEY_BASE=no \
#  RAILS_SERVE_STATIC_FILES=true \
#  bundle exec rake assets:precompile && \
#  rm -rf node_modules tmp/cache spec

FROM ruby:3.0.2-slim

#ENV LANG en_US.UTF-8

RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

#RUN apt-get update -qq \
#  && apt-get install -y libjemalloc2 nodejs postgresql-client \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*
#
#RUN groupadd --gid 1000 app && \
#  useradd --uid 1000 --no-log-init --create-home --gid app app
#USER app

COPY --from=builder --chown=app:app /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app

#ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
#ENV RACK_ENV=production
#ENV RAILS_ENV=production
#ENV RAILS_LOG_TO_STDOUT true
#ENV RAILS_SERVE_STATIC_FILES true
#
#WORKDIR /app
#CMD bundle exec puma -p $PORT -C /app/config/puma.rb
