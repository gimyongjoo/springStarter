package com.study.springStarter.di;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component class Engine {}
@Component class Door {}
@Component class SportsCar extends Car {}
@Component class Truck extends Car {}

@Component
public class Car {
    @Value("red") private String color;
    @Value("100") private int oil;
    @Autowired private Engine engine;
    @Autowired private Door[] door;

    @Override
    public String toString() {
        return "Car{" +
                "color='" + color + '\'' +
                ", oil=" + oil +
                ", engine=" + engine +
                ", door=" + Arrays.toString(door) +
                '}';
    }
}