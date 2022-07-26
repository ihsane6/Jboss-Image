FROM centos:7

RUN yum update -y && yum install wget -y ; \
yum install java-1.8.0-openjdk-devel -y ;\
groupadd -r wildfly ; \
useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly ;\
WILDFLY_VERSION=16.0.0.Final ; \
wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz -P /tmp ; \
tar xf /tmp/wildfly-$WILDFLY_VERSION.tar.gz -C /opt/ ; \
ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly ; \
chown -RH wildfly: /opt/wildfly ;
ENV ADMIN_USER admin 
ENV ADMIN_PASSWORD welcome1
RUN /opt/wildfly/bin/add-user.sh --silent=true $ADMIN_USER $ADMIN_PASSWORD 
EXPOSE 8080 
EXPOSE 9990 
CMD ["/opt/wildfly/bin/standalone.sh", "-b=0.0.0.0", "-bmanagement=0.0.0.0"] 
