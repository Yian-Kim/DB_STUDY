-- hr > ex07_where.sql

-- 조건절에 사용되는 구문들(연산자 or 절)

/*

between
- where 절에서 사용(조건으로 사용)
- 범위 조건 지정
- 컬럼명 between 최솟값 and 최댓값 
- 되도록 사용할 것(between 사용하지 말것 - 속도 느림)
- 최솟값, 최댓값 : 포함(inclusive)

*/

-- 몸무게 60이상 ~ 80이하
select last || first as name, weight 
from tblcomedian 
--where weight >= 60 and weight <= 80;
where 80 >= weight and 60 <= weight;

select last || first as name, weight 
from tblcomedian 
where weight between 60 and 80;


-- 비교 연산에 사용되는 자료형
-- 1. 숫자형
-- 2. 문자형 > str1.compareTo(str2)
-- 3. 날짜시간 > tick값

select * from tblcomedian where height > 170;
select * from tblcomedian where first > last; -- 문자형 직접 비교 가능
select * from employees where hire_date > '2003-01-01';

select * from tblcomedian where last > '다' and last < '자';
select * from tblcomedian where last between '다' and '자';

select * from employees where hire_date > '2003-01-01' and hire_date < '2003-12-31';
select * from employees where hire_date between '2003-01-01' and '2003-12-31';

select * from tblcomedian where height between 172 and 178;
select * from tblcomedian where not height between 172 and 178;




/*

in
- WHERE절에서 사용(조건으로 사용)
- 열거형 조건(제시된 값중에서 하나라도 일치하면 만족)
- 컬럼명 in (열거형값)

*/

-- SQL 문법은 대소문자를 구분하지 않는다.
-- 데이터는 대소문자를 구분한다.
-- AS + EU
select * from tblcountry where continent = 'AS' or continent = 'EU';
select * from tblcountry where continent in ('AS', 'EU');

select * from tbldiary where weather = '맑음';
select * from tbldiary where weather = '맑음' or weather = '흐림';
select * from tbldiary where weather in ('맑음', '흐림');
select * from tbldiary where weather in ('맑음', '흐림') 
    and regdate between '2019-01-20' and '2019-01-26';

select * from tblinsa where basicpay between 2000000 and 2500000;
select name, basicpay, sudang from tblinsa;
select name, basicpay, sudang from tblinsa where basicpay + sudang between 2000000 and 2500000;

select * from tblinsa 
    where jikwi in ('부장', '과장') and city in ('서울', '인천');



/*

like
- WHERE절에서 사용(조건으로 사용)
- 패턴 비교(특정한 패턴을 가지는 문자열 검색)
- 문자형을 대상으로 동작(숫자, 날짜 적용 못함)
- 정규 표현식의 간단한 버전
- 컬럼명 like '패턴 문자열'

패턴 문자열 구성 요소
1. _ : 임의의 문자 1개
2. % : 임의의 문자 0개 ~ 무한대

*/
select name from tblinsa;
select name from tblinsa where name like '김__' or name like '김_';
select name, tel from tblinsa where tel like '011-9___-___5';
select name from tblinsa where name like '__동';
select name from tblinsa where name like '_길_';

select * from employees where first_name like 'A________'; --정밀도 높음, 검색률 낮음
select * from employees where first_name like 'A%'; --정밀도 낮음, 검색률 높음
select * from employees where first_name like '%a';
select * from employees where first_name like 'A%a';
select * from employees where first_name like 'A%a%a';
select * from employees where first_name like '%a%'; --현재 사이트 검색 로직


/*

null
- 자바의 null과 유사
- 직접 표현도 가능(null)
- 컬럼이 비어있는 상태(셀)

null은 연산의 대상이 될 수 있다.(모든 언어 공통)

null 조건
- WHERE절 사용
- 컬럼명 is null

*/

-- 인구수가 미기재된 나라?
select * from tblcountry where population = null; -- population == null
select * from tblcountry where population is null;

select * from tblcountry where not population is null; --FM
select * from tblcountry where population is not null; --더 많이 사용

-- tel 기재안된 사람?
select * from tblinsa where tel is null;

-- 도서관.대여 테이블
select * from tblinsa where tel is null;

-- 아직 책을 빌려간뒤 반납안한 사람??
select 이름, 대여날짜, 반납날짜 from 대여테이블 where 반납날짜 is null;

-- 맘만 먹고 아직 안한일?
select * from tbltodo where completedate is null;

-- 맘먹고 한일?
select * from tbltodo where completedate is not null;






























