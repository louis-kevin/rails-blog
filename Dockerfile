FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
#COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs=4 --retry=3

COPY . /app

EXPOSE 3000

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]