-- hr > ex14_casting.sql

/*

형변환, Casting

1. to_char() : 숫자 -> 문자 //사용 빈도 낮음
2. to_char() : 날짜 -> 문자 //사용 빈도 높음(***)
3. to_number() : 문자 -> 숫자 //사용 빈도 낮음
4. to_date() : 문자 -> 날짜 //사용 빈도 높음(***)


1. to_char()
- char to_char(컬럼명, 형식문자열)

형식문자열 구성 요소
a. 9 : 숫자 1자리를 문자 1개로 바꾸는 역할(빈자리는 공백으로 채운다.) // %5s
b. 0 : 숫자 1자리를 문자 1개로 바꾸는 역할(빈자리는 0으로 채운다.) // %05s
c. $ : 통화 표시
d. L : 통화 표시(지역)
e. . : 소수점 표시
f. , : 천단위 표시

*/
select 100 as "aaaaaaaaaaaaaa", '100' as "bbbbbbbbbbbbbb" from dual;
select 100 + 200, '100' + 200 from dual; --암시적 형변환

select to_char(100) from dual; -- 100 -> '100'  //String.valueOf(100) -> "100"

-- 9와 0의 개수 -> 변환될 문자열의 자릿수
-- 9 : 유효 숫자만 변환
-- 0 : 빈자리를 0으로 채움
select to_char(100, '999') from dual; -- 100 -> '100'
select to_char(100, '000') from dual; -- 100 -> '100'

select to_char(10, '999') from dual; -- 10 -> ' 10'
select to_char(10, '000') from dual; -- 10 -> '010'

select to_char(1, '999') from dual; -- 1 -> '  1'
select to_char(1, '000') from dual; -- 1 -> '001'

select to_char(1000, '999') from dual; --실인자가 더 크면 동작 안함.(#### 반환)
select to_char(1000, '000') from dual;

select weight || 'kg' from tblcomedian; --암시적 형변환 발생
select to_char(weight, '999') || 'kg' from tblcomedian; --명시적 형변환

select 100 from dual; --100달러
select '$' || 100 from dual;
select to_char(100, '$999') from dual;
select to_char(100, '999원') from dual;
select to_char(100, '999') || '원' from dual;

select to_char(100, 'L999') from dual; --Locale(지역 설정에 맞는 표현을 사용해라)


select to_char(123.456, '999.999') from dual;
select to_char(123.456, '999.99') from dual; --반올림 처리

select to_char(1000000, '9,999,999') from dual; -- %,d
select to_char(1000000, '9,9,9,9,9,9,9') from dual;
select to_char(1000000, '999,9999') from dual;

/*
2. to_char() : 날짜 -> 문자
- char to_char(컬럼명, '형식 문자열')
- 컬럼명 : 날짜(date)

형식 문자열 구성 요소
a. yyyy (*)
b. yy
c. month
d. mon
e. mm (*)
f. day
g. dy
h. ddd, dd (*), d
i. hh(hh12), hh24 (*)
j. mi (*)
k. ss (*)
l. am(pm)

*/


select sysdate from dual; -- 19/03/21
select to_char(sysdate, 'yyyy') from dual; --2019년(4자리)(****************)
select to_char(sysdate, 'yy') from dual; --19년(2자리) X
select to_char(sysdate, 'month') from dual; --3월(로케일), March, 풀네임
select to_char(sysdate, 'mon') from dual; --3월(로케일), Mar, 약어
select to_char(sysdate, 'mm') from dual; --03(**************)
select to_char(sysdate, 'day') from dual; --목요일(로케일) 풀네임
select to_char(sysdate, 'dy') from dual; --목(로케일) 약어
select to_char(sysdate, 'ddd') from dual; --080. 올해 들어 며칠 지났는지?
select to_char(sysdate, 'dd') from dual; --21. 이번달 들어 며칠 지났는지?(************)
select to_char(sysdate, 'd') from dual; --5. 이번주 들어 며칠 지났는지?(=요일)
select to_char(sysdate, 'hh') from dual; --10시, 3시 //12시간
select to_char(sysdate, 'hh24') from dual; --10시, 15시 //24시간(****************)
select to_char(sysdate, 'mi') from dual; --13분
select to_char(sysdate, 'ss') from dual; --14초
select to_char(sysdate, 'am') from dual; --오전
select to_char(sysdate, 'pm') from dual; --오전

--자주 쓰는 패턴(***********************************************************)
select sysdate from dual; --19/03/21
select 
    to_char(sysdate, 'yyyy-mm-dd'), 
    to_char(sysdate, 'hh24:mi:ss'),
    to_char(sysdate, 'amhh:mi:ss')
from dual;


-- 컬럼으로 사용
select name, to_char(ibsadate, 'yyyy-mm-dd'), to_char(ibsadate, 'yyyy') as 입사년도 from tblinsa;

-- 조건으로 사용
-- 12월에 입사한 직원들?
select * from tblinsa where to_char(ibsadate, 'mm') = '12';
select * from tblinsa where to_char(ibsadate, 'yyyy') = '2010';
select * from tblinsa where to_char(ibsadate, 'mm') = '12' and to_char(ibsadate, 'yyyy') = '2009';
select * from tblinsa where to_char(ibsadate, 'yyyy-mm') = '2009-12';--***
select * from tblinsa where to_char(ibsadate, 'yyyymm') = '200912';--********************

-- 정렬로 사용
-- 고참 ~ 신참
select * from tblinsa order by ibsadate asc;
-- 월별
select * from tblinsa order by to_char(ibsadate, 'mm') asc;






/*
3. to_number() : 문자 -> 숫자
- number to_number(문자열)
- 자바 : Integer.parseInt(문자열)
*/

select '123' * 2 from dual; --현실
select to_number('123') * 2 from dual; --권장



/*
4. to_date() : 문자 -> 날짜
- date to_date(컬럼명, '형식문자열')
- 형식 문자열 구성요소가 위의 2번과 동일
*/

--** 오라클(SQL)은 문맥에 따라 날짜 상수(문자열)를 문자열로 취급하는 경우와 date로 취급하는 경우가 있다.
select sysdate, '2019-03-21', add_months('2019-03-21', 1) from dual;--문자열
select * from tblinsa where ibsadate < '2019-03-21';--날짜(문자열) 암시적 형변환 발생

--시,분,초 추가 > 암시적 형변환 불가능(DB 설정 & 툴 포맷 - 가능O, 불가능O) > 불가능
select title, adddate, to_char(adddate, 'yyyy-mm-dd hh24:mi:ss') from tbltodo
    --where adddate > '2019-03-05 12:30:00';
    --where adddate > to_date('2019-03-05 12:30:00', 'yyyy-mm-dd hh24:mi:ss'); --*****
    where adddate > to_date('2019-03-05 12:30:00', 'yyyy-mm-dd hh24:mi:ss');

select 
    sysdate, 
    to_date('2019-03-21', 'yyyy-mm-dd'), --자정으로 세팅(기억!!!!!)
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 
    to_char(to_date('2019-03-21', 'yyyy-mm-dd'), 'yyyy-mm-dd hh24:mi:ss'),
    to_date('15:30:45', 'hh24:mi:ss'), --해당 월의 1일로 세팅
    to_char(to_date('15:30:45', 'hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss')
from dual;













