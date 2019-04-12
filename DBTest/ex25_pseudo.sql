-- hr > ex25_pseudo.sql

/*

의사 컬럼, Pseudo Column
- 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
- 오라클 전용
- rownum, MS-SQL(top), MySQL(limit)
- 서브쿼리 의존

*/

select name, buseo, jikwi, rownum from tblinsa;

-- 1이 포함된 것
select name, buseo, jikwi, rownum from tblinsa where rownum = 1;
select name, buseo, jikwi, rownum from tblinsa where rownum <= 5;
select name, buseo, jikwi, rownum from tblinsa where rownum <= 10;
select name, buseo, jikwi, rownum from tblinsa where rownum = 1 or rownum = 3;


-- 1이 포함안된 것
select name, buseo, jikwi, rownum from tblinsa where rownum = 5; --***
select name, buseo, jikwi, rownum from tblinsa where rownum >= 3 and rownum <= 6;
select name, buseo, jikwi, rownum from tblinsa where rownum >= 10 and rownum <= 20;


-- rownum은 from절이 실행 시 매겨진다.

select a.*, rownum 
    from (select name, buseo, jikwi, basicpay, rownum from tblinsa 
            order by basicpay desc) a
                    where rownum <= 5;

select a.*, rownum from
    (select * from tblinsa order by sudang desc) a
        where rownum <= 5;

select a.*, rownum from
    (select * from tblinsa order by sudang desc) a
        where rownum >= 5 and rownum <= 10;



-- rownum을 조건으로 마음대로 사용하려면 최소한 서브쿼리가 3번 중첩이 되어야 한다.
select b.*, rownum from
    (select a.*, rownum as rnum from
        (select * from tblinsa order by sudang desc) a) b
            where rnum >=1 and rnum <=10; --1페이지
    
select b.*, rownum from
    (select a.*, rownum as rnum from
        (select * from tblinsa order by sudang desc) a) b
            where rnum >=11 and rnum <=20; --2페이지
    
--tblcountry. 인구수가 가장 많은 나라 1~3위까지
select a.*, rownum from
    (select * from tblcountry where population is not null order by population desc) a
        where rownum <= 3;
        
--tblinsa. 남자 + 부서별 인원이 가장 많은 3부서
select * from
    (select a.*, rownum as rnum from
        (select buseo, count(*) from tblinsa
            where substr(ssn, 8, 1) = '1'
                group by buseo
                    order by count(*) desc) a) 
                        --where rnum <= 3;
                        where rnum = 5;



create table men
as
select name, weight from tblmen where weight is not null;




select name, weight, r1, rownum as r2 from
    AAA
            where rownum = 3;


select * from AAA where rownum <= 3;

select * from housekeeping;



select buseo, city, count(*) from tblinsa
    group by buseo, city;


select buseo||city, count(*), max(basicpay) from tblinsa
    group by buseo || city;

