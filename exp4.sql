-- Consider the following database for a banking enterprise.
-- BRANCH (branch-name: String, branch-city: String, assets: real)
-- ACCOUNTS (accno: int, branch-name: String, balance: real)
-- DEPOSITOR (customer-name: String, accno: int)
-- CUSTOMER(customer-name:string,customer-street:string,customer-city:string)
-- LOAN (loan-number: int, branch-name: String, amount: real)
-- BORROWER (customer-name: String, loan-number: int)

-- a) Create the tables for the schemas provided with primary keys and foreign keys.
--Creating table 'branch'
CREATE TABLE branch (branch_name VARCHAR PRIMARY KEY, branch_city VARCHAR, assets INT);
--Creating table 'accounts'
CREATE TABLE accounts (acc_no INT PRIMARY KEY, branch_name VARCHAR, balance INT,
FOREIGN KEY(branch_name) REFERENCES branch(branch_name));
--Creating table 'customers'
CREATE TABLE customers (customer_name VARCHAR PRIMARY KEY, customer_street VARCHAR, customer_city VARCHAR);
--Creating table 'depositor'
CREATE TABLE depositor (customer_name VARCHAR, acc_no INT,
FOREIGN KEY(customer_name) REFERENCES customers(customer_name) ON DELETE CASCADE,
FOREIGN KEY(acc_no) REFERENCES accounts(acc_no) ON DELETE CASCADE);
--Creating table 'loans'
CREATE TABLE loans (loan_no INT PRIMARY KEY, branch_name VARCHAR, amount INT,
FOREIGN KEY(branch_name) REFERENCES branch(branch_name));
--Creating table 'borrower'
CREATE TABLE borrower(customer_name VARCHAR, loan_no INT, FOREIGN KEY(customer_name) REFERENCES customers(customer_name) ON DELETE CASCADE,
FOREIGN KEY(loan_no) REFERENCES loans(loan_no) ON DELETE CASCADE);

-- b) Insert five tuples of values to each table.
--Inserting values in branch
INSERT INTO branch VALUES ('Main', 'Bangalore', 300000),
 ('b1', 'Bangalore', 200000),
 ('b2', 'Mysore', 200000),
 ('b3', 'Mangalore', 150000),
 ('b4', 'Bangalore', 250000);
 
--Inserting values in accounts
INSERT INTO accounts VALUES (1, 'Main', 10000),
 (2, 'Main', 40000),
 (3, 'Main', 35000),
 (4, 'b1', 50000),
 (5, 'b4', 25000);

--Inserting values in customers
INSERT INTO customers VALUES ('Taylor', 'st1', 'Bangalore'),
 ('Robert', 'st2', 'Bangalore'),
 ('Bob', 'st3', 'Mysore'),
 ('Alex', 'st4', 'Mangalore'),
 ('Steve', 'st5', 'Bangalore');

--Inserting values in depositor
INSERT INTO depositor VALUES ('Taylor', 1),
 ('Taylor', 2),
 ('Steve', 3),
 ('Steve', 4),
 ('Steve', 5);

--Inserting values in loans
INSERT INTO loans VALUES (1, 'Main', 10000),
 (2, 'b1', 20000),
(3, 'b1', 20000),
(4, 'b3', 10000),
(5, 'b4', 30000);

--Inserting values in borrower
INSERT INTO borrower VALUES ('Robert', 3),
 ('Steve', 5),
 ('Taylor', 1),
 ('Bob', 2),
 ('Alex', 4);

-- c) Find all the customers who have at least two accounts at the Main branch.
SELECT depositor.customer_name 
FROM depositor 
INNER JOIN accounts ON depositor.acc_no = accounts.acc_no
WHERE accounts.branch_name = 'Main'
GROUP BY depositor.customer_name 
HAVING COUNT(accounts.branch_name) >= 2;

-- d) Find all the customers who have an account at all the branches located in a specific city.
SELECT depositor.customer_name
FROM depositor
INNER JOIN accounts ON depositor.acc_no = accounts.acc_no
INNER JOIN branch ON accounts.branch_name = branch.branch_name
GROUP BY depositor.customer_name
HAVING COUNT(accounts.branch_name) = (SELECT COUNT(branch.branch_name) 
FROM branch WHERE branch_city = 'Bangalore');

-- e) Demonstrate how you delete all account tuples at every branch located in a specific city
DELETE FROM accounts WHERE branch_name IN 
(SELECT branch_name FROM branch WHERE branch_city = 'Bangalore');
