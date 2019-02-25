#!/bin/bash

# do the following
sudo -i

# env | grep proxy
# if proxy settings are not set then set them and execute the following commands

# Adding key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# add mongodb to apt sources list
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

apt-get update

apt-get install -y mongodb-org

sudo service mongod status

# To go to mongodb command line type
# mongo

# refer:
# https://www.howtoforge.com/tutorial/install-mongodb-on-ubuntu-16.04/
