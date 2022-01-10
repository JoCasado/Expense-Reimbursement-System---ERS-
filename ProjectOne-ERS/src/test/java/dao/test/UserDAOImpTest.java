package dao.test;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Timeout;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.postgresql.util.PSQLException;

import com.ers.constants.UserType;
import com.ers.dao.UserDAO;
import com.ers.dao.UserDaoImp;
import com.ers.model.User;

/**
 * Junit will be testing units of code in the UserDAOImp class that exists in the DAO
 * getUserByUsernameAndPassword(String username, String password),
 * getUserById(int id),
 * loginByUsernameAndPassword(String myUsername, String myPassword),
 * getUserFromDatabase(String username, String password)
 * 
 *
 */
public class UserDAOImpTest {

	UserDAO userDAO = null;

	/**
	 * @throws Exception
	 */
	@BeforeEach
	void setUpAndIntializeReimDAO() throws Exception {
		/*
		 * We would use before each to reset the initial conditions.
		 */
		System.out.println("-----before-------");
		userDAO = new UserDaoImp();
	}

	//for this given user, should return manager. But we must put a correct expectation 
	/**
	 * @throws Exception
	 */
	@Test
	void whenUsernamePasswordEnteredShouldReturnUserFound() throws Exception {
		User userTest1 = userDAO.getUserFromDatabase("jose", "password"); // Correct login credentials
		assertNotNull(userTest1); //object should not be null
		assertEquals("jose", userTest1.getErsUsername()); //username 
		assertEquals(true, userTest1.getErsUsername().equalsIgnoreCase("jose")); //True since you can't compare string with boolean values
		assertTrue(userTest1.getErsUsername().equalsIgnoreCase("jose")); //this will also be true. expected value is always true
		assertFalse(userTest1.getErsUsername().equalsIgnoreCase(""));// the expression inside of assertfalse is false

		assertEquals(UserType.MANAGER, userTest1.getUserType(),"invalid value returned");
		
	}
	
	@Test
	void whenNoConnectionShouldThrowException() {
		Exception exception = assertThrows(Exception.class, () -> {
			userDAO.getUserFromDatabase(null, null); 
	    });		
	}

	/**
	 * @throws Exception
	 */
	@Test
	void whenUserNamePasswordEmptyShouldReturnNull() throws Exception {
		User userTest2 = userDAO.getUserFromDatabase("", ""); // User DNE
		assertNull(userTest2);
	}

	/**
	 * @throws Exception
	 */
	@Test
	void whenUsernamePasswordEnteredShouldReturnFalse() throws Exception {
		boolean test = userDAO.getUserByUsernameAndPassword("jose", "jose");
		assertFalse(test);
	}
	
	/**
	 * @throws Exception
	 */
	@Test
	void whenUsernamePasswordEnteredShouldReturnTrue() throws Exception {
		boolean test = userDAO.getUserByUsernameAndPassword("jose", "password");
		assertTrue(test);
	}
	
	/**
	 * @throws Exception
	 */
	@Test
	void whenGettingUserByIdShouldReturnFalse() throws Exception {
		boolean test = userDAO.getUserById(0);
		assertFalse(test);
	}
	
	/**
	 * @throws Exception
	 */
	@Test
	void whenGettingUserByIdShouldReturnTrue() throws Exception {
		boolean test = userDAO.getUserById(3);
		assertTrue(test);
	}
	
	/**
	 * @throws Exception
	 */
	@Test
	void whenLoggingInWithUsernamePasswordShouldReturnTrue() throws Exception {
		boolean test = userDAO.loginByUsernameAndPassword("jose", "password");
		assertTrue(test);
	}
	
	@Test
	void getUserByUsernameAndPasswordTest() throws Exception {
		User userTest3 = userDAO.getUserFromDatabase("jose", "password"); // Correct login credentials
		assertNotNull(userTest3);
	}
	
	
	
	
}
