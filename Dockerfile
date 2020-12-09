# define ruby image
FROM ruby:2.7.1

# add yarn to package list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# install psql client, nodejs, and yarn
RUN apt-get update -qq && apt-get install -y postgresql-client yarn

# specify everything will happen within the /login folder inside the container
RUN mkdir login
WORKDIR /login

# copy Gemfiles from current application to the /login container
COPY Gemfile /login
COPY Gemfile.lock /login

# install dependencies
RUN bundle install

# copy yarn.lock from current application to /login container
COPY package.json ./

RUN yarn install --check-files

# copy files current application to the /login container
COPY . /login

# expose port 8000
EXPOSE 5000

# start rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "5000"]
