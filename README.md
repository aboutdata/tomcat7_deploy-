# tomcat7_deploy-
使用命令行(shell 脚本发布)方式，发布项目到tomcat服务器
```
[root@tw-office-vm-web-dev tomcat_deploy]# ll
总计 14704
-rwxr-xr-x 1 root root     2702 07-24 16:50 deploy_functions.sh
-rwxr-xr-x 1 root root     1894 07-27 16:40 deploy.sh
-rw-r--r-- 1 root root 15012103 07-27 16:16 InternetHospitalWeb.war
-rwxr-xr-x 1 root root     1081 07-24 16:50 LICENSE
-rwxr-xr-x 1 root root      648 07-24 16:50 README.md
-rwxr-xr-x 1 root root      771 07-24 16:50 wget_wars.sh
[root@tw-office-vm-web-dev tomcat_deploy]# ./deploy.sh 
Checking /root/tomcat_deploy/InternetHospitalWeb.war for integrity:  OK
Stopping tomcat
Using CATALINA_BASE:   /usr/local/tomcat7.0.53-WEB
Using CATALINA_HOME:   /usr/local/tomcat7.0.53-WEB
Using CATALINA_TMPDIR: /usr/local/tomcat7.0.53-WEB/temp
Using JRE_HOME:        /usr/local/jdk1.7.0_55
Using CLASSPATH:       /usr/local/tomcat7.0.53-WEB/bin/bootstrap.jar:/usr/local/tomcat7.0.53-WEB/bin/tomcat-juli.jar
Waiting for tomcat to stop...
Tomcat stopped.
Deploying InternetHospitalWeb.war
Starting tomcat
Using CATALINA_BASE:   /usr/local/tomcat7.0.53-WEB
Using CATALINA_HOME:   /usr/local/tomcat7.0.53-WEB
Using CATALINA_TMPDIR: /usr/local/tomcat7.0.53-WEB/temp
Using JRE_HOME:        /usr/local/jdk1.7.0_55
Using CLASSPATH:       /usr/local/tomcat7.0.53-WEB/bin/bootstrap.jar:/usr/local/tomcat7.0.53-WEB/bin/tomcat-juli.jar
Tomcat started.
Waiting for tomcat to start...
Waiting for InternetHospitalWeb to start... http://localhost:9080/InternetHospitalWeb/login
Deploy finished OK.
```
