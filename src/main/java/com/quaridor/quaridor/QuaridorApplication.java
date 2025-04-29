package com.quaridor.quaridor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableMongoRepositories
public class QuaridorApplication {

    public static void main(String[] args) {
        SpringApplication.run(QuaridorApplication.class, args);
    }

}
