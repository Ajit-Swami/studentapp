FROM ubuntu:latest

LABEL dev="Ishika"

RUN apt-get update && \
    apt-get install -y default-jdk unzip curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TOMCAT_VERSION=9.0.91
ENV CATALINA_HOME=/opt/tomcat
ENV PATH="$PATH:$CATALINA_HOME/bin"

RUN wget --no-check-certificate https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mkdir -p $CATALINA_HOME && \
    tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz -C $CATALINA_HOME --strip-components=1 && \
    rm apache-tomcat-$TOMCAT_VERSION.tar.gz 


WORKDIR ${CATALINA_HOME}

RUN curl -fSL https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war  -o webapps/student.war && \
    curl -fSL https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar -o lib/mysql-connector.jar

COPY context.xml conf/context.xml

RUN chmod +x bin/*.sh

EXPOSE 8080

CMD ["sh", "-c", "catalina.sh run"]