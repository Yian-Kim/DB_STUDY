-- hr > ex20_groupby.sql

/*

group by 절
- 레코드들을 특정 컬럼값(1개 or 이상)에 맞춰서 그룹을 나누는 작업
- 그룹을 왜 나누는지??
    1. 각각의 나눠놓은 그룹 > 그룹별로 집계함수를 적용하려고 > count, sum, avg, max, min
    
    
group by 컬럼명
    - 그룹을 짓는 기준이 되는 데이터(컬럼) > 1개 이상
    
    
    

SELECT 문
- SELECT 컬럼리스트 FROM 테이블
- SELECT 컬럼리스트 FROM 테이블 WHERE 조건
- SELECT 컬럼리스트 FROM 테이블 WHERE 조건 ORDER BY 정렬
- SELECT 컬럼리스트 FROM 테이블 WHERE 조건 GROUP BY 조건 ORDER BY 정렬
- SELECT 컬럼리스트 FROM 테이블 WHERE 조건 GROUP BY 조건 HAVING 조건 ORDER BY 정렬

1. SELECT 컬럼리스트
    - 가져올 컬럼을 지정한다.
    - 가져올 값을 연산하기도 한다.
2. FROM 테이블
    - 테이블 선택한다.
3. WHERE 조건
    - 가져올 레코드를 지정한다.
4. ORDER BY 정렬
    - 가져올 레코드의 순서를 지정한다.(정렬)
5. GROUP BY 조건
    - 가져올 레코드들을 그룹 짓는다.
6. HAVING 조건
    - GROUP BY 조건으로 사용한다.
    
절 실행순서
- FROM(1) > SELECT(2)
- FROM(1) > WHERE(2) > SELECT(3)
- FROM(1) > WHERE(2) > ORDER BY(3) > SELECT(4)
- FROM(1) > WHERE(2) > GROUP BY(3) > ORDER BY(4) > SELECT(5)
- FROM(1) > WHERE(2) > GROUP BY(3) > HAVING(4) > ORDER BY(5) > SELECT(6)

*/

-- tblinsa. 부서별(그룹)로 평균 급여(집계)??
select * from tblinsa;

-- 평균 급여?
select round(avg(basicpay)) from tblinsa; --1556527


-- 아래 방식의 문제점
-- 1. 비용이 많이 든다.(코드량이 많다.) > 부서 500개
-- 2. 변화에 약하다. > 유지,보수가 힘들다.

-- 부서가 뭐뭐?
select distinct buseo from tblinsa;

select round(avg(basicpay)) from tblinsa where buseo = '총무부'; --1714857
select round(avg(basicpay)) from tblinsa where buseo = '개발부'; --1387857
select round(avg(basicpay)) from tblinsa where buseo = '영업부'; --1601513
select round(avg(basicpay)) from tblinsa where buseo = '기획부'; --1855714
select round(avg(basicpay)) from tblinsa where buseo = '인사부'; --1533000
select round(avg(basicpay)) from tblinsa where buseo = '자재부'; --1416733
select round(avg(basicpay)) from tblinsa where buseo = '홍보부'; --1451833



-- group by 사용 
select round(avg(basicpay)) -- 3.
    from tblinsa -- 1.
        group by buseo; -- 2.


-- group by 결과 셋의 컬럼 리스트에 집계함수와 group by의 조건이 올 수 있다.
select round(avg(basicpay)), buseo
    from tblinsa
        group by buseo;


-- count()
-- 남자 직원수? 여자 직원수?
-- 부장 몇명? 과장 몇명? 대리? 사원?
-- 부서별 직원수?

select buseo, count(*), count(tel), count(*) - count(tel) from tblinsa
    group by buseo;

select jikwi, count(*) from tblinsa
    group by jikwi;

-- 장급 몇명? 사원급 몇명?
select count(*), 
    case 
        when jikwi in ('부장', '과장') then '장급'
        when jikwi in ('대리', '사원') then '사원급'
    end 
        from tblinsa
        group by 
            case 
                when jikwi in ('부장', '과장') then '장급'
                when jikwi in ('대리', '사원') then '사원급'
            end;


select
    case 
        when jikwi in ('부장', '과장') then 1
        when jikwi in ('대리', '사원') then 2
    end
from tblinsa;


select 
    case 
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end,
    count(*) from tblinsa
        group by substr(ssn, 8, 1);

-- 1. 입사한 년도별로 그룹 나눠서 > 몇명?
-- [입사년도]   [인원수]
-- 2008         10
-- 2009          5
-- 2010          7
-- ..

--group by에서 정렬하는 방법 > 컬럼 리스트에 있는 표현 중 하나를 사용한다.
select count(*), to_char(ibsadate, 'yyyy') from tblinsa
    group by to_char(ibsadate, 'yyyy')
        --order by count(*) desc;
        order by to_char(ibsadate, 'yyyy'); 


-- 팁 : 그룹의 조건을 어떻게 만들어야 할지 모르겠다?? > 조건으로 사용할 컬럼을 일단 출력해봐라.
select 
    case
        when basicpay <= 1000000 then 1
        when basicpay > 1000000 and basicpay <= 2000000 then 2
        when basicpay > 2000000 then 3
    end,
    ceil(basicpay / 1000000)
from tblinsa;

-- 급여(100만 이하, 100~200만, 200만 이상) > 몇명??
select count(*), ceil(basicpay / 1000000) * 1000000 from tblinsa
    group by ceil(basicpay / 1000000);

-- 성씨별 인원수?
select count(*), substr(name, 1, 1) from tblinsa
    group by substr(name, 1, 1)
        order by count(*) desc, substr(name, 1, 1) asc;


-- 부서별 + 인원수?
-- + 부서별(직위별)
select buseo, jikwi, city, count(*) from tblinsa
    group by buseo, jikwi, city
        order by buseo, jikwi, city;


/*

HAVING 절
1. WHERE : 가져올 레코드에 조건을 지정한다.
    - 대상(실행 순서)이 다르다. > FROM 절을 대상으로 조건을 건다.
    - 개인에 대한 질문(레코드에 대한 질문) > 한사람 한사람에게 질문
    
2. HAVING : 가져올 레코드에 조건을 지정한다.
    - 대상(실행 순서)이 다르다. > GROUP BY 절을 대상으로 조건을 건다.
    - 집합에 대한 질문(통계함수에 대한 질문) > 각 그룹에게 질문
*/

select * from tblinsa where city = '서울';
select city, count(*) from tblinsa group by city having count(*) > 10;


select buseo, round(avg(basicpay)) 
    from tblinsa
        group by buseo;

select buseo, round(avg(basicpay)) 
    from tblinsa
        where basicpay >= 1500000 --개인에 대한 질문(그룹 함수 사용 금지)
            group by buseo;

select buseo, round(avg(basicpay)) 
    from tblinsa
        group by buseo
            having avg(basicpay) >= 1500000;--그룹을 대상으로 질문 > 통계 함수 반환값에 대한 질문


select buseo, round(avg(basicpay)) 
    from tblinsa
        where basicpay >= 1500000 --첫번째 탈락
            group by buseo
                having avg(basicpay) >= 2000000; --두번째 탈락

/*

1. 대륙별로 최대 인구수, 최소 인구수, 최대 면적, 최소 면적을 가져오시오. tblcountry
[대륙]    [최대 인구수]        [최소 인구수]        [최대 면적]     [최소 면적]
AS         120030               35                   905             13
EU         2467                 21                   874             18
..

*/

select 
    continent as "대륙",
    max(population) as "최대 인구수",
    min(population) as "최소 인구수",
    max(area) as "최대 면적",
    min(area) as "최소 면적"
        from tblcountry
            group by continent;


/*
2. 직업별 직원수를 가져오시오. employees
[직업]        [직원수]
IT_PROG       8
ST_CLERK      3
..
*/
select 
    job_id as "직원",
    count(*) as "직원수"
        from employees
            group by job_id;


/*
3. 부서별 직원수를 가져오시오. + 정렬(직원이 많은 순서대로..) tblinsa
[부서]        [직원수]
영업부        18
총무부        12
...
*/
select buseo as "부서",
    count(*) as "직원수"
        from tblinsa
            group by buseo
                order by count(*) desc;

/*

4. 지역별 직원수를 가져오시오. tblinsa

*/

select city as "지역",
    count(*) as "직원수"
        from tblinsa
            group by city
                order by count(*) desc;

/*
5. 부서별로 직원들의 급여합을 가져오시오.(basicpay + sudang)
- 부서별로 한달 지출액이 궁금합니다.
[부서]        [총지급액]      [부서인원수]     [최대 금액]     [최소 금액]
영업부        360000000       18               2500000         1200000
총무부        280000000       12
..
*/

select
    buseo as "부서",
    sum(basicpay + sudang) as "총지급액",
    count(*) as "부서인원수",
    max(basicpay + sudang) as "최대 금액",
    min(basicpay + sudang) as "최소 금액"
        from tblinsa
            group by buseo;


/*
6. 부서별 직급의 인원수를 가져오시오. - case or decode 사용
- 기획부 부장 : 1
- 기획부 과장 : 2

[부서]    [총인원]       [부장]        [과장]        [대리]        [사원]
기획부     6               1           1               2           2
영업부     13              1           2               4           6

*/
select
    buseo as "부서",
    count(*) as "총인원",
    count(decode(jikwi, '부장', 1)) as "부장",
    count(decode(jikwi, '과장', 1)) as "과장",
    count(decode(jikwi, '대리', 1)) as "대리",
    count(decode(jikwi, '사원', 1)) as "사원"
        from tblinsa
            group by buseo;






select
    count(decode(jikwi, '부장', 1))
        from tblinsa
            group by buseo;

select
    count(decode(jikwi, '부장', 1))
        from tblinsa where buseo = '기획부';
        
        
        















