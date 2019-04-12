-- ex04_select.sql

/*

SELECT 문
- DML, DQL
- SQL(Q - SELECT)
- 가장 빈도수가 높다.(연습을 가장 많이 할것)
- 사용 목적 : 데이터베이스로부터 원하는 데이터를 가져오는 명령어(읽기)
- 기본 구문
    - SELECT 컬럼리스트 FROM 테이블명; //SELECT 문
        - SELECT 컬럼리스트 //SELECT 절(구) : 가져올 컬럼을 지정한다.
        - FROM 테이블명 //FROM 절(구) : 가져올 테이블을 지정한다.
    - 절마다 실행순서가 있다.
        - FROM(1) > SELECT(2)   

*/

select name --2.
from tblCountry; --1.

-- 1. 컬럼명
-- 2. 테이블명.컬럼명
-- 3. 계정명(스키마).테이블명.컬럼명
select hr.tblCountry.name
from hr.tblCountry;


-- 데이터 보기
select * from tblCountry;

-- 클라이언트 툴 사용


-- 현재 소유주가 소유하고 있는 테이블 명단
select * from tabs; --tables(시스템 테이블)

-- tblCountry > 컬럼 구성?? > 1. DDL 2. desc
desc tblCountry; --컬럼명. 자료형. 널(필수입력) -- SQL*Plus 명령어. 다른 툴 실행 불가


-- 단일 컬럼
select name from tblCountry;

-- 다중 컬럼
select name, capital from tblCountry;
select name, capital, population, continent, area from tblCountry; --선택
select * from tblCountry; -- *, wild card //모든 컬럼

--원본의 컬럼순서와 다르게 명시
select capital, population, continent, area, name from tblCountry; 

select name, name from tblCountry;
select name, length(name) from tblCountry;

-- error
-- ORA-00904: "AGE": invalid identifier
select age from tblCountry;

-- ORA-00942: table or view does not exist
select name from tblCoutry;
