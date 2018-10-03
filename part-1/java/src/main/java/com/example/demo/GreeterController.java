package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * GreeterController
 */
@RestController
public class GreeterController {

    @Value("${MESSAGE_PREFIX}")
    private String prefix;

    @GetMapping("/")
    public String greet() {
        return prefix + "Java::Knative on OpenShift";
    }
}