package com.ers;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import com.ers.frontcontroller.FrontController;

import io.javalin.Javalin;
import io.javalin.http.staticfiles.Location;

public class MainDriver {
	final static Logger loggy = Logger.getLogger(MainDriver.class);

	/**
	 * My Main class
	 */
	public static void main(String[] args) {
		loggy.setLevel(Level.ALL);//all the levels
		/*
		 * THIS line of code is what starts our server on port 9003
		 * passed a config. object when creating a new instance of Javalin
		 */
		Javalin app = Javalin.create(config -> {
			config.addStaticFiles(staticFiles -> { 
				//static- something that can not be changed and does not need an instance
				//content in the static files/directories are unaffected. 
				//the directory where your files are located
				staticFiles.directory = "/"; 
				//change to host files on a subpath
				staticFiles.hostedPath = "/"; 
				//Location.CLASSPATH (jar) or Location.EXTERNAL (file system)
				staticFiles.location = Location.CLASSPATH;
			});
		}).start(9003); //command chaining, start server 
		
		
		FrontController frontCont = new FrontController(app); //Creates a new instance with the user provided configuration.

	}

} 
