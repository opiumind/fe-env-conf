#!/bin/sh

#2 Создаем пользователя под рутом на среде

echo "Создаю пользователя"
useradd $username
cd /home/
mkdir $username
chown $username:$username $username
passwd $username
adduser $username sudo

cd /data/projects/
rm $project
mkdir $project
chown $username:$username $project
