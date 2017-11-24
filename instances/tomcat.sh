#!/bin/bash/
#entOS 7 (sudo)
#Opens jmx port

#Tomcat user and pass
tomcat_user="admin"
tomcat_password="admin"

#Install java 7
echo "y" | sudo yum install java-1.7.0-openjdk-devel
echo "y" | sudo yum install java-1.7.0-openjdk
sudo alternatives --config java

#Install maven
cd /opt
echo "y" | sudo yum install wget
wget -O /opt/apache-maven-3.5.0-bin.tar.gz http://www-eu.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
sudo tar xzf /opt/apache-maven-3.5.0-bin.tar.gz
sudo ln -s /opt/apache-maven-3.5.0  maven
sudo touch /etc/profile.d/maven.sh
sudo echo -e '#!/bin/bash \n export M2_HOME=/opt/maven \n export PATH=${M2_HOME}/bin:${PATH} ' | sudo tee --append /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
export M2_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
rm -f /opt/apache-maven-3.5.0-bin.tar.gz

#Install tomcat
echo "y" | sudo yum install httpd
echo "y" | sudo yum install tomcat
sudo echo -e 'JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9000 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.rmi.port=9000"' | sudo tee --append /usr/share/tomcat/conf/tomcat.conf
echo "y" | sudo yum install tomcat-webapps tomcat-admin-webapps 
echo "y" | sudo yum install tomcat-docs-webapp tomcat-javadoc
sudo sed "/<\/tomcat-users>/i <role rolename=\"manager-gui\"\/>\n<role rolename=\"manager-jmx\"\/>\n<role rolename=\"manager\"\/>\n<role rolename=\"manager-script\"\/>\n<user username=\"$tomcat_user\" password=\"$tomcat_password\" roles=\"manager-gui,manager,manager-script,manager-jmx\"\/>\n" /usr/share/tomcat/conf/tomcat-users.xml | sudo tee /usr/share/tomcat/conf/tomcat-users2.xml
sudo mv /usr/share/tomcat/conf/tomcat-users2.xml /usr/share/tomcat/conf/tomcat-users.xml
sudo firewall-cmd --zone=public --add-port=8080/tcp
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=9000/tcp
sudo firewall-cmd --zone=public --add-port=9000/tcp --permanent
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl start httpd
sudo systemctl enable httpd

#Security-Enhanced Linux
sudo sed -i 's/SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
sudo setenforce 0

#Configure tomcat+maven (deploy)
sudo sed "/<\/servers>/i <server>\n<id>TomcatServer<\/id>\n<username>$tomcat_user<\/username>\n<password>$tomcat_password<\/password>\n<\/server>\n" /opt/maven/conf/settings.xml | sudo tee /opt/maven/conf/settings2.xml
sudo mv /opt/maven/conf/settings2.xml /opt/maven/conf/settings.xml
