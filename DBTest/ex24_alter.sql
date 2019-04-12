-- hr > ex24_alter.sql

/*

객체 생성 : CREATE
객체 삭제 : DROP
객체 수정 : ALTER

데이터 생성 : INSERT
데이터 삭제 : DELETE
데이터 수정 : UPDATE


테이블 수정하기, ALTER TABLE
- 테이블의 구조를 수정하기 > 컬럼의 정의를 수정한다.
- 최대한 테이블을 수정할 상황을 만들면 안된다.(****************************************)

1. 테이블 삭제 > 테이블 DDL(CREATE) 수정 > 수정된 DDL로 새롭게 테이블 생성
    - 기존에 데이터가 있다면 > 데이터 백업 > 테이블 삭제 > 테이블 생성 > 데이터 복구
    : 개발(공부)중에만 사용 가능, 서비스 운영 중에는 사용 불가능

2. ALTER 명령어 > 테이블의 구조 변경 + 기존 데이터 유지
    : 개발(공부)중에만 사용 가능, 서비스 운영 중에 사용 가능(쉽지는 않다.)


테이블 수정 > 컬럼 수정
1. 새로운 컬럼 추가하기 > 난이도 : 하 + 업무 강도 : 중,하
2. 기존 컬럼의 정의 수정하기(자료형, 길이, 제약 사항) > 난이도 : 중 + 업무 강도 : 중(기존 데이터)
3. 기존 컬럼 삭제하기 > 난이도 : 중 + 업무 강도 : 중

*/

create table tblEdit
(
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');


--1. 새로운 컬럼 추가하기
alter table tblEdit
    --add (추가될 컬럼의 정의);
    add (price number(5) null);

alter table tblEdit
    add (description varchar2(100) not null);

alter table tblEdit
    add (description varchar2(100) default '임시' not null); -- 추후 올바른 값으로 수정

-- null로 생성 > 올바른 값을 대입 > 다시 not null 수정



--2. 기존 컬럼의 정의 수정하기(자료형, 길이, 제약 사항)
insert into tblEdit values (4, '최신게임을 지원하는 게이밍 노트북', 10000, '좋아요');

--2.a 자료형의 크기를 늘리기
alter table tblEdit
    --modify (컬럼 정의);
    modify (data varchar2(100));
    
--2.b 자료형의 크기를 줄이기
-- : 기존 데이터가 수정하려는 크기보다 크면 > 에러 발생
alter table tblEdit
    modify (data varchar2(20));
    

--2.c not null > null
alter table tblEdit
    modify (description varchar2(100) null);

alter table tblEdit
    modify (description varchar2(100) not null);


--2.d 자료형 바꾸기 > 되도록 하지 말것(*****) > 만약 한다면 기존 데이터의 형태를 잘확인
alter table tblEdit
    modify (price varchar2(5));


--2.e 컬럼명 바꾸기 > 진짜 하지 말것!!!!!
alter table tblEdit
    rename column description to info; 



update tblEdit set price = null;

desc tblEdit;




--3. 컬럼 삭제하기
alter table tblEdit
    drop column info;

alter table tblEdit
    drop column seq; --PK : 절대 하지 말것!!!

select * from tblEdit;


---------------------------------------------------------------------

-- 제약 사항 추가하기
drop table tblEdit;

create table tblEdit
(
    seq number,
    name varchar2(30),
    color varchar2(30)    
);

alter table tblEdit
    --add (seq number primary key); --컬럼 수준
    add constraint tblEdit_seq_pk primary key(seq); --테이블 수준

alter table tblEdit
    add constraint tblEdit_color_ck check (color in ('red', 'yellow', 'blue'));

insert into tblEdit values (1, '빨강', 'red');
insert into tblEdit values (2, '노랑', 'black');

create table tblEdit2
(
    seq number primary key,
    data varchar2(30) not null,
    pseq number not null --FK
);

--00972. 00000 -  "identifier is too long"
--*Cause:    An identifier with more than 30 characters was specified.
--오라클은 객체 식별자 30자를 넘을 수 없다.
alter table tblEdit2
    add constraint tblParent_tblChildren_pseq_fk
        foreign key(pseq) references tblEdit(seq);

alter table tblEdit2
    drop constraint tblParent_tblChildren_pseq_fk;



/*

테이블의 모든 행 삭제하기
- 테이블 초기화(구조는 그대로 두고 데이터만 삭제)
- 개발 > 테스트 > 완료 > 초기화

1. DROP > CREATE
- 사용 빈도 꽤 있음
- 되돌리기 불가능(복구 불가능)
- 편법

2. DELETE
- 정석
- 초기화 용도 & 일반 업무 용도
- 되돌리기 가능(트랜잭션 사용)

3. TRUNCATE
- 테이블 초기화 명령어
- 정석
- 테이블의 모든 행을 삭제한다. > DELETE와 유사 + 되돌리기 불가능
- 자바 : list.clear();

*/
create table 영업부
as
select * from tblinsa where buseo = '영업부'; 

select * from 영업부;

delete from 영업부;--**
rollback;

truncate table 영업부;--**

































