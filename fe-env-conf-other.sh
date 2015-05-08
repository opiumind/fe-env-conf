#!/bin/sh

#3 Пользовательские настройки среды

cat /home/$username/.ssh/id_rsa.pub && \
echo -e '\E[37;44m'"\033[1mСкопируйте, плиз, ключ в http://git.rn/plugins/servlet/ssh/account/keys\033[0m" && \

echo -e '\E[37;44m'"\033[1mЕще чуть-чуть. Ставлю git\033[0m" && \
sudo apt-get install git-	core && \

echo -e '\E[37;44m'"\033[1mПрописываю в git'е name и email\033[0m" && \
git config --global user.gitname "$gitname" && \
git config --global user.email "$username@office.ngs.ru" && \

git init && \
git remote add origin $projectrep && \
git pull && \
git checkout -fB master origin/master && \

echo -e '\E[37;44m'"\033[1mВсе сделано. Хорошего настроения :)\033[0m"
exit 0
