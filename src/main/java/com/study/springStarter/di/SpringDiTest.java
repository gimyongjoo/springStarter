package com.study.springStarter.di;

import org.apache.catalina.core.ApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Component;

@Component
public class SpringDiTest implements CommandLineRunner {
    @Autowired
    Car car;

    @Autowired
    Engine engine;

    @Autowired
    Door door;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("car = " + car);
        System.out.println("engine = " + engine);
        System.out.println("door = " + door);
    }
}
