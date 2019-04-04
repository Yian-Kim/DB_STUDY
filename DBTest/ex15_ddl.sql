-- hr > ex15_ddl.sql

/*

DML
- SELECT 문

DDL
- 데이터 정의어
- 객체를 생성, 수정, 삭제한다.
- 객체 : 테이블, 뷰, 인덱스, 트리거, 프로시저, 제약사항 등..
- CREATE, ALTER, DROP


테이블 생성하기 > 컬럼 구성하는 작업

CREATE TABLE 테이블명
(
    컬럼 정의,
    컬럼 정의,
    컬럼 정의,
    컬럼명 자료형(길이) NULL표기 제약사항
);

*/
create table tblType
(
    num number(3)
);


/*

컬럼명 자료형(길이) NULL표기 제약사항

제약 사항, Constraint
- 해당 컬럼에 들어갈 데이터(값)에 대한 조건(규제) 
    > 조건을 만족하지 못하면 데이터를 해당 컬럼에 넣지 못한다. > 유효성 검사
- 데이터베이스 무결성 보장(Integrity Contraint Rule - 무결성 제약 조건)


1. NOT NULL
- 반드시 값을 가져야 한다.(필수값)

*/
create table tblMemo
(
    seq number not null, --메모 번호 + 필수값(Required)
    name varchar2(20) null, --작성자 + 선택값(Optional)
    memo varchar2(2000) not null, --메모 내용 + 필수값
    regdate date null --작성 시각 + 선택값
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모 내용입니다.', sysdate);

-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO")
insert into tblMemo (seq, name, memo, regdate)
    values (2, '아무개', null, sysdate);
    
insert into tblMemo (seq, name, memo, regdate)
    values (null, '아무개', '하하하', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (3, null, '하하하', null);

select * from tblMemo;


/*

1. NOT NULL

2. PRIMARY KEY(PK), 기본키
- 키(컬럼)
- 가장 중요한(?) 컬럼 > 행과 행을 구분하는 역할(*******************************************)
- 객체(행, 레코드, 튜플) 식별자(******************)
- UNIQUE(유일) + NOT NULL(필수값)
- 테이블에는 반드시 PK가 존재해야 한다.(******)
- 보통 PK가 테이블에 1개 존재한다. > 가끔씩 PK가 2개 이상 만드는 경우가 있다.
    > 복합키(Composite Key)
*/

drop table tblMemo;

create table tblMemo
(
    seq number primary key, --PK(유일한 식별자)
    name varchar2(20) null,
    memo varchar2(2000) not null,
    regdate date null
);


-- ORA-00001: unique constraint (HR.SYS_C007031) violated
insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '아무개', '반갑습니다.', sysdate);
    

/*
3. UNIQUE
- 해당 컬럼값이 테이블에 동일한 값이 존재할 수 없게 만드는 역할
- 유일한 값 보장
- PK와 유사. NULL을 가질 수 있다.
- UNIQUE + NOT NULL = PRIMARY KEY
- UNIQUE가 걸린 컬럼을 식별자로 사용하지 말것!!(NULL이 있어서)

*/

drop table tblMemo;

create table tblMemo
(
    seq number primary key, --PK
    name varchar2(20) unique, --Unique
    memo varchar2(2000) not null,
    regdate date null
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemo (seq, name, memo, regdate)
    values (2, '홍길동', '메모입니다.', sysdate);
insert into tblMemo (seq, name, memo, regdate)
    values (2, '아무개', '메모입니다.', sysdate);
insert into tblMemo (seq, name, memo, regdate)
    values (3, null, '메모입니다.', sysdate);
insert into tblMemo (seq, name, memo, regdate)
    values (4, null, '메모입니다.', sysdate);

select * from tblMemo;


/*
1. NOT NULL
2. PRIMARY KEY
3. UNIQUE

4. CHECK
- 열거, 범위 비교를 통한 제약(사용자 정의형)
- WHERE절 만드는 것과 유사

*/
drop table tblMemo;

create table tblMemo
(
    seq number primary key, --PK
    --name varchar2(20) check (name = '홍길동' or name = '아무개' or name = '테스트'), --회원제 운영(홍길동, 아무개, 테스트)
    name varchar2(20) check (name in ('홍길동', '아무개', '테스트')),
    memo varchar2(2000) not null,
    regdate date check(not to_char(regdate, 'd') in (1, 7)), --토,일 작성금지!!!
    length number check(length between 20 and 100) --범위(20 ~ 100)
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemo (seq, name, memo, regdate)
    values (2, '호호호', '메모입니다.', sysdate);
    
insert into tblMemo (seq, name, memo, regdate, length)
    values (1, '홍길동', '메모입니다.', sysdate, 50);
insert into tblMemo (seq, name, memo, regdate, length)
    values (2, '홍길동', '메모입니다.', sysdate, 50);


/*
5. default
- 컬럼 기본값 지정
- 사용자가 컬럼값을 대입하지 않으면 미리 준비해 둔 기본값을 대신 대입
*/
drop table tblMemo;

create table tblMemo
(
    seq number primary key, --PK
    name varchar2(20) default '익명' null,
    memo varchar2(2000) not null,
    regdate date default sysdate
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemo (seq, memo, regdate)
    values (2, '메모입니다.', sysdate);
    
insert into tblMemo (seq, memo)
    values (1, '메모입니다.');

select * from tblMemo;


/*

제약 사항을 만드는 방법

1. 컬럼 수준에서 만드는 방법(여태 수업했던 방식)
    - 컬럼 1개를 정의할 때 제약을 같이 정의하는 방식
    - seq number primary key
    - 컬럼명 자료형(길이) [constraint 제약명] 제약조건

2. 테이블 수준에서 만드는 방법
    - 컬럼 정의할 때 제약을 정의하지 않고, 나중에 추가로 정의하는 방식
    - seq number 
    - primary key
    - constraint 제약명 제약조건

*/

drop table tblMemo;

create table tblMemo
(
    --seq number primary key, --컬럼 수준 정의(생략 버전)
    --seq number constraint aaa primary key, --컬럼 수준 정의(원본) aaa : 제약 사항명
    --seq number constraint tblMemo_seq_pk primary key, --권장 표현(****) : 프로젝트 때 사용
    seq number,
    name varchar2(20),
    memo varchar2(2000),
    regdate date,
    
    constraint tblMemo_seq_pk primary key(seq),                     --테이블 수준의 제약 정의
    constraint tblMemo_name_ck check(name in ('홍길동', '아무개')),
    constraint tblMemo_regdate_ck check(to_char(regdate, 'mm') = '03') 
);

select * from tblMemo;

--ORA-00001: unique constraint (HR.SYS_C007051) violated
--ORA-00001: unique constraint (HR.AAA) violated
--ORA-00001: unique constraint (HR.TBLMEMO_SEQ_PK) violated
insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);

update tblMemo set name = '아무개' where seq = 1;
update tblMemo set name = '유재석' where seq = 1;














