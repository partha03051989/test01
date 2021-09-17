FROM adoptopenjdk/openjdk11:jre-11.0.10_9-alpine
COPY ./target/my-app-1.0-SNAPSHOT.jar /
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "./test01.jar"]
