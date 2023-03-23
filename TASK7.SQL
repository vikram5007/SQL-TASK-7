create table RECORDS(
studentid int primary key, 
studentname varchar(20), 
department varchar(10), 
score int
)

INSERT INTO RECORDS VALUES(1,'VIKRAM','BCA',95),
(2,'VASANTH','BBA',98),
(3,'HARI','BCA',98),
(4,'VIJAY','MBA',85),
(5,'PRANAV','BCA',99),
(6,'DHANUSH','CA',93),
(7,'AJMAL','BCA',94),
(8,'RAJESH','BCA',92),
(9,'SHIBI','MCA',91),
(10,'SHERIFF','BBA',91)

CREATE SYNONYM rec for RECORDS

SELECT * FROM REC

INSERT INTO RECORDS VALUES(11,'RAM','MCA',99),
(12,'VASANTHI','MBA',98),
(13,'HARSHINI','BCA',95),
(14,'VIJAYA','BBA',85),
(15,'PRAGATHI','BCA',99),
(16,'DHANUSHYA','MCA',93),
(17,'AJITHA','BCA',96),
(18,'RAJESHWARI','BCA',98),
(19,'SHOBI','MCA',92),
(20,'SHERIN','MBA',71)

INSERT INTO RECORDS VALUES(21,'RAMAN','CA',92),
(22,'VASANTHAN','BCA',65),
(23,'HARSHAN','BA',85),
(24,'VIJAYAN','MBA',95),
(25,'PRAGAN','MBA',92)

---1. Create a non-clustered index for department.----

CREATE INDEX DEPT ON RECORDS(department)

---2. Create a filtered index for department='BCA'----

create index BCA_DEPT on RECORDS(department) where department='BCA'

---3. Create a view for students in BCA department---

CREATE VIEW STUD_DISPLAY AS 
select studentname,department from RECORDS WHERE department='BCA'
SELECT * FROM STUD_DISPLAY 

---4. Apply Rank() for all the students based on score.---

SELECT studentname,department,score,
rank()over(order by score desc)as RANK
from RECORDS

---5. Apply Dense_Rank() for students in each department based on score.---

select studentname,department,score,
DENSE_RANK()over (partition by department order by score desc)as RANK
from RECORDS


---b. Create 2 tables Manager(id(pk), name) and Employee(eid(pk),ename,mid(fk), department)---

create table manager(
id int primary key,
name varchar(25),
)

create table employee(
eid int primary key,
mid int default 100 foreign key(mid) references manager(id) on delete cascade on update set default,
department varchar(20)
)

ALTER TABLE EMPLOYEE ADD e_name varchar(20)

insert into manager values(100,'RAMAN'),(101,'RAJAN'),(103,'RAJINI'),(104,'GANDHI')

----SIMPLE VIEW ------

CREATE VIEW M AS
SELECT * FROM manager

insert into employee values(1,100,'DEVELOPER','VIKRAM'),(2,101,'DESIGNER','RANI'),(3,103,'TESTER','GOWTHAM'),(4,104,'LEAD','GOWTHAM')

CREATE VIEW E AS
select * from employee

SELECT * FROM M
SELECT * FROM E

-----2. Show the working of 'on delete cascade on update set default' for the above tables----
delete from manager where id=10
insert into manager values(100,'RAMAN')
update manager set id=102 where id=101


------1. Create a complex view by retrieving the records from Manager and Employee table.-------

create view complex1 as
select m.id,m.name,e.eid,e.e_name,e.department
from manager as m
inner join 
employee as e
on m.id=e.mid

select * from complex1

----------------------------------------<END>-------------------------------------------- 
