FROM openjdk:17
ADD target/MyWebApp.jar MyWebApp.jar
ENTRYPOINT ["java","-jar","/MyWebApp.jar"]
