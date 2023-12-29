FROM jjaba/myweb:0.0.2
COPY newapp.war /usr/local/tomcat/webapps/
EXPOSE 8080
