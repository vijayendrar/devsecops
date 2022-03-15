<h2>1.Deploy War file to jenkins Slave node</h2>

<h3> Node requirements </h3>

:one: Download and Install the jdk binary file for linux

https://www.oracle.com/in/java/technologies/javase/javase9-archive-downloads.html#license-lightbox

:two: copy to the linux machine and extract it

- tar zxvf jdk-9.0.4_linux-x64_bin.tar.gz
- move the extracted folder /opt/java/jdk-9.0.4/
- configure java using below mention command 

<h3>Run the command from /opt/java/jdk-9.0.4/ </h3>

- update-alternatives --install /usr/bin/java java /opt/java/jdk-9.0.4/bin/java 100
- update-alternatives --config java

- update-alternatives --install /usr/bin/javac javac /opt/java/jdk-9.0.4/bin/javac 100
- update-alternatives --config javac

- update-alternatives --install /usr/bin/jar jar /opt/java/jdk-9.0.4/bin/jar 100
- update-alternatives --config jar

<h3> setup java environment variable </h3>

- export JAVA_HOME=/opt/java/jdk-9.0.4/
- export JRE_HOME=/opt/java/jdk-9.0.4/jre
- export PATH=$PATH:/opt/java/jdk-9.0.4/bin:/opt/java/jdk-9.0.4/jre/bin

NOTE: configure in /etc/profile to make it permanent

:three: install and configure maven 

- wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
- tar zxvf apache-maven-3.8.5-bin.tar.gz
- mv  apache-maven-3.8.5 /opt/maven/
- nano /etc/profile.d/apachemaven.sh
  
---
    export JAVA_HOME=/opt/java/jdk-9.0.4/bin/java
    export M2_HOME=/opt/apache-maven-3.8.5
    export MAVEN_HOME=/opt/apache-maven-3.8.5
    export PATH=${M2_HOME}/bin:${PATH}
---

<h3>verify version </h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/version.PNG)

:four: install and configure tomcat from binary:

- wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.tar.gz
- tar zxvf apache-tomcat-9.0.59.tar.gz -C  /opt/tomcat --strip-components=1
- sudo chown -R tomcat:tomcat /opt/tomcat/
- sudo nano /etc/systemd/system/tomcat.service

---
    [Unit]
    Description=Tomcat
    After=network.target

    [Service]
    Type=forking

    User=tomcat
    Group=tomcat

    Environment="JAVA_HOME=/usr"
    Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
    Environment="CATALINA_BASE=/opt/tomcat"
    Environment="CATALINA_HOME=/opt/tomcat"
    Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
    Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

    ExecStart=/opt/tomcat/bin/startup.sh
    ExecStop=/opt/tomcat/bin/shutdown.sh
---

- systemctl daemon-reload 
- systemctl enable tomcat.service
- systemctl start tomcat.service
- sudo vim /opt/tomcat/conf/tomcat-users.xml

```xml


  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <user username="tomcat" password="Root@123" roles="manager-gui,manager-script"/>

```  
- comment out text in /opt/tomcat/webapps/manager/META-INF/context.xml

```xml 

<!-->
 <Valve className="org.apache.catalina.valves.RemoteAddrValve"
 allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->

```
- systemctl restart tomcat.service

<h2>2.configuration on the master node </h2>

<h3>2.1 create freestyle job with below mention configuration </h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/packageapp.jpg)

:one: once you click on build now then it will create the artifacts

![image](https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/artifacts.jpg)


<h3>2.2 deploy artifacts to  tomact server node ,which is slave node in our case</h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/deploy.jpg)

Note: username is tomcat and Password is Root@123 which is earlier configure in tomcat 

<h3>2.3 check the webpage after deployment</h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/nodeapp.jpg)
  