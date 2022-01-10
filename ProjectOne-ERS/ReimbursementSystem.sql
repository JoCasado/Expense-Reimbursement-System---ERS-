--PROJECT 1: EXPENSE REIMBURSEMENT SYSTEM
--SELECT STATEMENTS
SELECT * FROM ERS_USERS;
SELECT * FROM ERS_REIMBURSEMENT;
SELECT * FROM ERS_REIMBURSEMENT_TYPE;
SELECT * FROM ERS_REIMBURSEMENT_STATUS;
SELECT * FROM ERS_USER_ROLES;

DROP TABLE ERS_REIMBURSEMENT;
DROP TABLE ERS_REIMBURSEMENT_TYPE;
DROP TABLE ERS_REIMBURSEMENT_STATUS;
DROP TABLE ERS_USERS;
DROP TABLE ERS_USER_ROLES;

TRUNCATE ERS_REIMBURSEMENT;
TRUNCATE ERS_REIMBURSEMENT_TYPE;
TRUNCATE ERS_REIMBURSEMENT_STATUS;
TRUNCATE ERS_USERS;
TRUNCATE ERS_USER_ROLES;

UPDATE ERS_REIMBURSEMENT SET reim_author = 2
WHERE reim_id > 0 AND reim_id  < 7;

UPDATE ERS_REIMBURSEMENT SET reim_author = 1
WHERE reim_id = 7;

COMMIT;

SELECT * FROM ERS_REIMBURSEMENT_TYPE;
SELECT * FROM ERS_REIMBURSEMENT_STATUS;
SELECT * FROM ERS_USERS;
SELECT * FROM ERS_USER_ROLES;

DROP TABLE ERS_REIMBURSEMENT;
DROP TABLE ERS_REIMBURSEMENT_TYPE;
DROP TABLE ERS_REIMBURSEMENT_STATUS;
DROP TABLE ERS_USERS;
DROP TABLE ERS_USER_ROLES;
TRUNCATE ERS_REIMBURSEMENT;

---------------------------TABLE 2 for ERS_USERS
DROP TABLE ERS_USERS; 
TRUNCATE ERS_USERS;
--create a table for users: employees and finance managers

CREATE TABLE ERS_USERS(
	ERS_USERS_ID SERIAL PRIMARY KEY
	,ERS_USERNAME VARCHAR(50) NOT NULL UNIQUE
	,ERS_PASSWORD VARCHAR(50) NOT NULL
	,USER_FIRST_NAME VARCHAR(100) NOT NULL
	,USER_LAST_NAME VARCHAR(100) NOT NULL
	,USER_EMAIL VARCHAR(150) NOT NULL UNIQUE
	,USER_ROLE_ID INTEGER NOT NULL
	,CONSTRAINT FK_USER_ROLE FOREIGN KEY (USER_ROLE_ID) REFERENCES ERS_USER_ROLES(ERS_USER_ROLE_ID)
	,UNIQUE(ERS_USERNAME, USER_EMAIL)
);

SELECT * FROM ERS_USERS;

INSERT INTO ERS_USERS (ERS_USERS_ID, ERS_USERNAME, ERS_PASSWORD, USER_FIRST_NAME, USER_LAST_NAME, USER_EMAIL, USER_ROLE_ID) 
VALUES (1, 'nikita','password', 'Nikita','Patel', 'nikita@gmail.com', 1);
INSERT INTO ERS_USERS (ERS_USERS_ID, ERS_USERNAME, ERS_PASSWORD, USER_FIRST_NAME, USER_LAST_NAME, USER_EMAIL, USER_ROLE_ID) 
VALUES (2, 'mila', 'password', 'Mila','Last', 'mila@gmail.com', 2);
INSERT INTO ERS_USERS (ERS_USERS_ID, ERS_USERNAME, ERS_PASSWORD, USER_FIRST_NAME, USER_LAST_NAME, USER_EMAIL, USER_ROLE_ID) 
VALUES (3, 'andre', 'password', 'Andre','Last', 'andre@gmail.com', 2);
INSERT INTO ERS_USERS (ERS_USERS_ID, ERS_USERNAME, ERS_PASSWORD, USER_FIRST_NAME, USER_LAST_NAME, USER_EMAIL, USER_ROLE_ID) 
VALUES (4, 'andy', 'password', 'Andy','Last', 'andy@gmail.com', 2);
-----------------------------------------------------------------------------------------------

UPDATE ers_users SET user_first_name  = 'Manager'
WHERE ers_users_id = 1;

---------------------------TABLE 2 for REIMBURSEMENTS
DROP TABLE ERS_REIMBURSEMENT;

TRUNCATE ERS_REIMBURSEMENT;

CREATE TABLE ERS_REIMBURSEMENT(
	REIM_ID SERIAL PRIMARY KEY
	,REIM_AMOUNT INTEGER NOT NULL
	,REIM_SUBMITTED TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	,REIM_RESOLVED TIMESTAMP
	,REIM_DESCRIPTION VARCHAR(250)
	,REIM_AUTHOR INTEGER NOT NULL
	,REIM_RESOLVER INTEGER
	,REIM_STATUS_ID INTEGER DEFAULT 1
	,REIM_TYPE_ID INTEGER NOT NULL
	,CONSTRAINT ERS_USERS_FK_AUTH FOREIGN KEY (REIM_AUTHOR) REFERENCES ERS_USERS(ERS_USERS_ID)
	,CONSTRAINT ERS_USERS_FK_RESOLVER FOREIGN KEY (REIM_RESOLVER) REFERENCES ERS_USERS(ERS_USERS_ID)
	,CONSTRAINT ERS_REIMBURSEMENT_STATUS_FK FOREIGN KEY (REIM_STATUS_ID) REFERENCES ERS_REIMBURSEMENT_STATUS(REIM_STATUS_ID)
	,CONSTRAINT ERS_USERS_TYPE_F FOREIGN KEY (REIM_TYPE_ID) REFERENCES ERS_REIMBURSEMENT_TYPE(REIM_TYPE_ID)
);

SELECT er.REIM_ID, er.REIM_AMOUNT, er.REIM_SUBMITTED, er.REIM_RESOLVED, er.REIM_DESCRIPTION, 
concat (author.user_first_name , ' ', author.user_last_name) author, 
concat (resolver.user_first_name,' ',resolver.user_last_name) resolver, ers.REIM_STATUS, ert.REIM_TYPE
FROM ERS_REIMBURSEMENT er 
LEFT JOIN ERS_USERS author ON er.REIM_AUTHOR = author.ERS_USERS_ID 
LEFT JOIN ERS_USERS resolver ON er.REIM_RESOLVER = resolver.ERS_USERS_ID 
JOIN ERS_REIMBURSEMENT_STATUS ers ON er.REIM_STATUS_ID = ers.REIM_STATUS_ID
JOIN ERS_REIMBURSEMENT_TYPE ert ON ert.REIM_TYPE_ID = er.REIM_TYPE_ID ORDER BY er.REIM_ID;

SELECT * FROM ers_reimbursement er ;
SELECT * FROM ers_users eu  ;

					
UPDATE ERS_REIMBURSEMENT SET REIM_RESOLVED = now() , REIM_STATUS_ID = 2, REIM_RESOLVER = ?
					WHERE REIM_ID = ?;

									
UPDATE ERS_REIMBURSEMENT SET REIM_RESOLVED = now() , REIM_STATUS_ID = 2, REIM_RESOLVER = 1
					WHERE REIM_ID = 1;

UPDATE ERS_REIMBURSEMENT SET REIM_RESOLVED = now() , REIM_STATUS_ID = 3, REIM_RESOLVER = 1
					WHERE REIM_ID = 2;
					
SELECT * FROM ERS_REIMBURSEMENT;
SELECT * FROM ERS_REIMBURSEMENT
	WHERE REIM_AUTHOR != 2 ;
INSERT INTO ERS_REIMBURSEMENT (
	REIM_AMOUNT, REIM_DESCRIPTION,REIM_AUTHOR, REIM_STATUS_ID, REIM_TYPE_ID)
		VALUES (546, 'lodging', 2, 1, 1);
	INSERT INTO ERS_REIMBURSEMENT (
	REIM_AMOUNT, REIM_DESCRIPTION,REIM_AUTHOR, REIM_STATUS_ID, REIM_TYPE_ID)
		VALUES (123, 'travel', 2, 2, 2);
	INSERT INTO ERS_REIMBURSEMENT (
	REIM_AMOUNT, REIM_DESCRIPTION,REIM_AUTHOR, REIM_STATUS_ID, REIM_TYPE_ID)
		VALUES (234, 'food', 2, 3, 3);

		INSERT INTO ERS_REIMBURSEMENT (
	REIM_AMOUNT, REIM_DESCRIPTION,REIM_AUTHOR, REIM_STATUS_ID, REIM_TYPE_ID)
		VALUES (23, 'other', 2, 3, 4);
-----------------------------------------------------------------------------------------------
---------------------------TABLE 3 for ERS_REIMBURSEMENT_SYSTEM
DROP TABLE ERS_REIMBURSEMENT_STATUS;
DELETE FROM ERS_REIMBURSEMENT_STATUS;
CREATE TABLE ERS_REIMBURSEMENT_STATUS(
	REIM_STATUS_ID INTEGER PRIMARY KEY
	, REIM_STATUS VARCHAR(10) NOT NULL
);

SELECT * FROM ERS_REIMBURSEMENT_STATUS;


INSERT INTO ERS_REIMBURSEMENT_STATUS VALUES (1,'Pending');
INSERT INTO ERS_REIMBURSEMENT_STATUS VALUES (2,'Approved');
INSERT INTO ERS_REIMBURSEMENT_STATUS VALUES (3,'Denied');

-----------------------------------------------------------------------------------------------
---------------------------TABLE 4 for ERS_REIMBURSEMENT_TYPE
DROP TABLE ERS_REIMBURSEMENT_TYPE;
DELETE FROM ERS_REIMBURSEMENT_TYPE;
CREATE TABLE ERS_REIMBURSEMENT_TYPE(
	REIM_TYPE_ID INTEGER PRIMARY KEY
	, REIM_TYPE VARCHAR(10) NOT NULL
);

SELECT * FROM ERS_REIMBURSEMENT_TYPE;

INSERT INTO ERS_REIMBURSEMENT_TYPE VALUES (1,'Lodging');
INSERT INTO ERS_REIMBURSEMENT_TYPE VALUES (2,'Travel');
INSERT INTO ERS_REIMBURSEMENT_TYPE VALUES (3,'Food');
INSERT INTO ERS_REIMBURSEMENT_TYPE VALUES (4,'Other');
-----------------------------------------------------------------------------------------------
---------------------------TABLE 5 for ERS_USER_ROLES
DROP TABLE ERS_USER_ROLES;
DELETE FROM ERS_USER_ROLES;

CREATE TABLE ERS_USER_ROLES(
	ERS_USER_ROLE_ID INTEGER PRIMARY KEY
	, USER_ROLE VARCHAR(10) NOT NULL
);

SELECT * FROM ERS_USER_ROLES;
INSERT INTO ERS_USER_ROLES VALUES (1, 'Manager');
INSERT INTO ERS_USER_ROLES VALUES (2, 'Employee');

-----------------------------------------------------------------------------------------------
---------------------------
-- to select all users
SELECT * FROM ERS_USERS;

--to select first and last name of a given ID
SELECT USER_FIRST_NAME, USER_LAST_NAME 
FROM ERS_USERS
WHERE ERS_USERS_ID = 1;


--to select all reimbursements
SELECT * FROM ERS_REIMBURSEMENT;

--to select all types
SELECT REIM_TYPE FROM ERS_REIMBURSEMENT_TYPE;
--to select all statuses
SELECT REIM_STATUS FROM ERS_REIMBURSEMENT_STATUS;
--to select columns from reimbursements
SELECT REIM_ID ,REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION, 
	REIM_AUTHOR, REIM_RESOLVER, REIM_STATUS_ID, REIM_TYPE_ID
	FROM ERS_REIMBURSEMENT
--to select COLUMNS from reimbursements joined with type and reim_status
SELECT REIM_ID ,REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION,
	REIM_AUTHOR, REIM_RESOLVER
	FROM ERS_REIMBURSEMENT r
		INNER JOIN ERS_REIMBURSEMENT_STATUS s 
		ON s.REIM_STATUS_ID =r.REIM_STATUS_ID 
			INNER JOIN ERS_REIMBURSEMENT_TYPE t
			ON t.REIM_TYPE_ID = r.REIM_TYPE_ID
	WHERE reim_status = 'Approved';
	
-- inner join between users and reimbursement to retrieve the reimbursement id
SELECT REIM_ID 
	FROM ERS_REIMBURSEMENT r
		INNER JOIN ERS_USERS u 
		ON u.ERS_USERS_ID = r.REIM_AUTHOR 
	WHERE reim_status = 'Approved';

--to retrieve reimbursement by id
SELECT REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION,
	REIM_AUTHOR, REIM_RESOLVER, REIM_STATUS_ID, REIM_TYPE_ID
	FROM ERS_REIMBURSEMENT
	WHERE REIM_ID = 2;

-----------------------------------------------------------------------------------------------
---------------------------get user Login Information
SELECT u.ERS_USERS_ID, u.ERS_USERNAME, u.ERS_PASSWORD, u.USER_FIRST_NAME, u.USER_LAST_NAME, u.USER_EMAIL, u.USER_ROLE_ID, ur.USER_ROLE 
					FROM ERS_USERS u 
					JOIN ERS_USERS_ROLES ur 
					ON u.USER_ROLE_ID = ur.ERS_USER_ROLE_ID
					WHERE u.ERS_USERNAME = 'username1' AND u.ERS_PASSWORD = 'pass1';

-----------------------------------------------------------------------------------------------
---------------------------get reimbursement
SELECT REIM_ID ,REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION,
	REIM_AUTHOR, REIM_RESOLVER, REIM_STATUS_ID, REIM_TYPE_ID
	FROM ERS_REIMBURSEMENT er 
					JOIN ERS_REIMBURSEMENT_STATUS ers 
					ON er.REIM_STATUS_ID = ers.REIM_STATUS_ID
						JOIN ers_reimbursement_type ert  
						ON ert.REIM_TYPE_ID = er.REIM_TYPE_ID

SELECT er.REIM_ID, er.REIM_AMOUNT, er.REIM_SUBMITTED, er.REIM_RESOLVED, er.REIM_DESCRIPTION, 
						er.REIM_AUTHOR, er.REIM_RESOLVER, er.REIM_STATUS_ID, ers.REIM_STATUS, er.REIM_TYPE_ID, ert.REIM_TYPE 
					FROM ERS_REIMBURSEMENT er JOIN ERS_REIMBURSEMENT_STATUS ers 
						ON er.REIM_STATUS_ID = ers.REIM_STATUS_ID JOIN ERS_REIMBURSEMENT_TYPE ert 
								ON ert.REIM_TYPE_ID = er.REIM_TYPE_ID ORDER BY er.REIM_ID;

"UPDATE ERS_REIMBURSEMENT SET REIM_RESOLVED = now() , REIM_STATUS_ID = ?, REIM_RESOLVER = ?
					WHERE REIM_ID = ?"


UPDATE ERS_REIMBURSEMENT SET REIM_RESOLVED = now() , REIM_STATUS_ID = ?, REIM_RESOLVER = ?
					WHERE REIM_ID = ?

SELECT u.ERS_USERS_ID 
FROM ers_users u
WHERE u.ERS_USERNAME= 'username1' AND u.ERS_PASSWORD= 'pass1';

SELECT u.ERS_USERS_ID, u.ERS_USERNAME, u.ERS_PASSWORD, u.USER_FIRST_NAME, u.USER_LAST_NAME, u.USER_EMAIL, u.USER_ROLE_ID
	FROM ERS_USERS u JOIN ERS_USERS_ROLES ur ON u.USER_ROLE_ID = ur.ERS_USER_ROLE_ID
	WHERE u.ERS_USERNAME= 'username1' AND u.ERS_PASSWORD= 'pass1';

SELECT u.ERS_USERS_ID FROM ERS_USERS u WHERE u.ERS_USERNAME= 'username1' AND u.ERS_PASSWORD= 'pass1';


SELECT u.USER_FIRST_NAME, u.USER_LAST_NAME FROM ERS_USERS u
	WHERE u.ERS_USERS_ID = 2;


SELECT REIM_ID ,REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION, 
	REIM_AUTHOR, REIM_RESOLVER, REIM_STATUS_ID, REIM_TYPE_ID 
	FROM ERS_REIMBURSEMENT er where er.REIM_AUTHOR = 2;
	
DELETE REIM_ID ,REIM_AMOUNT, REIM_SUBMITTED, REIM_RESOLVED, REIM_DESCRIPTION, 
	REIM_AUTHOR, REIM_RESOLVER, REIM_STATUS_ID, REIM_TYPE_ID 
	FROM ERS_REIMBURSEMENT er where er.REIM_ID = 25;