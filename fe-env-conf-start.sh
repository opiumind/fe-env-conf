#!/bin/bash

#1 Скрипт, который нужно запустить, чтобы началась автоматическая настройка среды
# $1=o.d
set -e

if [ -z "$1" ]; then
    echo -e '\E[37;44m'"\033[1mВы забыли указать при запуске скрипта название вашей среды (например, ig.d)\033[0m"
    exit 1
fi

if [ ! -e fe-env-conf-config.sh ]; then
    echo -e '\E[37;44m'"\033[1mТребуется fe-env-conf-config.sh в текущей директории, а его почему-то нет :( В таком случае придется все вводить вручную, либо остановить скрипт и разобраться с этим.\033[0m"
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

ssh-keygen -R ngs.ru.$1

echo -e '\E[37;44m'"\033[1mВведите, пожалуйста, пароль рута (123123)\033[0m"
ssh-copy-id root@ngs.ru.$1

# Создаем пользователя
echo -e '\E[37;44m'"\033[1mСоздаю пользователя\033[0m"
ssh root@ngs.ru.$1 "bash -s" <<WHERE
set -e
useradd $username
cd /home/
mkdir $username
chown $username:$username $username
adduser $username sudo
WHERE

echo -e '\E[37;44m'"\033[1mСейчас комрад поработает\033[0m"
project_version=$(echo $(curl -s dev.ngs.local/projects/ | grep realty.ngs.ru -A3 | tail -n-1))
echo "Насколько я понял, это последняя версия проекта: "$project_version


ssh root@ngs.ru.$1 "ngs.$jiraid project.deploy:$project_version"

ssh root@ngs.ru.$1 "sudo chown $username:$username -R /data/projects/$project/"

echo -e '\E[37;44m'"\033[1mСейчас надо будет задать пароль своему будущему пользователю\033[0m"
ssh root@ngs.ru.$1 -t passwd $username

echo -e '\E[37;44m'"\033[1mГенерю ключ. Жмите на enter, если в замешательстве\033[0m"
ssh root@ngs.ru.$1 -t "sudo -u $username ssh-keygen -t rsa -C \"$username@office.ngs.ru\""
echo -e '\E[37;44m'"\033[1mКлючик готов\033[0m"

echo -e '\E[37;44m'"\033[1mСкопируйте, плиз, этот ключ в http://git.rn/plugins/servlet/ssh/account/keys и нажмите любую клавишу для продолжения:\033[0m"
ssh root@ngs.ru.$1 "sudo -u $username cat /home/$username/.ssh/id_rsa.pub"
read _tmp

# Настраиваем git, инициализируем репозиторий проекта
ssh root@ngs.ru.$1 "bash -s" <<THERE
set -e
echo -e '\E[37;44m'"\033[1mЕще чуть-чуть. Ставлю git\033[0m"
sudo apt-get install git-core

sudo -iu $username bash -s <<OWCH
set -e
cd /data/projects/$project

echo -e '\E[37;44m'"\033[1mПрописываю в git'е name и email\033[0m"
git config --global user.name "$gitname"
git config --global user.email "$username@office.ngs.ru"

echo -e '\E[37;44m'"\033[1mИнициализирую репозиторий проекта\033[0m"

git init

git remote add origin $projectrep

if [ -f ~/.ssh/known_hosts ]; then
    ssh-keygen -R git.rn
fi

ssh-keyscan -H git.rn >> ~/.ssh/known_hosts

git fetch origin

git checkout -fB master origin/master
OWCH

echo -e '\E[37;44m'"\033[1mВсе сделано. Хорошего настроения :)\033[0m"
THERE
