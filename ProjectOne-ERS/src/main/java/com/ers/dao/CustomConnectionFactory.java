package com.ers.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CustomConnectionFactory {
	private static final Logger loggy = Logger.getLogger(CustomConnectionFactory.class);
	
	
	//CONNECT TO THE DATABASE BY USING URL, USERNAME, PASSWORD
	private static final String url = "jdbc:postgresql://javareactdb.cepklf5wvuz3.us-east-2.rds.amazonaws.com:5432/expensedb";
	private static final String username = "systems";
	private static final String password = "projectone";
	
	/**
	 * Driver manager is a service used for managing a set of JDBC drivers.
	 * It will attempt to establish a connect to the database by using the given 
	 * database URL, username, and password.
	 *
	 */
	public static Connection getConnection() throws SQLException{
		loggy.info("Connection established to connect to the Database.");
		return DriverManager.getConnection(url, username, password);
	} 

}
