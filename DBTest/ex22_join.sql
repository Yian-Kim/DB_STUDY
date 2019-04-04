---- hr > ex22_join.sql

-- 조인, join + 테이블간의 관계(****)

-- 직원 + 담당 프로젝트 > 테이블 생성
drop table tblStaff;

create table tblStaff
(
    seq number primary key, --직원번호(PK)
    name varchar2(30) not null, --직원명
    salary number not null, --급여
    address varchar2(300) not null, --거주지
    projectname varchar2(100) null --이 직원이 담당하는 프로젝트명
);

insert into tblStaff (seq, name, salary, address, projectname)
    values (1, '홍길동', 250, '서울시', '홍콩 수출');
insert into tblStaff (seq, name, salary, address, projectname)
    values (2, '아무개', 230, '부산시', 'TV 광고');
insert into tblStaff (seq, name, salary, address, projectname)
    values (3, '하하하', 210, '서울시', '매출 분석');

-- 정책 : 직원 1명이 여러 프로젝트를 담당하는게 가능.
insert into tblStaff (seq, name, salary, address, projectname)
    values (4, '홍길동', 250, '서울시', '인사 처리');
insert into tblStaff (seq, name, salary, address, projectname)
    values (5, '홍길동', 250, '서울시', '자재 납품');

-- 관계형 데이터베이스(오라클)에서 1개의 셀안에는 분리될 수 없는 원자값이 들어있어야 한다.
update tblStaff set
    projectname = '홍콩 수출,인사 처리,자재 납품'
        where seq = 1;
        
delete from tblStaff where seq in (4, 5);

select * from tblStaff;



drop table tblStaff;
drop table tblProject;

--직원 테이블(부모 테이블)
create table tblStaff
(
    seq number primary key, --직원번호(PK)
    name varchar2(30) not null, --직원명
    salary number not null, --급여
    address varchar2(300) not null
);

--프로젝트 테이블(자식 테이블)
create table tblProject
(
    seq number primary key, --프로젝트 번호(PK)
    projectname varchar2(100) not null, --프로젝트 명
    --staffseq number not null --담당 직원 번호
    staffseq number not null references tblStaff(seq) --제약사항(Foreign Key) 
);

insert into tblStaff (seq, name, salary, address) values (1, '홍길동', 250, '서울시');
insert into tblStaff (seq, name, salary, address) values (2, '아무개', 230, '부산시');
insert into tblStaff (seq, name, salary, address) values (3, '하하하', 210, '서울시');

insert into tblProject (seq, projectname, staffseq) values (1, '홍콩 수출', 1); --홍길동
insert into tblProject (seq, projectname, staffseq) values (2, 'TV 광고', 2); --아무개
insert into tblProject (seq, projectname, staffseq) values (3, '매출 분석', 3); --하하하
insert into tblProject (seq, projectname, staffseq) values (4, '노조 협상', 1); --홍길동
insert into tblProject (seq, projectname, staffseq) values (5, '대리점 분양', 1); --홍길동

select * from tblStaff;
select * from tblProject;

-- 서로 관계를 맺고 있는 두 테이블간의..
-- tblStaff(기본 테이블, 부모 테이블)
-- tblProject(참조 테이블, 자식 테이블)

-- *** 관계를 맺고 있는 2개의 테이블의 데이터를 조작하면.. 생기는 일들..
-- 이 부분을 실수하면 > 데이터의 무결성(유효성)이 깨진다. > 데이터의 가치가 상실된다.
-- 1. 부모 테이블의 조작
--    a. 행 추가 : 아무 제약 없음
--    b. 행 수정 : 아무 제약 없음
--    c. 행 삭제 : 자식 테이블에 나를 참조하고 있는 행이 존재하는 체크
-- 2. 자식 테이블의 조작
--    a. 행 추가 : 참조하는 컬럼값이 부모 테이블 존재하는 값인지 체크(직원 번호)
--    b. 행 수정 : 참조하는 컬럼값이 부모 테이블 존재하는 값인지 체크(직원 번호)
--    c. 행 삭제 : 아무 제약 없음


-- 외래키(참조키), Foreign Key
-- 참조 관계에 있는 두 테이블간의 연결 고리 역할을 하는 컬럼(키)이 있다. 그 컬럼에게 항상
-- 유효한 값을 저장할 수 있도록 동작하는 제약 사항
-- 부모테이블(PK) <-> 자식테이블(FK)


select * from tblStaff; --3명
select * from tblProject; --5건

-- A. 신입 사원 입사 > 신규 프로젝트 담당
-- A.1 신입 사원 추가(O)
insert into tblStaff (seq, name, salary, address) values (4, '호호호', 200, '인천시');

-- A.2 신규 프로젝트 추가(O)
insert into tblProject (seq, projectname, staffseq) values (6, '자재 매입', 4); --호호호

-- A.3 신규 프로젝트 추가(O) > 잘못된 경우(!!!)
-- ORA-02291: integrity constraint (HR.SYS_C007129) violated - parent key not found
insert into tblProject (seq, projectname, staffseq) values (8, '고객 유치', 2);



-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제(O)
-- ORA-02292: integrity constraint (HR.SYS_C007129) violated - child record found
delete from tblStaff where name = '홍길동'; --비권장
delete from tblStaff where seq = 1; --권장(PK)


-- C.1 업무 인수 인계 > '홍길동' 프로젝트 > 다른 직원에게 위임
-- ORA-02291: integrity constraint (HR.SYS_C007129) violated - parent key not found
update tblProject set staffseq = 2 where staffseq = 1;

-- C.2 '홍길동' 퇴사
delete from tblStaff where seq = 1; --권장(PK)





-- 관계 맺은 테이블들
-- 고객 <-> 판매
-- 고객 테이블(부모)
create table tblCustomer
(
    seq number primary key, --고객번호(PK)
    name varchar2(30) not null, --고객명
    tel varchar2(15) not null, --연락처
    address varchar2(100) not null --주소
);

-- 판매 테이블(자식)
create table tblSales
(
    seq number primary key, --판매번호(PK)
    item varchar2(50) not null, --상품명
    qty number not null, --판매수량
    regdate date default sysdate not null, --판매날짜
    customerseq number not null references tblCustomer(seq) --고객번호(FK) 관계(***)
);

-- 관계 맺은 테이블 경우
-- 생성 : 부모 > 자식
-- 삭제 : 자식 > 부모

drop table tblCustomer;
drop table tblSales;



--비디오 판매점
--장르 테이블
create table tblGenre
(
    seq number primary key, --장르번호(PK)
    name varchar2(30) not null, --장르명
    price number not null, --대여 가격
    period number not null --대여 기간
);

--비디오 테이블
create table tblVideo
(
    seq number primary key, --비디오 번호(PK)
    name varchar2(100) not null, --제목
    qty number not null, --보유 수량
    company varchar2(50) null, --제작사
    director varchar2(50) null, --감독
    major varchar2(50) null, --주연배우
    genre number not null references tblGenre(seq) --장르번호
);

--회원 테이블
create table tblMember
(
    seq number primary key, --회원번호(PK)
    name varchar2(20) not null, --회원명
    grade number(1) not null, --회원등급(1,2,3)
    byear number(4) not null, --생년
    tel varchar2(15) not null, --연락처
    address varchar2(300) null, --주소
    money number not null --예치금
);

--대여 테이블
create table tblRent
(
    seq number primary key, --대여번호(PK)
    member number not null references tblMember(seq), --대여한 회원번호(FK)
    video number not null references tblVideo(seq), --대여한 비디오번호(FK)
    rentdate date default sysdate not null, --대여 날짜
    retdate date null, --반납 날짜
    remart varchar2(500) --비고
);

--시퀀스 객체
create sequence memberSeq;
create sequence genreSeq;
create sequence videoSeq;
create sequence rentSeq;


/*
조인, JOIN
- 2개(1개) 이상의 테이블의 내용을 한번에 가져와서 1개의 결과셋을 만드는 작업
- 분리되어 있는 2개 이상의 테이블을 1개로 만드는 작업(테이블 합치기)
- 단, 테이블간의 관계를 맺고 있어야만 한다.

조인의 종류(ANSI SQL)
1. 단순 조인, CROSS JOIN
2. 내부 조인, INNER JOIN
3. 외부 조인, OUTER JOIN
4. 셀프 조인, SELF JOIN
*/

-- 1. 단순 조인, CROSS JOIN
select * from tblCustomer; --부모, 3명
select * from tblSales; --자식, 9건

select * from tblCustomer cross join tblSales; -- ANSI 표현(표준) 
select * from tblCustomer, tblSales; -- Oracle 표현


/*
2. 내부 조인, INNER JOIN
- 단순 조인에서 유효한 레코드만 취하는 조인
- 부모 테이블의 PK와 자식 테이블의 FK가 동일한 레코드만 취하는 조인

SELECT 컬럼리스트 FROM 테이블A INNER JOIN 테이블B ON 테이블A.컬럼명 = 테이블B.컬럼명;

SELECT 컬럼리스트 FROM 테이블A 
        INNER JOIN 테이블B 
                ON 테이블A.컬럼명 = 테이블B.컬럼명;

*/
-- inner join의 결과 레코드 수도 미리 예측 가능하다. > 자식 테이블 레코드 수와 동일
-- 구매내역과 그 구매한 손님 정보를 같이 가져오시오.
select * from tblCustomer 
    inner join tblSales 
        on tblCustomer.seq = tblSales.customerseq;

select * from tblSales
    inner join tblCustomer 
        on tblSales.customerseq = tblCustomer.seq;

-- 00918. 00000 -  "column ambiguously defined"
select * from tblCustomer 
    inner join tblSales 
        on tblCustomer.seq = customerseq;

-- 일부 컬럼만 가져오기
select tblCustomer.name, tblSales.item, tblSales.qty from tblCustomer 
    inner join tblSales 
        on tblCustomer.seq = tblSales.customerseq;

select c.name, s.item, s.qty 
    from tblCustomer c inner join tblSales s
        on c.seq = s.customerseq;

select c.name, c.tel from tblCustomer c;
select tblCustomer.*, length(name) from tblCustomer;

select c.*, length(name) from tblCustomer c;



-- 데이터 백업 & 복구
-- 1. 스크립트 사용
--   a. create 문
--   b. insert 문(update + delete)
-- 2. 클라이언트 툴 사용
--   a. 백업 & 복구 기능




-- 2개 테이블 > 합쳐서 > 1개 결과셋 ?? 양쪽에 관련 있는 행들끼리 연결하려고

-- 표준 SQL
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.customerseq; -- 부모테이블(PK) = 자식테이블(FK)
        
-- 오라클
select * from tblCustomer c, tblSales s
    where c.seq = s.customerseq;

-- 조인 사용 시 반드시 관계있는 테이블끼만 묶자 > 반드시 부모-자식 테이블간에만 한다.
select * from tblCustomer;
select * from tblProject;

select * from tblCustomer c
    inner join tblProject p
        on c.seq = p.staffseq;


-- 노트(tblSales)를 사간 회원의 연락처(tblCustomer)?
-- 1. 서브쿼리
select * from tblSales
    where item = '노트';

select name, tel from tblCustomer
    where seq = (select customerseq from tblSales
                          where item = '노트');

-- 2. 조인
select c.name, c.tel from tblCustomer c
    inner join tblSales s
        on c.seq = s.customerseq
            where s.item = '노트';



-- 질의 > 2개 이상 테이블이 관계되었다.
-- a. 서브쿼리 : 결과셋이 1개의 테이블로부터
-- b. 조인 : 결과셋이 2개의 이상의 테이블로부터



-- 노트(tblSales)를 사간 회원의 연락처(tblCustomer) + 몇개(tblSales)?
-- 1. 서브쿼리
select * from tblSales
    where item = '노트';

select name, tel, qty from tblCustomer
    where seq = (select customerseq from tblSales
                          where item = '노트');

select name, tel, (select qty from tblSales where customerseq = tblCustomer.seq and item = '노트') from tblCustomer
    where seq = (select customerseq from tblSales
                          where item = '노트');


-- 2. 조인
select c.name, c.tel, s.qty from tblCustomer c
    inner join tblSales s
        on c.seq = s.customerseq
            where s.item = '노트';




select * from tblCustomer; --3명
select * from tblSales; --9건

--회원 1명 가입
insert into tblCustomer values (4, '호호호', '010-2937-8346', '서울시');

--평범한 내부조인
--** '호호호'가 없다.
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.customerseq;


select * from tblCustomer c, tblSales s;

-- 쇼핑몰의 구매 내역과 상관없이 모든 회원을 가져와라~~ + 단, 구매이력이 있다면 그것도 같이
/*
3. 외부 조인, OUTER JOIN
*/

-- 표준 SQL
select * from tblCustomer c 
    left outer join tblSales s
        on c.seq = s.customerseq;

-- 오라클
select * from tblCustomer c, tblSales s 
    where c.seq = s.customerseq(+);


select * from tblMen;
select * from tblWomen;

select m.name, w.name from tblMen m
    inner join tblWomen w
        on m.name = w.couple;

select m.name, w.name from tblMen m
    left outer join tblWomen w
        on m.name = w.couple;

select m.name, w.name from tblMen m
    right outer join tblWomen w
        on m.couple = w.name;



/*
4. 셀프 조인, SELF JOIN
- 1개의 테이블을 사용해 조인 + 내부, 외부 조인
- 자기가 자기를 참조하는 경우에 사용(빈도 낮음) > ex) 재귀 메소드
*/

-- 직원 테이블
create table tblSelf
(
    seq number primary key, --직원번호(PK)
    name varchar2(30) not null, --직원명
    department varchar2(30) null, --부서
    super number null references tblSelf(seq) --직속상사번호(FK)
);

insert into tblSelf values (1, '홍사장', null, null);

insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '이과장', '영업부', 2);
insert into tblSelf values (4, '정대리', '영업부', 3);
insert into tblSelf values (5, '최사원', '영업부', 4);

insert into tblSelf values (6, '박부장', '홍보부', 1);
insert into tblSelf values (7, '하과장', '홍보부', 6);

select * from tblSelf;

-- 직원 명단(tblSelf) + 상사 정보(tblSelf) 같이 가져오시오.
-- inner join 
select s2.name as 직원명, s2.department as 부서, s1.name as 상사명 from tblSelf s1 --상사 테이블(부모)
    inner join tblSelf s2 --직원 테이블(자식)
        on s1.seq = s2.super;

-- outer join
select s2.name as 직원명, s2.department as 부서, s1.name as 상사명 from tblSelf s1 --상사 테이블(부모)
    right outer join tblSelf s2 --직원 테이블(자식)
        on s1.seq = s2.super;


select e2.first_name as 직원, e1.first_name as 매니저 from employees e1 --PK 부모
    left outer join employees e2 --FK 자식
        on e1.employee_id = e2.manager_id
            order by e1.first_name asc;


--테이블 1개
--비디오가 뭐뭐?
select * from tblVideo;

--테이블 2개
--모든 비디오 정보(tblVideo) + 대여 가격 + 대여 기간(tblGenre)?
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre; --tblGenre(seq) = tblVideo(genre)


select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video;


--테이블 3개
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --A 관계 선
            inner join tblRent r
                on r.video = v.seq; --B 관계 선



select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --A 관계 선
            inner join tblRent r
                on r.video = v.seq
                    inner join tblMember m
                        on m.seq = r.member;


--테이블 4개
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --A 관계 선
            inner join tblRent r
                on r.video = v.seq --B 관계 선
                    inner join tblMember m
                        on m.seq = r.member; --C 관계 선

-- outer join(회원)
-- 대여기록의 유무와 상관없이 모든 회원 열람(대여 기록 같이 열람)
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --A 관계 선
            inner join tblRent r
                on r.video = v.seq --B 관계 선
                    right outer join tblMember m
                        on m.seq = r.member; --C 관계 선


--** 해당 쿼리가 뭘 질문하는지 문장을 만들기(******)

-- outer join(회원)
-- 대여기록의 유무와 상관없이 모든 비디오 열람(대여 기록 같이 열람)
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre --A 관계 선
            left outer join tblRent r
                on r.video = v.seq --B 관계 선
                    left outer join tblMember m
                        on m.seq = r.member; --C 관계 선

select * from tblVideo;



-- 점포 주인 : 대여 기록 출력 > 회원명, 비디오제목, 언제, 반납 유무('반납완료' or '미반납')

select
    m.name as 회원명,
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



/*

-- 서브쿼리 + 조인

01. tblInsa. 90년대생 남자 직원들의 평균 월급(basicpay)보다 더 많이 받는 80년대생 
    여직원들을 가져오시오.
02. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당 프로젝트명을 가져오시오.
03. tblVideo, tblRent, tblMember. '뽀뽀할까요'라는 비디오를 빌려간 회원의 이름은?
04. tblInsa. 평균 이상의 월급을 받는 직원들을 가져오시오.
05. tblStaff, tblProject. '노조 협상' 프로젝트를 담당한 직원의 월급은?
06. tblMember. 가장 나이가 많은 회원의 주소?(byear)
07. tblVideo, tblRent, tblMember. '털미네이터'를 빌려갔던 회원들의 이름은?
08. tblStaff, tblProject. '서울시'에 사는 직원을 제외한 나머지 직원들의
    이름, 월급, 담당 프로젝트명을 가져오시오.
09. tblCustomer, tblSales. 상품을 2개(qty) 이상 구매한 회원의 연락처, 이름
    , 구매상품명, 수량을 가져오시오.
10. tblVideo, tblGenre. 모든 비디오의 제목과 보유수량, 대여 가격을 가져오시오.
11. tblGenre, tblVideo, tblRent, tblMember. 2007년 2월에 대여된 구매내역을 가져오시오.
    회원명, 비디오명, 언제, 대여가격
12. tblGenre, tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.

*/






















