#!/bin/bash

#1 Скрипт, который нужно запустить, чтобы началась автоматичсекая настройка среды
# $1=o.d

if [ -z "$1" ]; then
    echo -e '\E[37;44m'"\033[1mВы забыли указать при запуске скрипта название вашей среды (например, ig.d)\033[0m"
    exit 1
fi

if [ ! -e fe-env-conf-config.sh ]; then
    echo -e '\E[37;44m'"\033[1mТребуется fe-env-conf-config.sh в текущей директории, а его почему-то нет :(\033[0m"
else
    source fe-env-conf-config.sh
fi

if [ -z "$username" ]; then
    read -p $'\033'"[1;37;44mУкажите ваш username (например, o.lisovskaya):"$'\033'"[0m " username
fi

if [ -z "$project" ]; then
    read -p $'\033'"[1;37;44mУкажите ваш проект (например, realty.ngs.ru):"$'\033'"[0m " project
fi

if [ -z "$jiraid" ]; then
    read -p $'\033'"[1;37;44mjiraid (например, rn):"$'\033'"[0m " jiraid
fi

if [ -z "$projectrep" ]; then
    read -p $'\033'"[1;37;44mУкажите репу вашего проекта (например, ssh://git@git.rn/ngs/rn.git). Можно посмотреть на git.rn:"$'\033'"[0m " projectrep
fi

if [ -z "$gitname" ]; then
    read -p $'\033'"[1;37;44m\033[1;37;44mКакой name в git'е хотите? (например, Olga Lisovskaya):"$'\033'"[0m " gitname
fi

ssh-keygen -R ngs.ru.$1 && \

echo -e '\E[37;44m'"\033[1mВведите, пожалуйста, пароль рута (123123)\033[0m" && \
ssh-copy-id root@ngs.ru.$1 && \

ssh root@ngs.ru.$1 "username=$username project=$project jiraid=$jiraid bash -s" < fe-env-conf-user.sh && \

echo -e '\E[37;44m'"\033[1mСейчас надо будет задать пароль своему будущему пользователю\033[0m" && \
ssh root@ngs.ru.$1 -t passwd $username && \

echo -e '\E[37;44m'"\033[1mГенерю ключ. Жмите на enter\033[0m" && \
ssh $username@ngs.ru.$1 -t "ssh-keygen -t rsa -C \"$username@office.ngs.ru\"" && \
echo -e '\E[37;44m'"\033[1mКлючик готов\033[0m" && \

ssh $username@ngs.ru.$1 "env=$1 username=$username project=$project projectrep=$projectrep $gitname=gitname bash -s" < fe-env-conf-other.sh && \

echo "Почему-то я здесь"
exit 1