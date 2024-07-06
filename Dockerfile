FROM openjdk:17
COPY spring-petclinic-3.2.0-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java","-jar","spring-petclinic-3.2.0-SNAPSHOT.jar"]
