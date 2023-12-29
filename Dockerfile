FROM jjaba/myweb:0.0.2
# Take the war and copy to webapps of tomcat
COPY newapp.war /usr/local/tomcat/webapps/
EXPOSE 80
