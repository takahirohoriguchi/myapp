FROM ruby:3.1

ENV LANG=C.UTF-8 \
  TZ=Asia/Tokyo

# rails用のディレクトリを作成
RUN mkdir /backend
WORKDIR /backend

RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client && apt-get install -y vim
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# COPY my.cnf /etc/mysql/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
