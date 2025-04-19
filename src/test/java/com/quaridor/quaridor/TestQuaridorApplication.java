package com.quaridor.quaridor;

import org.springframework.boot.SpringApplication;

public class TestQuaridorApplication {

    public static void main(String[] args) {
        SpringApplication.from(QuaridorApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
