#!/bin/sh

#2 Создаем пользователя под рутом на среде

echo "Создаю пользователя"
useradd $username && \
cd /home/ && \
mkdir $username && \
chown $username:$username $username && \
passwd $username && \
echo "Типа создан пароль пользователя"
adduser $username sudo && \

cd /data/projects/ && \
sudo rm $project && \
sudo mkdir $project && \
sudo chown $username:$username $project && \

echo "Пользователь создан, папка проекта создана"