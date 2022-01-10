package service.test;

import static org.junit.jupiter.api.Assertions.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.HashMap;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.ers.model.User;
import com.ers.service.UserService;
import com.ers.service.UserServiceImp;

public class UserServiceImpTest {
	UserService userServ = null;
	
	/**
	 * @throws Exception
	 */
	@BeforeEach
	void setUpAndIntializeReimDAO() throws Exception {
		/*
		 * We would use before each to reset the initial conditions.
		 */
		System.out.println("--------------------before each--------------------");
		userServ = new UserServiceImp();
	}
	
	@Test
	void whenUsernamePasswordEnteredShouldReturnTrue() throws Exception {
		boolean test = userServ.login("jose", "password");
		assertTrue(test);
	}
	
	@Test
	void whenUsernamePasswordEnteredShouldReturnFalse() throws Exception {
		boolean test = userServ.login("jose", "jose");
		assertFalse(test);
	}
	
	@Test
	void whenUsingGetMyUserFromDatabaseItShouldReturnTrue() throws Exception {
		User test = userServ.getMyUserFromDatabase("jose", "password");
		assertNotNull(test);
	}
	

}
