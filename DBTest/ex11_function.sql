-- hr > ex11_function.sql

/*

숫자 함수(수학 함수)
- 자바의 Math 클래스


1. round()
- 반올림 함수
- number round(컬럼명) : 정수 반환
- number round(컬럼명, 자릿수) : 정수 or 실수 반환

*/

select 987.654 from tblcountry;
select 987.654 from tblinsa;
select round(987.654) from dual;
select round(987.654, 1) from dual;
select round(987.654, 2) from dual;
select round(987.654, 3) from dual;
select round(987.654, 4) from dual;
select round(987.654, 0) from dual;

select round(avg(basicpay), 2) from tblinsa;

select * from dual; --시스템 테이블


/*

2. floor, trunc
- 절삭 함수
- 무조건 내림(버림) 함수 : 반올림을 할 수 있어도 버림. 99.99 -> 99
- number floor(컬럼명)
- number trunc(컬럼명 [,자릿수])

*/

select 5.6789 from dual;
select floor(5.6789) from dual;
select trunc(5.6789) from dual;
select trunc(5.6789, 2) from dual;

/*
3. ceil
- 무조건 올림
- number ceil(컬럼명)
*/

select 4.123 from dual;
select ceil(4.123) from dual;
select ceil(4.00000000001) from dual;
select ceil(4) from dual;

-- 게시판(페이징)
select 65 / 20 as 총페이지 from dual; --3.25
select ceil(61 / 20) as 총페이지 from dual; --4


/*

4. mod()
- 나머지 함수
- number mod(피제수, 제수)

*/

select mod(10, 3) from dual; -- 10 % 3

-- 100분 -> 몇시간 몇분?
-- 100 / 60 -> 몫(시)
-- 100 % 60 -> 나머지(분)
select 
    floor(100 / 60) as 시,
    mod(100, 60) as 분
from dual;
