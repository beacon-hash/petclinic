FROM openjdk
ARG appName="spring-petclinic" 
ARG appVersion="3.0.0"
RUN mkdir /myapp 
WORKDIR /myapp 
COPY target/${appName}-${appVersion}.jar /myapp
ENV APP_ARTIFACT=${appName}-${appVersion}.jar
CMD java -jar ${APP_ARTIFACT}