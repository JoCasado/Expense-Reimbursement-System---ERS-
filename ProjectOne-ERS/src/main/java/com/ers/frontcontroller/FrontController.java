package com.ers.frontcontroller;

import org.apache.log4j.Logger;

import io.javalin.Javalin;
import io.javalin.http.Context;

public class FrontController {
	private static final Logger loggy = Logger.getLogger(FrontController.class);
	Javalin app;
	Dispatcher dispatcher;

	// CONSTRUCTOR
	/**
	 * 
	 * @param app
	 */
	public FrontController(Javalin app) {
		this.app = app; // configuration
		app.before("/api/*", FrontController::checkAllRequests); // checking if
		// requests exist
		
		loggy.info("Checked if the requests exist");
		this.dispatcher = new Dispatcher(app);
	}

	// MIDDLEWARE LOGIC
	/*
	 * THIS is where i checked to see if they (the users) are logged in, via checking their
	 * current session object and I'll see what role they are logged in as.
	 * 
	 * For example, employees shouldn't be able to trigger admin functionality just
	 * because they hard coded the admin url into their browser.
	 */
	/**
	 * @param context
	 */
	public static void checkAllRequests(Context context) {
		
		loggy.info("In front controller!  " + context.path());
		// check to see if the the current user session attribute is null and is the
		// path /index.html
		if (context.sessionAttribute("currentUser") == null && context.path().equals("/index.html")) {
			loggy.info("Current user is null and pat is " + context.path());
			// System.out.println("True");
			return;
		}
		if (context.path().equals("/api/user")) {
			
			loggy.info(context.path());
			return;
		}
	}
}
