-- Retrieve the result for following queries

-- a) Find all information of sailors who have reserved boat number 101.
SELECT S.* FROM Sailors S, Reserves R WHERE S.sid = R.sid AND R.bid = 103;

-- b) Find the ids and names of sailors who have reserved two different boats on the same day.
SELECT DISTINCT S.sid, S.sname FROM Sailors S, Reserves R1, Reserves R2
WHERE S.sid = R1.sid AND S.sid = R2.sid AND R1.day = R2.day AND R1.bid <>
R2.bid;

-- c) Find the name and the age of the youngest sailor
SELECT S.sname, S.age FROM Sailors S WHERE S.age <= ALL ( SELECT age FROM Sailors );
--or
SELECT sname, age FROM Sailors WHERE age = (SELECT min(age) FROM Sailors);
