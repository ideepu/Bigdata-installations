#!/bin/sh

# Installation steps for java on ubuntu
# Enable Debug Mode 
set -x
# Removing older versions of java
echo "Removing  OpenJDK/JRE from your system.............\n"
sudo apt-get purge openjdk-\*
echo "Installing java ........."
# Checking whether the directory exist or not
echo "Creating directory /user/local/java ............."
path="/usr/local/java"
if [ ! -d $path ]
then
    sudo mkdir -p $path  # If does not exist, create a directory
fi
cd $path # Change directory to which you want download java file

# Checking whether the file is already downloaded
filepath="/user/local/java/jdk1.8.0_111"
if [ ! -d $filepath ]
then
    echo "Select your operating system............"
    echo "1.64 bit \n 2.32 bit\n"
    read n
    if [ $n == 1 ]
    then
        if [ ! -f "jdk-8u111-linux-x64.tar.gz" ]
        then
            echo "Downloading java ..................."
            wget -O /opt/java/jdk-8u111-linux-x64.tar.gz --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz
            # Unzip the downloaded file
            echo "Extracting the file ............."
            tar -zxvf jdk-8u111-linux-x64.tar.gz
        else
            echo "Extracting the file ............."
            tar -zxvf jdk-8u111-linux-x64.tar.gz
        fi
    else
        if [ $n == 2 ]
        then
            if [ ! -f "jdk-8u111-linux-i586.tar.gz" ]
            then
                echo "Downloading java ..................."
                wget -O /opt/java/jdk-8u111-linux-i586.tar.gz --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-i586.tar.gz
                # Unzip the downloaded file
                echo "Extracting the file ............."
                tar -zxvf jdk-8u111-linux-i586.tar.gz
            else
                echo "Extracting the file ............."
                tar -zxvf jdk-8u111-linux-i586.tar.gz
            fi
        fi
    fi
fi

# Change to new extracted directory
cd $filepath

echo "Updating Java alternatives ..............."
# updating java alternatives
update-alternatives --install "/usr/bin/java" "java" "/user/local/java/jdk1.8.0_111/bin/java" 100
# update-alternatives --config java

echo "Updating Javac alternatives ..............."
# updating javac alternatives
update-alternatives --install "/usr/bin/javac" "javac" "/user/local/java/jdk1.8.0_111/bin/javac" 100
# update-alternatives --config javac

echo "Updating Jre alternatives ..............."
# updating jre alternatives
update-alternatives --install "/usr/bin/jar" "jar" "/user/local/java/jdk1.8.0_111/bin/jar" 100
# update-alternatives --config jar

# Inform your Linux system that Oracle Java JDK/JRE must be the default Java.
echo "Inform your Linux system that Oracle Java JDK/JRE must be the default Java ..................... "
echo "Setting jdk for the system .........."
# Set jdk for the system
update-alternatives --set java /user/local/java/jdk1.8.0_111/bin/java
echo "Setting javac compiler for the system ........"
# Set javac compiler for the system
update-alternatives --set javac /user/local/java/jdk1.8.0_111/bin/javac
echo "Setting jar for the system ..........."
# Set jar for the system
update-alternatives --set jar /user/local/java/jdk1.8.0_111/bin/jar

echo "Setting up the java environment variables"
# Setting up java environment variables
export JAVA_HOME=/user/local/java/jdk1.8.0_111/
export JRE_HOME=/user/local/java/jdk1.8.0_111/jre
export PATH=$PATH:/user/local/java/jdk1.8.0_111/bin:/opt/java/jdk1.8.0_111/jre/bin

echo "Installation completed ........"

echo "NOTE:if you are getting  'bash: /usr/bin/java: No such file or directory' error, execute the following command
This is because there is some 32 bit libraries are missing in your Ubuntu 64 bit.
apt-get install libc6-i386"


# ## Installing java using ppa 

# # Add the PPA.
# sudo add-apt-repository ppa:webupd8team/java

# # Update and install the installer script
# sudo apt update; sudo apt install oracle-java8-installer

# # Set Java environment variables
# sudo apt install oracle-java8-set-default


# installation steps for java on centos
# http://www.oracle.com/technetwork/java/javase/downloads/index.html
# On the new page select the option "(¤) Accept License Agreement"
# download the suitable rpm package for your system (32 bit or 64 bit )
# you may already have a old version Java  installed on your box... before installing the downloaded rpm remove previous Java by running this command
# yum remove java
# installing java  on centOS
# $ rpm -Uvh jdk-7u67-linux-x64.rpm
# $ alternatives --install /usr/bin/java java /usr/java/latest/bin/java 2
