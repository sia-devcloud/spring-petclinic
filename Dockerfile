FROM maven:3.9.6-sapmachine-21 AS build
RUN cd /tmp
RUN git clone "https://github.com/spring-projects/spring-petclinic.git"
RUN cd /spring-petclinic
RUN mvn clean package
FROM eclipse-temurin:17.0.11_9-jdk-jammy
USER nobody
COPY --chown=nobody:nobody --from=build /tmp/spring-petclinic/target/spring-petclinic-3.3.0-SNAPSHOT.jar /tmp/springPetclinic.jar
RUN cd /tmp/
CMD [ "java","-jar", "springPetclinic.jar"]
