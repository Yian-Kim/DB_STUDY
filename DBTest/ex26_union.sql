-- hr > ex26_union.sql

/*

JOIN, 조인
- 테이블을 합치는 기술
- 횡, 가로
- 컬럼 합치기
- 분산되어 있는 정보(컬럼)를 하나의 결과셋에서 보고 싶을 때 사용

UNION, 유니온
- 테이블을 합치는 기술
- 종, 세로
- 레코드 합치기
- 분산되어 있는 데이터(레코드, 객체, 행)를 하나의 결과셋에서 보고 싶을 때 사용

*/

select * from tblmen;
select * from tblwomen;

-- 남,녀 모두를 보고싶습니다.
select * from tblmen 
union 
select * from tblwomen;


-- 회사. 부서별 게시판
create table tblUnion1 --영업부 게시판
(
    seq number primary key,
    subject varchar2(100) not null
);

create table tblUnion2 --총무부 게시판
(
    seq number primary key,
    subject varchar2(100) not null
);

create table tblUnion3 --기획부 게시판
(
    seq number primary key,
    subject varchar2(100) not null
);

--게시물
insert into tblUnion1 values (1, '영업부 게시판입니다.');
insert into tblUnion1 values (2, '영업부 게시판입니다.');
insert into tblUnion1 values (3, '영업부 게시판입니다.');

insert into tblUnion2 values (1, '총무부 게시판입니다.');
insert into tblUnion2 values (2, '총무부 게시판입니다.');
insert into tblUnion2 values (3, '총무부 게시판입니다.');
insert into tblUnion2 values (4, '총무부 게시판입니다.');

insert into tblUnion3 values (1, '기획부 게시판입니다.');
insert into tblUnion3 values (2, '기획부 게시판입니다.');

select * from tblUnion1;
select * from tblUnion2;
select * from tblUnion3;

-- 사장님 왈. 모든 게시물 보고싶다..
select * from tblUnion1
union
select * from tblUnion2
union
select * from tblUnion3;

--축구선수. 공격수, 수비수
create table 공격수
(
    이름 varchar2(30) primary key, --일반 특성
    키 number not null, --일반 특성
    몸무게 number not null, --일반 특성
    근력 number not null, --공격수 특징
    스피드 number not null --공격수 특징
);

create table 수비수
(
    이름 varchar2(30) primary key, --일반 특성
    키 number not null, --일반 특성
    몸무게 number not null, --일반 특성
    지구력 number not null --수비수 특징
);

insert into 공격수 values ('홍길동', 180, 80, 100, 90);
insert into 공격수 values ('아무개', 185, 82, 95, 85);
insert into 수비수 values ('하하하', 192, 90, 88);
insert into 수비수 values ('후후후', 188, 81, 95);

select * from 공격수;
select * from 수비수;

select * from 공격수
union
select a.*, rownum from 수비수 a;

select 이름, 몸무게, 키 from 공격수
union
select 이름, 몸무게, 키 from 수비수;


select 이름, 몸무게, 키, 근력, 스피드, 0 as 지구력 from 공격수
union
select 이름, 몸무게, 키, 0, 0, 지구력 from 수비수;



create table tblUnionA
(
    name varchar2(20) not null
);

create table tblUnionB
(
    name varchar2(20) not null
);

insert into tblUnionA values ('빨강');
insert into tblUnionA values ('파랑');
insert into tblUnionA values ('노랑');
insert into tblUnionA values ('검정');
insert into tblUnionA values ('하양');

insert into tblUnionB values ('주황');
insert into tblUnionB values ('초록');
insert into tblUnionB values ('빨강'); --**
insert into tblUnionB values ('남색');
insert into tblUnionB values ('검정'); --**


-- union
-- : 두 테이블을 합쳤을 때 중복되는 행을 자동으로 제거
select * from tblUnionA
union
select * from tblUnionB;

-- union all
-- : 두 테이블을 합쳤을 때 중복되는 행도 같이 가져오기
select * from tblUnionA
union all
select * from tblUnionB;

-- intersect
-- : 두 테이블을 합쳤을 때 중복되는 행만 가져오기
select * from tblUnionA
intersect
select * from tblUnionB;

-- minus
-- : 차집합
-- : A - B
select * from tblUnionA
minus
select * from tblUnionB;























