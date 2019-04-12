-- hr > ex12_function.sql

/*

문자열 함수

1. upper(), lower(), initcap()
- varchar2 upper(컬럼명)
*/
select
    'studentName',
    upper('studentName'),
    lower('studentName'),
    initcap('studentName')
from dual;

-- employee > 'AN' 포함 직원
select first_name from employees where upper(first_name) like '%AN%';

-- 'an' > 사용자가 입력한 값 > 변수
select first_name from employees where upper(first_name) like '%' || upper('an') || '%';


/*
2. substr
- 문자열 추출 함수
- varchar2 substr(컬럼명, 시작위치, 개수)
- varchar2 substr(컬럼명, 시작위치)
- 서수가 1부터 시작한다.(****)
*/
select '가나다라마바사아자차카타파하' from dual;
select substr('가나다라마바사아자차카타파하', 5, 3) from dual;
select substr('가나다라마바사아자차카타파하', 5) from dual;
select substr('가나다라마바사아자차카타파하', -5) from dual;

select name, substr(name, 1, 1) as 성, substr(name, 2) as 이름 from tblinsa;
select substr(ssn, 8, 1) from tblinsa;

-- 남자 직원수? 31명
select count(case when substr(ssn, 8, 1) = '1' then 1 end) from tblinsa;
select count(*) from tblinsa where ssn like '%-1%';
select count(*) from tblinsa where ssn like '______-1______';
select count(*) from tblinsa where substr(ssn, 8, 1) = '1';

-- 남자(1, 3, 5, 7, 9)
select count(*) from tblinsa where substr(ssn, 8, 1) = '1' or substr(ssn, 8, 1) = '3';
select count(*) from tblinsa where substr(ssn, 8, 1) in ('1', '3', '5', '7', '9'); --****
select count(*) from tblinsa where mod(substr(ssn, 8, 1), 2) = 1;

/*

1. 직원명과 생년을 가져오시오. (ssn > 1999년대 생)
[이름]    [생년]
홍길동    1990
아무개    1994
...

2. 서울에 사는 여직원 중 80년대생 총 몇명?

3. 장급(부장,과장)들은 어떤 성씨를 가지고 있는지?(김,박,정,최,조)

4. 직원들을 태어난 월순으로 정렬을 해서 가져오시오.(오름차순 -> 월, 이름)
*/
select * from tblinsa where city = '서울' order by substr(ssn, 8, 1);

--1.1. 직원명과 생년을 가져오시오. (ssn > 1900년대 생)
select name as 이름, '19' || substr(ssn, 1, 2) as 생년 from tblinsa;

--2. 서울에 사는 여직원 중 80년대생 총 몇명?
select count(*) from tblinsa 
where city = '서울' and substr(ssn, 1, 1) = '8' and substr(ssn, 8, 1) = '2';

--3. 장급(부장,과장)들은 어떤 성씨를 가지고 있는지?(김,박,정,최,조)
select distinct substr(name, 1, 1) from tblinsa 
    where jikwi in ('부장', '과장') order by substr(name, 1, 1);

--4. 직원들을 태어난 월순으로 정렬을 해서 가져오시오.(오름차순 -> 월, 이름)
select * from tblinsa order by substr(ssn, 3, 2), name;


-- 60명 중 각 성씨별로 몇명?
select
    
    count(
        case
            when substr(name, 1, 1) = '박' then 1
        end
    )
    ,
    count(
        case
            when substr(name, 1, 1) = '김' then 1
        end
    )

from tblinsa;

/*

3. length()
- 문자열 길이
- number length(컬럼명)

*/

-- 컬럼 리스트
select name, length(name) from tblcountry;

-- 조건절
select name from tblcountry where length(name) > 3;
select name from tblcountry where length(name) between 3 and 5;
select name from tblcountry where length(name) in (3, 7);

-- 정렬
select name from tblcountry order by length(name) desc;

select
    case
        when length(name) >= 4 then substr(name, 1, 3) || '..'
        else name
    end 
from tblcountry;

/*
employees
1. 이름(first_name + last_name)이 가장 긴 순서대로 가져오시오.
2. 이름(first_name + last_name)이 가장 긴 사람은 몇글자?
3. last_name이 4자인 사람들의 first_name이 궁금하다.
*/

select first_name || ' ' || last_name, length(first_name || last_name) from employees
    order by length(first_name || last_name) desc;

select * from employees
    order by length(first_name || last_name) desc;

select max(length(first_name || last_name)) from employees;

select first_name, last_name from employees where length(last_name) = 4;


/*
4. instr
- indexOf
- 검색어의 위치 반환
- number instr(컬럼명, 검색어)
- number instr(컬럼명, 검색어, 시작위치)
*/

select '안녕하세요. 홍길동님.' from dual;
select instr('안녕하세요. 홍길동님.', '홍길동') from dual; --8
select instr('안녕하세요. 홍길동님.', '아무개') from dual; --0

select instr('안녕하세요. 홍길동님. 안녕하세요. 홍길동님.', '홍길동') from dual;
select instr('안녕하세요. 홍길동님. 안녕하세요. 홍길동님.', '홍길동', 11) from dual;

-- 이름에 '길'자가 포함된 직원?
select * from tblinsa where instr(name, '길') > 0;
select * from tblinsa where name like '%길%';

-- 이름에서 길이 발견된 순서대로 정렬
select * from tblinsa where instr(name, '길') > 0 order by instr(name, '길');


/*
5. lpad, rpad
- varchar2 lpad(컬럼명, 개수, 문자)
- varchar2 rpad(컬럼명, 개수, 문자)
*/

-- 한글 2, 나머지 1
-- 오버플로우 발생 > 짤림
select title, lpad(title, 20, '@') from tbltodo;
select seq, lpad(seq, 3, '0') from tbltodo; -- String.format('%03d', seq)

select
    lpad(1, 3, '0'),
    lpad(12, 3, '0'),
    lpad(123, 3, '0'),
    lpad(1234, 3, '0'),
    lpad(12345, 3, '0')
from dual;


-- char vs varchar2
create table tblChar
(
    txt1 char(10), --고정자릿수
    txt2 varchar2(10) --가변자릿수
);

insert into tblChar (txt1, txt2) values ('abc', 'abc');

select * from tblChar;
select length(txt1), txt1, length(txt2), txt2 from tblChar;

select * from tblChar where txt2 = 'abc';
select * from tblChar where txt1 = 'abc'; --잘못된 상황(오라클 편의를 봐줘서 결과가 나옴)
select * from tblChar where length(txt1) = 3; --주의!!!!!!
select * from tblChar where length(trim(txt1)) = 3;
select length(trim(txt1)), length(txt1) from tblChar;

-- varchar2만 사용

/*
6. trim(), ltrim(), rtrim()
- varchar2 trim(컬럼명)
*/
select '   홍길동   ' from dual;
select trim('   홍길동   ') from dual;
select ltrim('   홍길동   ') from dual;
select rtrim('   홍길동   ') from dual;

/*
7. replace
- 문자열 치환
- varchar2 replace(컬럼명, 찾을 문자열, 바꿀 문자열)
*/

select replace('홍길동', '홍', '김') from dual;

select name, replace(replace(substr(ssn, 8, 1), '1', '남자'), '2', '여자') from tblinsa;

select 
    name, 
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        when continent = 'AU' then '오스트레일리아'
        when continent = 'SA' then '아메리카'
    end
from tblcountry;

select name, 
replace(replace(replace(replace(replace(continent, 'AS', '아시아'), 'EU', '유럽'), 'AF', '아프리카'), 'AU', '오스트레일리아'), 'SA', '아메리카') from tblcountry;


/*
8. decode()
- 문자열 치환
- replace() 유사, case end 유사
- varchar2 decode(컬럼명, 문자열, 문자열, 문자열, 문자열, 문자열, 문자열 ...)
*/

select
    replace(replace(continent, 'AS', '아시아'), 'EU', '유럽'),
    decode(continent, 'AS', '아시아', 'EU', '유럽', 'AF', '아프리카', 'AU', '호주', 'SA', '아메리카')
from tblcountry;

select
    count(case
        when jikwi = '부장' or jikwi = '과장' then 1
    end),
    count(case
        when jikwi = '사원' or jikwi = '대리' then 1
    end)
from tblinsa;

select
    count(decode(jikwi, '부장', 1, '과장', 1)),
    count(decode(jikwi, '사원', 1, '대리', 1))
from tblinsa;

/*
1. 아래와 같이 가져오시오.
[아시아]   [유럽]    [아프리카]      [오스트레일리아]       [아메리카]
4           3         1              1                      2

2. 아래와 같이 가져오시오. tblinsa
[김]     [이]      [박]        [최]      [정]
5        12        3           7         3

*/

select
    count(decode(jikwi, '부장', 1, '과장', 1)),
    count(decode(jikwi, '사원', 1, '대리', 1))
from tblinsa;

--1.
select
    count(decode(continent, 'AS', 1)) as 아시아,
    count(decode(continent, 'EU', 1)) as 유럽,
    count(decode(continent, 'AF', 1)) as 아프리카,
    count(decode(continent, 'AU', 1)) as 오스트레일리아,
    count(decode(continent, 'SA', 1)) as 아메리카
from tblcountry;

select
    (decode(continent, 'AS', 1)) as 아시아,
    (decode(continent, 'EU', 1)) as 유럽,
    (decode(continent, 'AF', 1)) as 아프리카,
    (decode(continent, 'AU', 1)) as 오스트레일리아,
    (decode(continent, 'SA', 1)) as 아메리카
from tblcountry;

--2.
select
    count(decode(substr(name, 1, 1), '김', 1)) as 김,
    count(decode(substr(name, 1, 1), '이', 1)) as 이,
    count(decode(substr(name, 1, 1), '박', 1)) as 박,
    count(decode(substr(name, 1, 1), '최', 1)) as 최,
    count(decode(substr(name, 1, 1), '정', 1)) as 정
from tblinsa;

select
    (decode(substr(name, 1, 1), '김', 1)) as 김,
    (decode(substr(name, 1, 1), '이', 1)) as 이,
    (decode(substr(name, 1, 1), '박', 1)) as 박,
    (decode(substr(name, 1, 1), '최', 1)) as 최,
    (decode(substr(name, 1, 1), '정', 1)) as 정
from tblinsa;
