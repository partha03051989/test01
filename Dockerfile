FROM adoptopenjdk/java-1.11.0-openjdk-amd64
COPY ./target/test01.jar /
EXPOSE 32010
ENTRYPOINT ["java", "-jar", "./test01.jar"]
