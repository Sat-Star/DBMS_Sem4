-- Apply the following queries on given relation schema and display the results

-- a) List the emps who joined in January
Select * from emp where hiredate like "%JAN%" ;

-- b) List the emps who are working under ‘Mgr’
Select * from emp where mgr in (select empno from emp where job = "MANAGER");

-- c) List the Empno, Ename, Sal, Daily Sal of all Employees in the ASC order of AnnSal
SELECT Empno, Ename, sal, Sal/30 DailySal FROM Emp ORDER BY Sal*12 ;

