FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /workdir
COPY . .
WORKDIR /workdir/example
RUN mvn clean package
##
FROM openjdk:17-alpine
WORKDIR /workdir
COPY --from=build /workdir/example/target .
EXPOSE 8080
# this should be dynamic as the account sharing app will not be named this all the time
# ENTRYPOINT [ "java","-jar","account-sharing-app-0.0.1-SNAPSHOT.jar" ]
# an approach m thinking abt is to rename the file
RUN mv `ls *.jar | head -1` output.jar
ENTRYPOINT [ "java","-jar","output.jar" ]