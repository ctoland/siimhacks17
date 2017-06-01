FROM ruby:2.3
MAINTAINER ctoland@analytical.info

RUN apt-get update && apt-get install -y \
  build-essential \
  ca-certificates \
  nodejs

RUN mkdir -p /mrfhir
WORKDIR /mrfhir

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
