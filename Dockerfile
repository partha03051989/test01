FROM adoptopenjdk/java-1.11.0-openjdk-amd64
COPY ./target/my-app-1.0-SNAPSHOT.jar /
EXPOSE 32010
ENTRYPOINT ["java", "-jar", "./test01.jar"]
