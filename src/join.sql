-- Бөлүмдөр таблицасы
CREATE TABLE departments
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Кызматкерлер таблицасы
CREATE TABLE employees
(
    id            SERIAL PRIMARY KEY,
    first_name    VARCHAR(255) NOT NULL,
    last_name     VARCHAR(255) NOT NULL,
    department_id INT REFERENCES departments (id)
);

-- Айлык таблицасы
CREATE TABLE salaries
(
    id             SERIAL PRIMARY KEY,
    employee_id    INT REFERENCES employees (id),
    salary_amount  DECIMAL NOT NULL,
    effective_date DATE    NOT NULL
);


INSERT INTO departments (name)
VALUES ('Marketing'),
       ('IT'),
       ('HR'),
       ('Training'),
       ('Finance'),
       ('Operations'),
       ('Product Management'),
       ('Business Development');


INSERT INTO employees (first_name, last_name, department_id)
VALUES ('Aibek', 'Dusho uulu', 1),
       ('Ainura', 'Nusubalieva', 2),
       ('Baiel', 'Karybaev', 3),
       ('Guljamal', 'Zhanybekova', 4),
       ('Kanchoro', 'Maraimov', 5),
       ('Mukhammedaly', 'Mambetkulov', 1),
       ('Nursultan', 'Juraev', 2),
       ('Almaz', 'Saliev', 3),
       ('Kanbolot', 'Kalbaev', 4),
       ('Nurbol', 'Turatbekov', 5),
       ('Urmat', 'Taichikov', 5),
       ('Mukhammed', 'Taichikov', 5);

INSERT INTO employees (first_name, last_name)
VALUES ('Amir', 'Altymyshov'),
       ('Aruuke', 'Emirsinova'),
       ('Ernis', 'Jaichikov');

INSERT INTO salaries (employee_id, salary_amount, effective_date)
VALUES (1, 35000, '2025-01-01'),
       (2, 45000, '2025-01-01'),
       (3, 55000, '2025-01-01'),
       (4, 60000, '2025-01-01'),
       (6, 37000, '2025-01-01'),
       (7, 46000, '2025-01-01'),
       (8, 56000, '2025-01-01'),
       (9, 41000, '2025-01-01'),
       (10, 61000, '2025-01-01');

INSERT INTO salaries (salary_amount, effective_date)
VALUES (10000, '2025-01-01'),
       ( 70000, '2025-01-01'),
       ( 120000, '2025-01-01');
select s.salary_amount  from salaries s order by s.salary_amount desc limit 6;
--####
select e.first_name,max(length(e.first_name))
from employees e where length(e.first_name) =
 ( select max(length(e.first_name)) from employees e) group by e.first_name ;


select
case
    when count(d.id)>0
then true
else false
end as exists
    from departments d;
select
    case
        when count(d.id)>0
            then 'bar'
        else 'jok'
        end as exists
from departments d;
--#1
select e.first_name,d.name
from employees e  join  departments d on e.department_id = d.id;
--#2
select  e.first_name ,s.salary_amount
from employees e left join salaries s on e.id = s.employee_id;
--#3
select  e.first_name ,s.salary_amount
from employees e right join  salaries s on e.id = s.employee_id;

-- TODO: 4
--  колдонуп, кызматкерлерди, айлык жазууларын жана бөлүмдөрүн көрсөтүңүз.
--покажите сотрудников, их зарплаты и отделы, включая тех, у кого нет данных в одной из таблиц.
select  e.first_name ,s.salary_amount,d.name
from employees e full join salaries s on e.id = s.employee_id
                 full join departments d on e.department_id = d.id;
-- TODO: 5
--  Бөлүмдөрдү жана аларга тиешелүү кызматкерлерди көрсөтүү үчүн суроо жазып чык.
-- Напишите запрос, который покажет все департаменты и их сотрудников (если есть).
    select d.name, e.first_name from departments d join employees e on d.id = e.department_id;

-- TODO: 6
--  колдонуп, «IT» бөлүмүндө иштеген кызматкерлерди көрсөтүңүз.
--покажите только тех сотрудников, которые работают в отделе «IT».
select d.name, e.first_name from departments d join employees e on d.id = e.department_id
where d.name = 'IT';
-- TODO: 7
--  колдонуп, бардык кызматкерлерди жана алардын айлыктарын, айлык жазуу жок болсо да көрсөтүңүз.
-- покажите всех сотрудников и их зарплаты, даже если некоторые сотрудники не имеют зарплаты.
select e.first_name,s.salary_amount from employees e left join salaries s on e.id = s.employee_id;
-- TODO: 8
--  колдонуп, «Marketing» бөлүмүндөгү кызматкерлердин айлыктарын көрсөтүңүз.
-- Напишите запрос , который покажет зарплаты сотрудников из отдела «Marketing».
select  e.first_name ,s.salary_amount,d.name
from employees e full join salaries s on e.id = s.employee_id
                 full join departments d on e.department_id = d.id
where d.name='Marketing';
-- TODO: 9
--   колдонуп, эч кандай бөлүмгө кирбеген кызматкерлерди көрсөтүңүз.
-- покажите сотрудников, которые не принадлежат ни к одному из департаментов.
select e.first_name  from employees e where department_id=null;

-- TODO: 10
--  колдонуп, кызматкерлердин аттарын, айлыктарын жана бөлүмдөрүн көрсөтүңүз.
-- покажите все возможные комбинации сотрудников, их зарплат и департаментов.
select  e.first_name ,s.salary_amount,d.name
from employees e  join salaries s on e.id = s.employee_id
                  join departments d on e.department_id = d.id;

--todo Вывести все департаменты из таблицы departments. Show all departments from the departments table.
-- Кыргыча: departments таблицасынан бардык бөлүмдөрдү көрсөтүңүз.
    select  departments.name from departments;
select distinct departments.name from departments;
-- todo Вывести имена и фамилии всех сотрудников. Show the first name and last name of all employees.
--  Кыргыча: Бардык кызматкерлердин ысымдары жана фамилияларын көрсөтүңүз.
select employees.first_name,employees.last_name from employees;
-- todo Найти всех сотрудников, которые работают в департаменте "HR". Find all employees who work in the "HR" department.
--   Кыргыча: "HR" бөлүмүндө иштеген бардык кызматкерлерди табыңыз.
select e.first_name, d.name
    from employees e join departments d on d.id = e.department_id
where d.name = 'HR';
--todo Найти сотрудников, чьи зарплаты больше 50,000. Find employees whose salary is greater than 50,000.
-- Кыргыча: Айлык акысы 50,000ден жогору болгон кызматкерлерди табыңыз.
select e.first_name, s.salary_amount
from employees e join salaries s on e.id = s.employee_id
where salary_amount>50000;
-- todo Вывести имя и фамилию сотрудника с самой высокой зарплатой. Show the first name and last name of the employee with the highest salary.
--  Кыргыча: Эң жогорку айлык алган кызматкердин ысымын жана фамилиясын көрсөтүңүз.
select e.first_name, s.salary_amount
from employees e join salaries s on e.id = s.employee_id
order by salary_amount desc limit 1;

-- todo Вывести все зарплаты для сотрудника с id = 1. Show all salaries for the employee with id = 1.
--   Кыргыча: ID = 1 болгон кызматкердин бардык айлыктарын көрсөтүңүз.
select s.salary_amount,e.first_name from salaries s join employees e on e.id = s.employee_id
where e.id = 1;
select s.salary_amount from salaries s
where s.employee_id =1;
-- todo Вывести все департаменты, в которых работают сотрудники. Show all departments where employees work.
--   Кыргыча: Кызматкерлер иштеген бардык бөлүмдөрдү көрсөтүңүз.
    select * from departments d  join employees e on d.id = e.department_id;
select distinct d.name from departments d join employees e on d.id = e.department_id;
-- todo Найти всех сотрудников, у которых зарплата меньше 40,000. Find all employees whose salary is less than 40,000.
--  Кыргыча: Айлыгы 40,000ден төмөн болгон кызматкерлерди табыңыз.
select e.first_name, s.salary_amount
from employees e join salaries s on e.id = s.employee_id
where salary_amount<40000;
-- todo Вывести всех сотрудников, работающих в департаменте "Marketing". Show all employees working in the "Marketing" department.
--  Кыргыча: "Marketing" бөлүмүндө иштеген бардык кызматкерлерди көрсөтүңүз.
    select e.first_name,e.last_name ,d.name from employees e  join departments d on d.id = e.department_id
    where d.name ='Marketing';
-- todo Посчитать количество сотрудников в таблице employees. Count the number of employees in the employees table.
--  Кыргыча: employees таблицасындагы кызматкерлердин санын эсептеңиз.
    select count(*) from employees;
-- todo Medium Tasks (Средние задачи / Орто деңгээл тапшырмалар):

-- todo  Посчитать количество сотрудников в каждом департаменте. Count the number of employees in each department.
--  Кыргыча: Ар бир бөлүмдө канча кызматкер бар экенин эсептеңиз.
    select d.name,count(e.id) from departments d join employees e on d.id = e.department_id
    group by d.name ;
-- todo Найти департамент с наибольшим количеством сотрудников. Find the department with the most employees.
--  Кыргыча: Көп кызматкери бар бөлүмдү табыңыз.
select d.name,count(e.id) from departments d join employees e on d.id = e.department_id
group by d.name order by count(e.id) desc limit 1;
--todo  Посчитать среднюю зарплату по всем сотрудникам. Count the average salary of all employees.
-- Кыргыча: Бардык кызматкерлердин орточо айлыгын эсептеңиз.
    select avg(s.salary_amount) from employees e join salaries s on e.id = s.employee_id;
-- todo Найти всех сотрудников, чья зарплата была обновлена с 2025-01-01. Find all employees whose salary was updated from 2025-01-01.
--  Кыргыча: 2025-01-01ден тартып айлыгы жаңыртылган бардык кызматкерлерди табыңыз.
update salaries  set salary_amount= 70000 where id = 2;
-- todo Найти всех сотрудников, у которых нет зарплаты в таблице salaries. Find all employees who do not have a salary in the salaries table.
--  Кыргыча: salaries таблицасында айлыгы жок болгон кызматкерлерди табыңыз.
    select * from employees e left join salaries s on e.id = s.employee_id
    where s.employee_id is null;
select * from employees e where e.id in (
                          select s.employee_id from salaries s where s.employee_id is null);
-- todo Вывести список всех сотрудников и их зарплат с сортировкой по зарплате. Show all employees and their salaries, sorted by salary.
--  Кыргыча: Бардык кызматкерлерди жана алардын айлыктарын айлыктар боюнча сорттолгон тизмеде көрсөтүңүз.
select s.salary_amount,e.first_name from employees e  join salaries s on e.id = s.employee_id
order by salary_amount ;
-- todo Вывести сотрудников, работающих в департаменте "Finance" и с зарплатой выше 45,000. Show employees working in the "Finance" department with a salary above 45,000.
--  Кыргыча: "Finance" бөлүмүндө иштеп, айлыгы 45,000ден жогору болгон кызматкерлерди көрсөтүңүз.
select s.salary_amount,e.first_name, d.name from employees e  join salaries s on e.id = s.employee_id
join departments d on d.id = e.department_id where d.name= 'Finance' and s.salary_amount> 44500;
--todo  Найти всех сотрудников, у которых нет департамента. Find all employees who do not belong to any department.
--  Кыргыча: Департаментке таандык эмес бардык кызматкерлерди табыңыз.
    select e.first_name,d.name from employees e left join departments d on d.id = e.department_id
    where e.department_id is null;
-- todo Найти департамент с наименьшей средней зарплатой среди сотрудников. Find the department with the lowest average salary among its employees.
--  Кыргыча: Кызматкерлеринин орточо айлыгы эң төмөн болгон бөлүмдү табыңыз.
    select
    *

    from employees e ;
-- todo Посчитать общее количество сотрудников по каждой зарплатной категории (менее 40,000, 40,000-60,000, более 60,000). Count the total number of employees in each salary category (less than 40,000, 40,000-60,000, more than 60,000).
--  Кыргыча: Ар бир айлык категориясы боюнча (40,000ден аз, 40,000-60,000, 60,000ден жогору) кызматкерлердин жалпы санын эсептеңиз.
    select
        case
            when s.salary_amount <40000 then '40,000ден аз'
            when s.salary_amount between 40000 and 60000 then '40,000-60,000'
            else ' 60,000ден жогору'
    end salary_cat, count(*)
    from employees e
  join salaries s on e.id = s.employee_id group by salary_cat;


-- todo Hard Tasks (Трудные задачи / Кыйын тапшырмалар):
--  Найти сотрудников с самой высокой и самой низкой зарплатой в каждом департаменте. Find the highest and lowest salaried employees in each department.
--  Кыргыча: Ар бир бөлүмдө эң жогорку жана эң төмөнкү айлык алган кызматкерлерди табыңыз.

-- todo Вывести список сотрудников с их департаментами и зарплатами, упорядоченными по департаменту и зарплате. Show a list of employees with their departments and salaries, ordered by department and salary.
--   Кыргыча: Кызматкерлерди, алардын департаменттерин жана айлыктарын бөлүм жана айлык боюнча упорядочуланган тизмеде көрсөтүңүз.

-- Найти сотрудников с зарплатой выше средней по всем сотрудникам. Find employees whose salary is higher than the average salary of all employees.
-- Кыргыча: Бардык кызматкерлердин орточо айлыгын ашык кызматкерлерди табыңыз.
-- Для каждого департамента вывести сотрудников с зарплатой больше средней по департаменту. For each department, show employees with salaries higher than the department’s average salary.
-- Кыргыча: Ар бир бөлүм үчүн, бөлүмдүн орточо айлыгынан жогору айлык алган кызматкерлерди көрсөтүңүз.
-- Вывести департамент с наибольшей средней зарплатой среди сотрудников. Show the department with the highest average salary among its employees.
-- Кыргыча: Кызматкерлеринин орточо айлыгы эң жогорку бөлүмдү көрсөтүңүз.
-- Посчитать количество сотрудников в каждом департаменте с учетом только тех, у которых зарплата больше 40,000. Count the number of employees in each department who have a salary greater than 40,000.
-- Кыргыча: Айлыгы 40,000ден жогору болгон кызматкерлерди гана эсепке алуу менен ар бир бөлүмдөгү кызматкерлердин санын эсептеңиз.
-- Вывести всех сотрудников, у которых зарплата изменялась более одного раза. Show all employees whose salary has changed more than once.
-- Кыргыча: Айлыгы бир нече жолу өзгөртүлгөн бардык кызматкерлерди көрсөтүңүз.
-- Найти всех сотрудников, которые работают в департаменте "IT", и у которых зарплата была обновлена с 2025-01-01. Find all employees working in the "IT" department whose salary was updated from 2025-01-01.
-- Кыргыча: "IT" бөлүмүндө иштеп, 2025-01-01ден тартып айлыгы жаңыртылган кызматкерлерди табыңыз.
-- Вывести всех сотрудников с их зарплатами, упорядоченными по департаменту, а затем по зарплате. Show all employees with their salaries, ordered by department, and then by salary.
-- Кыргыча: Бардык кызматкерлерди, алардын айлыктарын бөлүм боюнча, андан кийин айлык боюнча упорядочуланган тизмеде көрсөтүңүз.
-- Найти максимальную зарплату среди сотрудников каждого департамента. Find the maximum salary among employees in each department.
-- Кыргыча: Ар бир бөлүмдөгү кызматкерлердин эң жогорку айлыгын табыңыз.
