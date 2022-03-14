<h2>Deploy War file to jenkins Slave node</h2>

<h3> Node requirements </h3>

:one: Download and Install the jdk binary file

wget https://www.oracle.com/in/java/technologies/javase/javase9-archive-downloads.html#license-lightbox

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



:four: install and configure tomacat from binary:

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

<h3> Verify the version </h3>

![image][https://github.com/vijayendrar/devsecops/blob/main/Jenkins/images/version.PNG]



 


