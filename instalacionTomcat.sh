#Instalar Tomcat
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
sudo apt update -y
sudo apt upgrade -y
sudo apt install default-jdk -y
java -version
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz
sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin

#Configurar los Administradores
sudo sh -c 'echo "<role rolename=\"manager-gui\" />" >> /opt/tomcat/conf/tomcat-users.xml'
sudo sh -c 'echo "<user username=\"manager\" password=\"contraseña_manager\" roles=\"manager-gui\" />" >> /opt/tomcat/conf/tomcat-users.xml'
sudo sh -c 'echo "<role rolename=\"admin-gui\" />" >> /opt/tomcat/conf/tomcat-users.xml'
sudo sh -c 'echo "<user username=\"admin\" password=\"contraseña_admin\" roles=\"manager-gui,admin-gui\" />" >> /opt/tomcat/conf/tomcat-users.xml'

sudo sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve"//g' /opt/tomcat/webapps/manager/META-INF/context.xml
sudo sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve"//g' /opt/tomcat/webapps/host-manager/META-INF/context.xml

#Creando System
java_path=$(sudo update-java-alternatives -l | awk '{print $3}')
sudo sh -c 'cat <<EOL > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME='$java_path'"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOL'

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

#Acceso a la Web
sudo ufw allow 8080

echo "Tomcat installation script completed."
