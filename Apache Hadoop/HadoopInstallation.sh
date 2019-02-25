#!/bin/sh

# Create a system user account to use for hadoop installation
useradd hadoop
passwd hadoop

# Configure the ssh keys for the user hadoop
### Login to hadoop
su - hadoop
### Generating SSH Key
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
### Authorize the key
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
### Set chmod
chmod 0600 ~/.ssh/authorized_keys
### Verify key works / check no password is needed
ssh localhost
exit
### Download and install hadoop tarball from apache in the hadoop $HOME directory
cd ~
wget http://apache.claz.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
tar xzf hadoop-2.7.3.tar.gz
mv hadoop-2.7.3 hadoop

### Setup Environment Variables. Add the following lines to the .bashrc
export JAVA_HOME=/usr/java/jdk1.8.0_111/    # echo 'export JAVA_HOME=/usr/java/jdk1.8.0_111/' >> ~/.bashrc
export HADOOP_HOME=/home/hadoop/hadoop/
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export JAVA_LIBRARY_PATH=$HADOOP_HOME/lib/native:$JAVA_LIBRARY_PATH


### Initiate variables
source ~/.bashrc

### Put the property info below between the “configuration” tags for each file tags for each file

### Edit $HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e '/<configuration>/a <property><name>fs.default.name</name> <value>hdfs://localhost:9000</value></property>' $HADOOP_HOME/etc/hadoop/core-site.xml
<property>
<name>fs.default.name</name>
<value>hdfs://localhost:9000</value>l
</property>

### Edit $HADOOP_HOME/etc/hadoop/hdfs-site.xml
<property>
<name>dfs.replication</name>
<value>1</value>
</property>

<property>
<name>dfs.name.dir</name>
<value>file:///home/hadoop/hadoopdata/hdfs/namenode</value>
</property>

<property>
<name>dfs.data.dir</name>
<value>file:///home/hadoop/hadoopdata/hdfs/datanode</value>
</property>

### copy template
cp $HADOOP_HOME/etc/hadoop/mapred-site.xml.template $HADOOP_HOME/etc/hadoop/mapred-site.xml

### Edit $HADOOP_HOME/etc/hadoop/mapred-site.xml
<property>
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>

### Edit $HADOOP_HOME/etc/hadoop/yarn-site.xml
<property>
<name>yarn.nodemanager.aux-services</name>
<value>mapreduce_shuffle</value>
</property>

### Set JAVA_HOME
### Edit $HADOOP_HOME/etc/hadoop/hadoop-env.sh and add the following line
export JAVA_HOME=/usr/java/jdk1.8.0_111/

# Format namenode to keep the metadata related to datanodes
hdfs namenode -format

# Run start-dfs.sh script
start-dfs.sh

# Check that HDFS is running
# Check there are 3 java processes:
# Namenode
# Secondarynamenode
# Datanode
start-yarn.sh

# Check there are 2 more java processes:
# Resourcemananger
# Nodemanager

# Test hadoop
### Cccess hadoop via the browser on port 50070
ping http://localhost:50070/

# stop-dfs.sh to stop the namenode, datanode
# stop-yarn.sh to stop the resource manager and node manager
# And if datanode is not starting delete "/usr/local/hadoop/hadoopdata/current" folder and format the name node
# sudo rm -r   /usr/local/hadoop/hadoopdata/current
# And then start the services

# Now access port 8088 for getting the information about cluster and all applications


### put a file
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/hadoop
bin/hdfs dfs -put /var/log/samba /user/hadoop/
### Check in your browser if the file is available


### Refer these links
# http://tecadmin.net/setup-hadoop-2-4-single-node-cluster-on-linux/
# https://malderhout.wordpress.com/2014/08/22/install-single-node-hadoop-on-centos-7-in-5-simple-steps/




### If the below Error occurs do the following :
# org.apache.hadoop.hdfs.server.namenode.SafeModeException: Cannot create directory /user/root/. Name node is in safe mode

# solution:
# In order to forcefully let the namenode leave safemode, following command should be executed:

# bin/hadoop dfsadmin -safemode leave

# You are getting Unknown command error for your command as -safemode isn't a sub-command for hadoop fs, but it is of hadoop dfsadmin.

# Also after the above command, I would suggest you to once run hadoop fsck so that any inconsistencies crept in the hdfs might be sorted out.
# Use hdfs command instead of hadoop command for newer distributions. The hadoop command is being deprecated:

# hdfs dfsadmin -safemode leave

# hadoop dfsadmin has been deprecated and so is hadoop fs command, all hdfs related tasks are being moved to a separate command hdfs

# reference:
# http://stackoverflow.com/questions/15803266/name-node-is-in-safe-mode-not-able-to-leave
