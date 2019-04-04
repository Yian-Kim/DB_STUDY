-- hr > ex06_where.sql

/*

SELECT 문
- SELECT 컬럼리스트 FROM 테이블
- SELECT 컬럼리스트 FROM 테이블 WHERE 조건

1. SELECT 컬럼리스트
    - 가져올 컬럼을 지정한다.
    - 가져올 값을 연산하기도 한다.
2. FROM 테이블
    - 테이블 선택한다.
3. WHERE 조건
    - 가져올 레코드를 지정한다.
   
    
절 실행순서
- FROM(1) > SELECT(2)
- FROM(1) > WHERE(2) > SELECT(3)


WHERE 절
- 조건을 제시한다.
- 조건을 제시한 후 그 조건을 만족하는 행만 결과 테이블로 가져온다.
- 주로 조건으로 컬럼값을 대상으로 비교 연산 or 논리 연산을 적용한다.

SELECT 컬럼리스트 : 수직 필터링
WHERE 조건 : 수평 필터링

*/

select name, population from tblcountry where population >= 5147;

select 
    last || first as fullname 
from tblcomedian;

-- 절의 순서 + 가져올 컬럼이 아니라도 조건을 걸 수 있다.
select 
    last || first as fullname 
from tblcomedian
where weight >= 70; 

-- 조건식에 추가 연산 가능 > WHERE절에는 자바의 조건식과 동등한 작업이 가능한다.
select 
    last || first as fullname 
from tblcomedian
where weight * 2 >= 100; 


select 
    last || first as fullname 
from tblcomedian
where weight > 70 and height > 180; 

select 
    last || first as fullname 
from tblcomedian
where gender = 'f';

desc employees;
select * from employees;

select * from employees where job_id = 'IT_PROG';
select * from employees where job_id <> 'IT_PROG';
select * from employees where salary > 8000;
select * from employees where salary > 8000 and salary < 10000;

-- 날짜 조건
select * from employees where hire_date = '03/06/17'; --비권장(SQL Developer가 보여주는 방식)
select * from employees where hire_date = '2003-06-17'; --권장(표준 표기법)

-- 추가
-- : 조건은 주로 컬럼값을 대상으로 한다.
select * from tblcomedian where height = 178;
select * from tblcomedian where 1 = 1;


-- 로그인 > SQL Injection
-- 아이디 : hong
-- 암호 : 1111
-- 암호 : 1111' or 1=1
select 결과 from 회원테이블 where id='hong' and pw='1111';
select 결과 from 회원테이블 where id='hong' and pw='1111' or 1=1';













