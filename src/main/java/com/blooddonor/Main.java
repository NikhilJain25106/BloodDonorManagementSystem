package com.blooddonor;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.descriptor.web.FilterDef;
import org.apache.tomcat.util.descriptor.web.FilterMap;

import java.io.File;

public class Main {

    public static void main(String[] args) throws Exception {

        // Railway sets PORT environment variable - default to 8080 locally
        String port = System.getenv("PORT");
        if (port == null) port = "8080";

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));
        tomcat.getConnector();

        // Point to webapp directory
        String webappDir = new File("src/main/webapp").getAbsolutePath();
        Context ctx = tomcat.addWebapp("", webappDir);

        // Add WEB-INF/classes so servlets are found
        File additionWebInfClasses = new File("target/classes");
        org.apache.catalina.WebResourceRoot resources = new org.apache.catalina.webresources.StandardRoot(ctx);
        resources.addPreResources(
            new org.apache.catalina.webresources.DirResourceSet(
                resources,
                "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(),
                "/"
            )
        );
        ctx.setResources(resources);

        tomcat.start();
        System.out.println("Server started on port " + port);
        tomcat.getServer().await();
    }
}
