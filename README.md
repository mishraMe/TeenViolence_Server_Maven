# Spring Boot Web Application

How to execute the project in eclipse. 

1) Import the project as a Maven project in Eclipse; preferablly in Spring Tool Suite 3.7.
2) Build the project. Ensure that you are connected to the network because the project will download a lots of Maven artifacts from the Internet. 
3) Run mysql server on default settings port 3306 with root user and no password. 
4) Use MYSQl workbench to execute the mysql database script musiclibraryv35 to create the MYSQL schema. 
5) Execute edu.neu.cics.cs5200.project.SpringBootWebApplication as a Java Application to run the server.
6) Access http://localhost:8080 to run the application. 


References: 
This project is based on a tutorial series on Spring Boot available from by website at [Spring Framework Guru](https://springframework.guru),
and the Spring MVC pet clinic example.
I have also adopted configuration source code from Mastering Spring MVC book. 
Other pieces I have reused from various websites have also been documented in some classes itself; as references. 
I have generated the Entity Classes from my database using Netbeans Development Platform.
Finally, I have written 80/90 percent code by hand. 





