#!/bin/sh

#3 Пользовательские настройки среды

echo "Генерю ключ"
ssh-keygen -t rsa -C "$username@office.ngs.ru"
cat /home/a.solodovnikov/.ssh/id_rsa.pub
echo "Скопируйте, плиз, ключ в http://git.rn/plugins/servlet/ssh/account/keys"
read tmp_

echo "Еще чуть-чуть. Ставлю git"
sudo apt-get install git-core
cd /data/projects/$project/

#git clone $projectrep .
ngs.<jiraid> project.deploy:<version>

echo "Прописываю в git'е name и email"
git config --global user.gitname "$gitname"
git config --global user.email "$username@office.ngs.ru"

echo "Последний шаг. Устанавливаю последнюю версию нгс.фреймворка"

#ln -s $(find /data/releases/framework.ngs.ru/ -type d -maxdepth=1 | sort -nr | head -n1)/library ./framework

echo "Все сделано. Хорошего настроения :)"
exit 0
