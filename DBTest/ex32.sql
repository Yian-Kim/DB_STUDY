-- ex32.sql

-- 근태 테이블
create table tblDate
(
    seq number primary key,
    regdate date not null, --출퇴근 시각
    state varchar2(30) not null --근태 상태
);

insert into tblDate (seq, state, regdate) values (1, '정상', '2019-03-04');
insert into tblDate (seq, state, regdate) values (2, '정상', '2019-03-05');
insert into tblDate (seq, state, regdate) values (3, '지각', '2019-03-06'); --7일 결석
insert into tblDate (seq, state, regdate) values (4, '정상', '2019-03-08');
insert into tblDate (seq, state, regdate) values (5, '정상', '2019-03-11');
insert into tblDate (seq, state, regdate) values (6, '정상', '2019-03-12');
insert into tblDate (seq, state, regdate) values (7, '조퇴', '2019-03-13');
insert into tblDate (seq, state, regdate) values (8, '지각', '2019-03-14'); --15일 결석

select * from tblDate;

-- 근태 조회 > 한달 근태 기록 > 결석일(없음) + 휴일 > 빠진 날짜 메꾸기
-- 1. SQL
--      a. ANSI
--      b. PL/SQL
-- 2. 응용 프로그램(JAVA)

-- 1.b == 2 //프로그램을 짜서 처리하겠다. > 날짜 기준 루프


-- start with ~ connect by : 계층형 쿼리
select * from tblComputer;
select lpad(' ', level * 3) || name, level from tblComputer
    start with pseq is null
        connect by prior seq = pseq;


--이 쿼리를 베이스로 해서 여러 작업에 응용
select level from dual
    connect by level <= 5;


select sysdate + level from dual
    connect by level <= 15;


-- ** 잘 사용
create or replace view vwDate
as
select to_date('20190301', 'yyyymmdd') + level - 1 as regdate from dual
    connect by level <= (to_date('20190331', 'yyyymmdd') - to_date('20190301', 'yyyymmdd') + 1);


select to_date('20190315', 'yyyymmdd') - to_date('20190301', 'yyyymmdd') from dual;

select v.regdate, t.state from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            order by v.regdate asc;



select 

    v.regdate, 
    case
        when to_char(v.regdate, 'd') in ('7', '1') then '공휴일'
        else t.state
    end as "state"
    
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            order by v.regdate asc;




-- 공휴일 테이블
create table tblHoliday
(
    seq number primary key,
    regdate date not null,
    name varchar2(30) not null
);

insert into tblHoliday values (1, '2019-03-01', '삼일절');




select 

    v.regdate, 
    case
        when to_char(v.regdate, 'd') in ('7', '1') then '공휴일'
        when t.state is null and h.name is null then '결석'
        when t.state is null and h.name is not null then h.name
        else t.state
    end as "state"
    --h.name
    
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            left outer join tblHoliday h
                on v.regdate = h.regdate
                    order by v.regdate asc;

select level, lpad(' ', level * 3) || name from tblself
    start with seq = 1
         connect by super = prior seq;

select rownum, level from dual;

select sysdate + level from dual
    connect by level <= 5;









-- 3월 평일 수
select 
    --v.regdate,
    count(case
        when to_char(v.regdate, 'd') in ('7', '1') then null
        when h.name is not null then null
        else 1
    end) as "state"
    
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            left outer join tblHoliday h
                on v.regdate = h.regdate
                    order by v.regdate asc;


select 
    last,
    first,
    weight,
    case
        when weight > 80 then '뚱뚱'
        else '날씬'
    end as state
from tblComedian;

create view a
as
select name, population from tblcountry
    where population is not null
        order by population desc;


select name, population, rownum from a where rownum = 3;

create view b
as
select name, population, rownum as rnum from a;


select name, population, rnum, rownum from b where rnum = 3;



select tblcountry.*, name from tblcountry;
select * from (select a.*, name from tblcountry a) b;





















