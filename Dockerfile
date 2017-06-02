FROM ruby:2.3
MAINTAINER ctoland@analytical.info

RUN apt-get update && apt-get install -y \
  build-essential \
  ca-certificates \
  nodejs

RUN mkdir -p /dockFHIR
WORKDIR /dockFHIR

COPY Gemfile Gemfile.lock ./
RUN gem install unf_ext -v '0.0.7.4' && gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

RUN bundle exec rake db:create && bundle exec rake db:migrate

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
