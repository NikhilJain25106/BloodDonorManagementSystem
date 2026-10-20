package com.blooddonor;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import java.io.File;

public class Main {

    public static void main(String[] args) throws Exception {

        // 1. Resolve Port (Railway PORT environment variable, fallback 8080)
        String port = System.getenv("PORT");
        if (port == null || port.trim().isEmpty()) {
            port = "8080";
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));

        // 2. Set safe base directory for Tomcat work/temp files
        File baseDir = new File(System.getProperty("java.io.tmpdir"), "tomcat-lifedrop");
        if (!baseDir.exists()) {
            baseDir.mkdirs();
        }
        tomcat.setBaseDir(baseDir.getAbsolutePath());

        tomcat.getConnector(); // Initialize default HTTP connector

        // 3. Resolve webapp directory with path fallbacks
        File webappDir = new File("src/main/webapp");
        if (!webappDir.exists()) {
            webappDir = new File("/app/src/main/webapp");
        }
        if (!webappDir.exists()) {
            webappDir = new File("../src/main/webapp");
        }
        if (!webappDir.exists()) {
            webappDir = new File("webapp");
        }

        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());

        // 4. Map classes directory if present on filesystem (for Servlet scanning)
        File classesDir = new File("target/classes");
        if (!classesDir.exists()) {
            classesDir = new File("/app/target/classes");
        }
        if (!classesDir.exists()) {
            classesDir = new File("../target/classes");
        }

        if (classesDir.exists()) {
            StandardRoot resources = new StandardRoot(ctx);
            resources.addPreResources(
                new DirResourceSet(resources, "/WEB-INF/classes", classesDir.getAbsolutePath(), "/")
            );
            ctx.setResources(resources);
        }

        // 5. Register graceful shutdown hook for Railway container restarts
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try {
                System.out.println("Stopping Tomcat server...");
                tomcat.stop();
                tomcat.destroy();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }));

        tomcat.start();
        System.out.println("=========================================");
        System.out.println(" LifeDrop Server started on port " + port);
        System.out.println(" Webapp Directory: " + webappDir.getAbsolutePath());
        System.out.println("=========================================");
        tomcat.getServer().await();
    }
}
