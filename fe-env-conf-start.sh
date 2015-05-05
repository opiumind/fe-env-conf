#!/bin/bash

#1 Скрипт, который нужно запустить, чтобы началась автоматичсекая настройка среды
# $1=o.d

if [ -z "$1" ]; then
    echo "Вы забыли указать при запуске скрипта название вашей среды (например, ig.d)"
    exit 1
fi

if [ ! -e fe-env-conf-config.sh ]; then
    echo "Требуется fe-env-conf-config.sh в текущей директории, а его почему-то нет :("
else
    source fe-env-conf-config.sh
fi

if [ -z "$username" ]; then
    read -p "Укажите ваш username (например, o.lisovskaya):" username
fi

if [ -z "$project" ]; then
    read -p "Укажите ваш проект (например, realty.ngs.ru):" project
fi

if [ -z "$jiraid" ]; then
    read -p "jiraid (например, rn):" jiraid
fi

if [ -z "$projectrep" ]; then
    read -p "Укажите репу вашего проекта (например, ssh://git@git.rn/ngs/rn.git). Можно посмотреть на git.rn:" projectrep
fi

if [ -z "$gitname" ]; then
    read -p "Какой name в git'е хотите? (например, Olga Lisovskaya):" gitname
fi

    # echo "Советую указать эти данные в fe-env-conf-config.sh, чтобы в следующий раз не пришлось вводить вручную."

ssh root@ngs.ru.$1 "username=$username project=$project bash -s" < fe-env-conf-user.sh && \
echo "Подключились по ssh под рутом"
ssh $username@ngs.ru.$1 "env=$1 username=$username project=$project jiraid=$jiraid projectrep=$projectrep $gitname=gitname bash -s" < fe-env-conf-other.sh && \
echo "Подключились по ssh под вашим пользователем"
