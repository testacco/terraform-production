#Tomcat user and pass
tomcat_user="admin"
tomcat_password="admin"

#Install java 7
sudo yum install java-1.7.0-openjdk-devel -y

#Install tomcat
sudo yum install tomcat -y
sudo sh -c "echo -e 'JAVA_OPTS=\"-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC\"'" | sudo tee --append /usr/share/tomcat/conf/tomcat.conf
sudo yum install tomcat-webapps tomcat-admin-webapps -y
sudo sed "/<\/tomcat-users>/i <role rolename=\"manager-gui\"\/>\n<role rolename=\"manager-jmx\"\/>\n<role rolename=\"manager\"\/>\n<role rolename=\"manager-script\"\/>\n<user username=\"$tomcat_user\" password=\"$tomcat_password\" roles=\"manager-gui,manager,manager-script,manager-jmx\"\/>\n" /usr/share/tomcat/conf/tomcat-users.xml | sudo tee /usr/share/tomcat/conf/tomcat-users2.xml
sudo mv /usr/share/tomcat/conf/tomcat-users2.xml /usr/share/tomcat/conf/tomcat-users.xml

sudo systemctl start tomcat
sudo systemctl enable tomcat

#Security-Enhanced Linux
sudo sed -i 's/SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
sudo setenforce 0

