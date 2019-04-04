-- hr > ex13_function.sql

-- 하면 안되는 행동(내일)
select ibsadate, substr(ibsadate, 4, 2) from tblinsa;

/*

날짜/시간 함수

1. sysdate
- 현재 시간 반환
- date sysdate
- 자바의 Calendar.getInstance() 동일

*/
select sysdate from dual;
select sysdate() from dual; 

-- 날짜 연산
-- + 날짜, - 날짜
select sysdate + 3 from dual;
select sysdate - 3 from dual;

select 고객명, 대여일, 대여일 + 대여기간 as 반납예정일 from 도서관;

select name, ibsadate, ibsadate + 10000 from tblinsa;


-- 날짜 - 날짜 = 일
select name, ibsadate, round(sysdate - ibsadate) as 근무일수 from tblinsa; --근무 기간
select name, ibsadate, round((sysdate - ibsadate) / 365) as 근무년수 from tblinsa;
select name, ibsadate, floor((sysdate - ibsadate) / 365) as 근무년수 from tblinsa;
select name, ibsadate, ceil((sysdate - ibsadate) / 365) as 근무년수 from tblinsa;

-- 1번 정리
-- 시각 + 숫자(일) = 시각
-- 시각 - 시각 = 숫자(일)

/*
2. last_day()
- 해당 시각이 포함된 달의 마지막 날짜(시각)
- date last_day(date)
*/
select last_day(sysdate) from dual;


/*
3. months_between()
- number months_between(date, date)
*/

select 
    name, 
    ibsadate, 
    round(sysdate - ibsadate) as 근무일수, --***
    round((sysdate - ibsadate) / 30) as 근무월수,   
    round(months_between(sysdate, ibsadate)) as 근무월수, --***
    round((sysdate - ibsadate) / 365) as 근무년수,   
    round(months_between(sysdate, ibsadate) / 12) as 근무년수 --***
from tblinsa;

/*
4. add_months()
- date add_months(date, number)
*/
select sysdate + 1 from dual; --하루뒤
select sysdate + 30 from dual; --한달뒤(근사치) > 사용금지
select add_months(sysdate, 1) from dual; --한달뒤(정확)
select add_months(sysdate, -1) from dual; --한달전(정확)

/*
시각, 시간 연산
1. date + number = date
    : 시각 + 일 = 시각
2. date - date = number
    : 시각 - 시각 = 일
3. add_months(date, number) = date
    : 시각 + 월 = 시각
4. months_between(date, date) = number
    : 시각 - 시각 = 월
    
*/



























