-- Database : A database is an organized collection of data that is stored electronically so it can be easily accessed, managed, updated, and retrieved
-- DBMS : DBMS (Database Management System) is software that allows users to create, store, organize, retrieve, and manage data in databases efficiently and securely.
-- SQL : SQL (Structured Query Language) is the standard language used to communicate with a database. It allows you to create, retrieve, update, and delete data stored in a database.
-- Schema : A schema is a logical container that holds database objects such as tables, views, indexes, stored procedures, and functions.
-- SQL commands : DDL - Defines the structure.( CREATE, ALTER, DROP, TRUNCATE, RENAME )
--                DML - Manipulates the data.( INSERT, UPDATE, DELETE )
--                DQL - Queries (retrieves) the data.( SELECT )
--                DCL - Controls user permissions.( GRANT, REVOKE )
--                TCL - Controls transactions.( COMMIT, ROLLBACK, SAVEPOINT ) 
#1) DDL Commands:

CREATE DATABASE students_db;

CREATE TABLE students_db.details( id int, name varchar(50) );

SELECT * FROM students_db.details;

INSERT INTO students_db.details (id, name) VALUES (1,'JOHN'), (2,'RAJ'), (3,'ALI');

SELECT ID FROM STUDENTS_DB.DETAILS;
SELECT * FROM STUDENTS_DB.DETAILS;

INSERT INTO students_db.details (ID, NAME) VALUES (2, 'HULK');

# ALTER COMMAND
ALTER TABLE students_db.details ADD MARKS INT;
SELECT * FROM students_db.details;

ALTER TABLE students_db.details RENAME COLUMN MARKS TO percentage;
SELECT * FROM students_db.details;

DELETE FROM students_db.details WHERE ID = 3;
SELECT *FROM students_db.details;
INSERT INTO students_db.details (id, name,percentage) VALUES (1,'JOHN',80), (2,'RAJ',76), (3,'ALI',89);
SELECT *FROM students_db.details;

CREATE TABLE students_db.grades(
	id int not null unique,
    name varchar(50) not null,
    marks int,
    grade char(1));
    
Insert into students_db.grades (id, name, marks, grade) Values (1, 'David', 79, 'C'), (2, 'Elgen', 97, 'A'), (3, 'Frank', 87, 'B');
SELECT *FROM students_db.grades;

#Primary Key: A unique identifier for each record in a table; it cannot contain duplicate or NULL values.
#Foreign Key: A column that links two tables by referencing the primary key of another table.

ALTER TABLE students_db.grades ADD PRIMARY KEY (id);

create table students_db.books (
	bookid int primary key,
    present_days int,
    stuid int,
    foreign key (stuid) references grades(id)
		on delete restrict
        on update cascade
    );
    
Insert into students_db.books (bookid, present_days, stuid) Values (101, 87, 1), (102, 67, 2), (103, 84, 2);
SELECT *FROM students_db.books;
SELECT *FROM students_db.grades;  
update students_db.books set stuid=3 where bookid=103;    

delete from students_db.books where id=1;

update students_db.grades set id=4 where id=1;
SELECT *FROM students_db.books;
SELECT *FROM students_db.grades;

create table students_db.audults(
	id int not null,
    name varchar(50),
    age int check(age>=18),
    city varchar(255) default 'hyd'
);

insert into students_db.audults(id, name, age,city) values (1,'krish', 19),(2, 'dinesh',15,'delhi');
insert into students_db.audults(id, name, age,city) values (1,'krish', 19, ''),(2, 'dinesh',23,'delhi');
select * from students_db.audults;

delete from students_db.audults where id=1;
select * from students_db.audults;

truncate students_db.audults;
select * from students_db.audults;

drop table students_db.audults;

 show tables;   
 
 drop database students_db;
 
 show databases;










