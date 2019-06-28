FROM ubuntu:18.04

LABEL "com.github.actions.name"="Insales-CI"
LABEL "com.github.actions.description"="insales-ci"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/insales/insales-ci.git"
LABEL "homepage"="http://github.com/insales/insales-ci.git"

LABEL "maintainer"="Sergey Miroshnichenko <sergey.miroshnichenko@insales.ru>"

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update \
    && apt install -y bash cmake curl gnupg gnupg2 libidn11-dev libsasl2-dev libldap2-dev libsasl2-dev libssl-dev jq \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn \
    && apt install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev \
    && gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.6.2 && rvm use 2.6.2 --default && ruby -v && gem install aasm  && gem install rake  && gem install rugged && gem install rubocop && gem install pronto && gem install pronto-rubocop"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
