package com.ers.controller;

import org.apache.log4j.Logger;

import com.ers.constants.UserType;
import com.ers.model.User;
import com.ers.service.UserServiceImp;

import io.javalin.http.Context;

public class UserController {
	
	private static UserServiceImp myUserServices = new UserServiceImp();
	private static final Logger loggy = Logger.getLogger(UserController.class);

	// HANDLER LOGIC: 
	/**
	 * @param context
	 * @throws Exception 
	 */
	public static void login(Context context) throws Exception {

		String username = context.formParam("myUsername");
		String password = context.formParam("myPassword");
		loggy.info("User controller " + username + " logged in");
		
		User validUser = myUserServices.getMyUserFromDatabase(username, password);
		if(null != validUser) {
			context.sessionAttribute("currentUser",validUser); 
			if (((User) context.sessionAttribute("currentUser")).getUserType() == UserType.EMPLOYEE) {																		
				loggy.info("Current user is a employee");
				
				context.redirect("/html/employee.html");
			}else{		
				loggy.info("Current user is a manager");
			
				context.redirect("/html/manager.html");
			}
		}else {
			loggy.info("Redirected the invalid user.");
			context.redirect("/index.html");
		}
	}
	
	/**
	 * @param context
	 */
	public static void whoAmI(Context context) {
		if(null == context.sessionAttribute("currentUser")) {
			loggy.error("Current user session is invalid");
			context.json("INVAID_SESSION");
		}else {
			loggy.info("I am: " + ((User) context.sessionAttribute("currentUser")).getUserType());
			
			context.json(((User) context.sessionAttribute("currentUser")).getUserType());
		}
	}

	/**
	 * @param context
	 * @throws Exception 
	 */
	public static void getAllUsers(Context context) throws Exception {
		loggy.info("calling the service layer from controller to get user from database");
		context.json(myUserServices.getMyUserFromDatabase("username1", "pass1"));
	}
	
	/**
	 * @param context
	 */
	public static void logout(Context context) {
		loggy.info("The current user is null and the user is being redirected to the login page.");
		context.sessionAttribute("currentUser",null); 
		//set the value to null to delete the obj that was stored in the session. The current user is not pointing to any object 
		context.redirect("/index.html"); 
		// when your session is terminated you must login again
	}
}
