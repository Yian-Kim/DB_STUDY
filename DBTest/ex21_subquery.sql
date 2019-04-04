-- hr > ex21_subquery.sql

/*

Sub Query, 서브 쿼리
- 쿼리안에 또 다른 쿼리가 있는 형태

select 문 (select 문)
insert 문 (select 문)
update 문 (select 문)
delete 문 (select 문)

*/
-- 인구수가 가장 많은 나라의 인구?
select max(population) from tblcountry;

-- 인구수가 가장 많은 나라의 국가명?
select max(population), name from tblcountry;
select name from tblcountry where population = max(population);

-- 서브 쿼리의 역할 > 함수의 반환값과 유사
select name from tblcountry where population = (select max(population) from tblcountry);

-- 직원 중 가장 월급이 많은 사람?
select max(basicpay) from tblinsa; --2650000
select * from tblinsa where basicpay = 2650000; --허경운

select * from tblinsa where basicpay = (select max(basicpay) from tblinsa);

-- 가장 월급이 적은 사람
select * from tblinsa where basicpay = (select min(basicpay) from tblinsa);

-- 평균 월급보다 더 받는 직원
select * from tblinsa where basicpay > (select avg(basicpay) from tblinsa);

-- 평균 월급보다 덜 받는 직원
select * from tblinsa where basicpay < (select avg(basicpay) from tblinsa);


-- tblinsa. '김정훈' 직원보다 급여를 더 많이 받는 사람들?
-- tblmen + tblwomen. 남자 중  키 165cm, 몸무게 58kg > 그남자의 여자 친구 정보를 가져오시오.

select * from tblinsa 
    where basicpay > (select basicpay from tblinsa where name = '김정훈');

select * from tblwomen 
    where name = (select couple from tblmen
                            where height = 165 and weight = 58);



-- '홍길동'과 같은 부에서 있는 사람
select * from tblinsa
    where buseo = (select buseo from tblinsa where name = '홍길동');


-- 서브쿼리의 결과와 단일컬럼을 비교할 때 반드시 in을 사용한다.(단, 서브쿼리의 결과가 1개 컬럼일때)
-- 급여를 250만원 이상 받는 사람과 같은 부서에 있는 사람?
-- ORA-01427: single-row subquery returns more than one row
select * from tblinsa
    --where buseo = (select buseo from tblinsa where basicpay >= 2500000);
    --where buseo = '기획부' or buseo = '영업부' or buseo = '총무부';
    --where buseo in ('기획부', '영업부', '총무부');
    where buseo in (select buseo from tblinsa where basicpay >= 2600000);

-- '홍길동'과 같은 부서에 근무하면서 같은 지역에 사는 사람?
select buseo, city from tblinsa where name = '홍길동';

select * from tblinsa
    where buseo = '기획부' and city = '서울';

select * from tblinsa
    where buseo = (select buseo from tblinsa where name = '홍길동') 
            and city = (select city from tblinsa where name = '홍길동');

-- 1 레코드 + 다중 컬럼
select * from tblinsa
    where (buseo, city) = (select buseo, city from tblinsa where name = '홍길동');

-- 복수 레코드 + 다중 컬럼
select * from tblinsa
    where (buseo, city) in (select buseo, city from tblinsa where basicpay >= 2600000);


-- 서브 쿼리의 용도
-- 1. 조건절에 사용
-- 2. from절에 사용 > '인라인 뷰'
-- 3. 컬럼 리스트에 사용 > 서브 쿼리가 컬럼으로 사용 > 상관서브쿼리(바깥쪽의 데이터를 안쪽 테이블에서 사용할 때) ****
select 직원명, jikwi from (select name as 직원명, jikwi, ssn, tel from tblinsa where buseo = '기획부'); --임시 기획부 테이블

select name, jikwi, buseo, (select name from tblinsa where num = 1001) from tblinsa;

select name, jikwi, buseo, (select count(*) from tblinsa) from tblinsa;

select name, jikwi, buseo, (select count(*) from tblinsa) from tblinsa;

select * from tblmen;
select * from tblwomen;

-- '홍길동'의 키와 여자친구인 '장도연'의 키를 가져오시오.
select height from tblmen where name = '홍길동'; --180
select height from tblwomen where name = '장도연'; --177


select name, height, couple, (select height from tblwomen where name = tblmen.couple) from tblmen where name = '홍길동';

select name, height, couple, (select height from tblwomen where name = tblmen.couple) from tblmen;




select * from employees;
select * from departments;
select * from locations;

-- 'London'에 위치한 부서에 근무하는 직원들?
-- 'London'에(locations) 위치한 부서(departments)에 근무하는 직원들(employees)?

select * from employees where department_id = 40;
select * from departments where location_id = 2400;
select * from locations where city = 'London';

select * from employees 
    where department_id = (select department_id from departments 
                where location_id = (select location_id from locations where city = 'London'));













