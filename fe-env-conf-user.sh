#!/bin/sh

#2 Создаем пользователя под рутом на среде

echo -e '\E[37;44m'"\033[1mСоздаю пользователя\033[0m"
useradd $username && \
cd /home/ && \
mkdir $username && \
chown $username:$username $username && \
adduser $username sudo && \

# cd /data/projects/ && \
# sudo rm $project && \
# sudo mkdir $project && \
# sudo chown $username:$username $project && \

echo -e '\E[37;44m'"\033[1mЗаймемся проектом...\033[0m" && \
version=$(echo $(curl -s dev.ngs.local/projects/ | grep realty.ngs.ru -A3 | tail -n-1)) && \
ngs.$jiraid project.deploy:$version && \

sudo chown $username:$username $project && \

echo "Ой, споткнулся"
exit 1
