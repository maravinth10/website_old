FROM jjaba/tomcat_ara:0.0.1
COPY newapp.war /usr/local/tomcat/webapps/
EXPOSE 8080
