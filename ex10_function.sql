-- hr > ex10_function.sql

/*

오라클(SQL)
- 수많은 기능 제공 > 함수 형태로 제공


집계 함수(통계)
1. count() : 개수
2. sum() : 합
3. avg() : 평균
4. max() : 최댓값
5. min() : 최솟값

1. count()
- 결과셋의 레코드 개수를 반환
- null은 제외한다.(******)
- 매개변수는 1개만 허용(2개 이상의 컬럼은 넣을 수 없다.) > 예외 : * 가능
- number count(컬럼명)

*/

select name from tblcountry;
select count(name) from tblcountry; -- 레코드 개수

select population from tblcountry; --null
select count(population) from tblcountry; --null

select name, population from tblcountry;
select count(name, population) from tblcountry; --ORA-00909: invalid number of arguments

select * from tblcountry;
select count(*) from tblcountry; -- 테이블의 행 개수(null이 의미가 없다.)


-- 모든 직원이 몇명? //무조건
select count(*) from tblinsa;

-- 연락처가 있는 직원이 몇명? //조건(null)
select count(tel) from tblinsa;
select count(*) from tblinsa where tel is not null; --가독성


-- count() 여러번 사용 가능
select count(name), count(buseo), count(tel) from tblinsa;

select
    count(*) as "총인원수",
    count(*) - count(tel) as "연락처 미기재 인원수",
    count(tel) as "연락처 기재 인원수"
from tblinsa;

select
    count(name),
    count(100),
    count(*)
from tblinsa;



-- 당신 회사에는 어떤 부서들이 있습니까?
select distinct buseo from tblinsa;

-- 당신 회사에는 부서가 몇종류(몇개)?
select count(distinct buseo) from tblinsa;

-- 개그맨 남자 몇명?
select * from tblcomedian;
select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

-- 한번에 보고 싶다(**** 자주 사용 ****)
select
    count(case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end),
    count(case
        when gender = 'm' then '남자'
    end),
    count(case
        when gender = 'f' then '여자'
    end)
from tblcomedian;





-- count(*) : 테이블의 전체 레코드 수
-- 등록된 할일이 몇건? > 20건
select count(*) from tbltodo;

-- 할일을 마친 건수? > 12건
select count(completedate) from tbltodo;

-- 아직 하지 않은 건수? > 8건
select count(*) - count(completedate) from tbltodo;
select count(*) from tbltodo where completedate is null;


-- 남자 직원수
select count(*) from tblinsa where ssn like '______-1______';
select count(*) from tblinsa where ssn like '%-1%';

-- 남자 몇명? + 남자 직원들 이름?
-- ORA-00937: not a single-group group function
-- 집계함수와 단일컬럼은 동시에 사용이 불가능하다. > 
select count(*), name from tblinsa where ssn like '%-1%';

select avg(basicpay) from tblinsa;
-- 직원 중 평균 급여보다 더 많은 급여를 받는 직원?
-- ORA-00934: group function is not allowed here
-- where절은 개인(한 행, 레코드 1개, 객체)에 대한 질문을 하는 곳이다.
select * from tblinsa where basicpay > avg(basicpay);





-- tblinsa 급여 > 100만원대별로 직원수?
select
    count(case
        when basicpay < 1000000 then 1
    end),
    count(case
        when basicpay >= 1000000 and basicpay < 2000000 then 1
    end),
    count(case
        when basicpay >= 2000000 then 1
    end)
from tblinsa;

/*

tblcountry
1. 아시아(AS)와 유럽(EU)에 속한 국가는 총 몇개? - in, count > 7개
2. 인구수가 7000 ~ 20000 사이인 국가는 총 몇개? - between, count > 1개

employees
3. IT_PROG 중에서 급여가 5000불이 넘는 직원 몇명? - count > 2명

tblinsa
4. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) > 42명
5. 서울 사람 빼고 나머지 몇명? > 40명
6. 80년대생 + 여자직원 몇명? > 9명

*/











-- 1. 아시아(AS)와 유럽(EU)에 속한 국가는 총 몇개? - in, count
select count(*) from tblcountry where continent in ('AS', 'EU'); --7

-- 2. 인구수가 7000 ~ 20000 사이인 국가는 총 몇개? - between, count
select count(*) from tblcountry where population between 7000 and 20000; --1

-- 3. IT_PROG 중에서 급여가 5000불이 넘는 직원 몇명? - count
select count(*) from employees where job_id = 'IT_PROG' and salary >= 5000; --2

-- 4. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외)
select count(*) from tblinsa where not tel not like '010%';-- and tel is not null; --42

-- 5. 서울 사람 빼고 나머지 몇명?
select count(*) from tblinsa where city <> '서울'; --40

-- 6. 80년대생 + 여자직원 몇명?
select count(*) from tblinsa where ssn like '8%' and ssn like '%-2%'; --9



/*

2. sum()
- number sum(컬럼명)
- 해당 컬럼값들의 합을 구한다.
- 숫자 컬럼을 대상으로 한다.

*/
select sum(weight) from tblcomedian;
select sum(first) from tblcomedian; -- ORA-01722: invalid number

select sum(weight + 10) from tblcomedian;

select population from tblcountry;
select sum(population) from tblcountry; -- null은 제외

-- 이번 달 총 급여 지급액? + 총 수당
select basicpay from tblinsa;
select sum(basicpay), sum(sudang), sum(basicpay) + sum(sudang), sum(basicpay + sudang) from tblinsa;

-- 한달 평균 급여?
select sum(basicpay + sudang) / count(*) from tblinsa;

select sum(basicpay), name from tblinsa; --error


/*

3. avg()
- number avg(컬럼명)
- 컬럼값들의 평균값을 반환한다.
- 숫자 컬럼을 대상으로 한다.

*/

-- 나라별 인구수
select population from tblcountry;

-- 나라별 평균 인구수?
select avg(population) from tblcountry; --18215

select sum(population) / count(*) from tblcountry; --16914
select sum(population) / count(population) from tblcountry; --18215

-- 회사 보너스 지급
-- 실적에 따라서 지급
-- 일부 직원은 실적이 없다.
-- 1. 실적이 있는 사람들에 한해서 지급 > count(실적) = avg()
-- 2. 모든 사람에 대해서 지급 > count(*)


/*

4. max()
5. min()
- object max(컬럼명) > 최댓값 반환
- object min(컬럼명) > 최솟값 반환
- 숫자, 날짜, 문자(X) 모두 적용

*/

select max(basicpay), min(basicpay) from tblinsa;
select max(height), min(height) from tblcomedian;

select min(ibsadate) from tblinsa; --2005-02-23, 최고참의 입사일
select max(ibsadate) from tblinsa; --2015-09-26, 신참의 입사일

select max(name) from tblinsa; --황진이

select name, buseo, jikwi from tblinsa order by buseo asc, jikwi asc, name asc;

select
    count(*) as "총직원수",
    sum(basicpay) as "총급여",
    avg(basicpay) as "평균급여",
    max(basicpay) as "최대급여",
    min(basicpay) as "최소급여"
from tblinsa;

/*

sum()
1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblcountry --16591
2. 매니저(108)이 관리하고 있는 직원들의 급여 합? employees --39600
3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? employees --120000
4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblinsa --33812400
5. 장급(부장+과장)들의 총급여합? tblinsa --36289000

avg()
1. 아시아에 속한 국가의 평균 인구수? tblcountry --45764.25
2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분안함) employees --6270.4
3. 장급(부장,과장)의 평균 급여? tblinsa --2419266
4. 사원급(대리,사원)의 평균 급여? tblinsa --1268946
5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차이는 얼마? tblinsa --1150320


max(), min()
1. 면적이 가장 넓은 나라의 면적? tblcountry --959
2. 급여(급여+수당)가 가장 적은 직원은 얼마 받는가? tblinsa --988000
*/















--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblcountry
select sum(population) from tblcountry where continent in ('EU', 'AF');

--2. 매니저(108)이 관리하고 있는 직원들의 급여 합? employees
select sum(salary) from employees where manager_id = 108;

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? employees
select sum(salary) from employees where job_id in ('ST_CLERK', 'SH_CLERK');

--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblinsa
select sum(basicpay + sudang) from tblinsa where city = '서울';

--5. 장급(부장+과장)들의 총급여합? tblinsa
select sum(basicpay) from tblinsa where jikwi in ('부장', '과장');

-- 1. 아시아에 속한 국가의 평균 인구수? tblcountry
select avg(population) from tblcountry where continent = 'AS';

-- 2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분안함) employees
select avg(salary) from employees 
    where first_name like '%AN%' or 
    first_name like '%an%' or 
    first_name like '%An%' or 
    first_name like '%aN%';

--3. 장급(부장,과장)의 평균 급여? tblinsa 
select avg(basicpay) from tblinsa where jikwi in ('부장', '과장');

--4. 사원급(대리,사원)의 평균 급여? tblinsa
select avg(basicpay) from tblinsa where jikwi in ('대리', '사원');

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차이는 얼마? tblinsa
select
    avg(
        case
            when jikwi in ('부장', '과장') then basicpay
        end
    ) - 
    avg(
        case
            when jikwi in ('대리', '사원') then basicpay
        end
    ) 
from tblinsa;

-- 1. 면적이 가장 넓은 나라의 면적? tblcountry
select max(area) from tblcountry;

--2. 급여(급여+수당)가 가장 적은 직원은 얼마 받는가? tblinsa
select min(basicpay + sudang) from tblinsa;





-- 5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차이는 얼마?
select
    avg(basicpay)
from tblinsa where jikwi in ('부장', '과장');

select
    avg(basicpay)
from tblinsa where jikwi in ('대리', '사원');


--*****
select
    avg(case
        when jikwi in ('부장', '과장') then basicpay
    end) -
    avg(case
        when jikwi in ('대리', '사원') then basicpay
    end)
from tblinsa;
















