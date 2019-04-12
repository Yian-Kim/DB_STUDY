-- hr > ex23_view.sql

/*

뷰, View
- DB Object 중 하나(테이블, 시퀀스, 제약사항, 뷰)
- 가상 테이블
- 테이블의 복사본 > 뷰, 뷰 테이블, 가상 테이블, 복사 테이블 등..
- 테이블처럼 취급한다.(***)
- 답 : SELECT 쿼리를 저장하는 객체하는 객체입니다.

결론
1. 뷰는 읽기 전용 테이블이다.
2. CUD는 가능해도 하지마라. > CUD는 원본 테이블을 대상으로 직접 실행해라.

*/

-- 뷰 생성
create view vwInsa
as
select * from tblInsa; 

-- 복사 테이블(제약사항X)
create table tblCopy
as
select * from tblInsa;

select * from tblCopy; --복사 테이블
select * from vwInsa; --위와 동일. 재사용
select * from (select * from tblInsa); --1회용

update tblInsa set city = '제주'; --원본 테이블
    
commit;



-- 업무 > 직원 정보 열람 > (영업부,기획부) + 남자직원 > 하루 100회 * 1년 내내
select * from tblinsa
    where buseo in ('영업부', '기획부') and substr(ssn, 8, 1) = '1';


create view 자주쓰는업무
as
select * from tblinsa
    where buseo in ('영업부', '기획부') and substr(ssn, 8, 1) = '1';


select * from 자주쓰는업무;

/*

뷰의 특징
1. 자주 반복하는 쿼리를 간단하게 줄일 수 있다. > 네이밍(***)
2. 원본 테이블 복사본(X) > 쿼리 자체를 저장하기 때문에 항상 원본 테이블 데이터를 가져온다.
3. 원본 테이블 자체가 부담이 되면 일부 서브셋을 만들어서 사용하는데 그 때 뷰를 사용한다.
4. 정리
    a. 자주 반복되는 쿼리 저장
    b. 반복과 상관없이 쿼리에 의미를 부여하고 가독성을 높히고자 할 때
    c. 보안 : 권한 제어

*/

select * from tblinsa; --그룹 전체 정보(사장, 관리급)

create view 긴급연락망
as
select name, tel from tblinsa;

select * from 긴급연락망;




create or replace view vwRent
as
select
    m.name as 회원명,
    m.tel as 연락처,
    v.name as 비디오제목,
    to_char(r.rentdate, 'yyyy-mm-dd') as 대여일,
    r.retdate as 반납일,
    case
        when r.retdate is not null then '반납 완료'
        when r.retdate is null then '미반납'
    end as 반납유무,
    g.name,
    g.period,
    g.price,
    case
        when r.retdate is null then round(sysdate - r.rentdate + g.period)
        when r.retdate is not null then 0
    end as 연체기간,
    case
        when r.retdate is null then round(sysdate - r.rentdate + g.period) * (g.price * 0.05)
        when r.retdate is not null then 0
    end as 연체료
        from tblMember m
            inner join tblRent r
                on m.seq = r.member
                    inner join tblVideo v
                        on v.seq = r.video
                            inner join tblGenre g
                                on g.seq = v.genre;





select * from vwRent;




/*

뷰의 사용 방법
1. C(쓰기) > 절대 금지
2. R(읽기) > 뷰는 읽기 전용으로 사용한다.
3. U(수정) > 절대 금지
4. D(삭제) > 절대 금지

*/
create or replace view vwTodo
as
select title, adddate from tbltodo where completedate is not null;

-- 2. R > O
select * from vwTodo;
-- 1. C > O
insert into vwTodo (seq, title, adddate, completedate) values (50, '뷰 테스트', sysdate, null);
-- 3. U > O
update vwTodo set title = 'View Test' where seq = 50;
-- 4. D > O
delete from vwTodo where seq = 50;







/*

뷰의 종류
1. 단순 뷰
- 하나의 기본 테이블에 의해 만들어진 뷰
- CRUD 가능

2. 복합 뷰
- 두개 이상의 기본 테이블에 의해 만들어진 뷰(서브쿼리, 조인 사용)
- R 가능

*/

create view vwVideo
as
select v.name as vname, g.name as gname from tblVideo v
    inner join tblGenre g
        on g.seq = v.genre;

select * from vwVideo; --R
insert into vwVideo (vname, gname) values ('캡틴 마블', 'SF'); --C
























