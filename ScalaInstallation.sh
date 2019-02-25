#!/bin/sh

# Download the scala
wget http://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.tgz

# Extract the file
tar xvf scala-2.12.1.tgz

# Move the installatio Folder
mv scala-2.12.1 /usr/scala/

#export the path of scala
export PATH=$PATH:/usr/scala/bin

# Update Path Variable
echo 'export PATH=$PATH:/usr/scala/bin' >> ~/.bashrc

# commit scala path
source ~/.bashrc
