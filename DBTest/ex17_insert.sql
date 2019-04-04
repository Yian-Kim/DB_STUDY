-- hr > ex17_insert.sql

/*

insert 문
- 데이터를 테이블 추가한다.(레코드 단위)
- insert into 테이블명 (컬럼리스트) values (값리스트)
- insert 
    into 테이블명 (컬럼리스트) --테이블 구조
    values (값리스트) --구조에 따른 넣을 값

*/
drop table tblMemo;
create table tblMemo
(
    seq number primary key, --메모번호(PK)
    name varchar2(30) not null, --작성자
    memo varchar2(1000) not null, --메모 내용
    regdate date default sysdate not null, --작성날짜
    etc varchar2(500) default '비고없음' null, --비고
    page number null --작성 페이지 수
);

create sequence memoSeq; --메모 번호용 시퀀스 객체

--insert 패턴

--1. 표준 : 원본 테이블의 정의된 컬럼 순서대로 컬럼리스트와 값리스트를 표기하는 방법
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, '비고', 1);

--2.ORA-01841: (full) year must be between -4713 and +9999, and not be 0
-- 반드시 컬럼리스트의 순서와 값리스트의 순서는 일치해야 한다.
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', '비고', sysdate, 1);

--3. 원본 테이블의 컬럼순서와 insert 컬럼리스트의 순서는 아무 상관없다.
-- 컬럼리스트 순서와 값리스트의 순서만 일치하면 된다.
insert into tblMemo (seq, name, memo, etc, regdate, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', '비고', sysdate, 1);

--4. 00947. 00000 -  "not enough values"
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, '비고');

--5. 00913. 00000 -  "too many values"
insert into tblMemo (seq, name, memo, regdate, etc)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, '비고', 1);

--6. null 허용된 컬럼에 값 대입하기(etc, page)
-- null 허용됐지만 값을 넣은 경우 > 선택 사항 > 잘들어간다.
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, '비고', 1);

--6. null 허용된 컬럼에 값 대입하기(etc, page)
-- null을 일부러 넣고싶다. > 비워두고 싶다.
-- a. 명시적으로 비우기 > null 상수 대입
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, null, null);
-- b. 암시적으로 비우기 > null 컬럼이 default를 가지고 있다면 null이 아닌 기본값이들어간다.
insert into tblMemo (seq, name, memo, regdate)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate);
        
--7. null이 허용된 컬럼만 생략이 가능하다. not null 컬럼은 생략할 수 없다.
insert into tblMemo (seq, name)
        values (memoSeq.nextVal, '홍길동');

--7. not null 컬럼이라도 default가 걸려있으면 생략이 가능하다. > default가 대입되기 때문에
insert into tblMemo (seq, name, memo)
        values (memoSeq.nextVal, '홍길동', '메모입니다.');

--7. not null이 default 상태여도 null을 명시적으로 대입 불가능
insert into tblMemo (seq, name, memo, regdate)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', null);
        
--8. default(regdate, etc)
-- a. 사용자 값을 명시적으로 넣는 경우 > 사용자가 넣은 값이 대입된다.(default 동작 안함)
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', sysdate, '비고', 1);

-- b. 사용자 값을 넣기 싫음 > default 동작 > 컬럼 생략
insert into tblMemo (seq, name, memo, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', 1);

-- c. 사용자 값을 넣기 싫음 > default 동작 > default 키워드 사용
insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '홍길동', '메모입니다.', default, default, 1);



-- insert문
-- 1. 컬럼리스트(순서, 갯수) == 값리스트(순서, 갯수)
-- 2. 컬럼(값) 생략 가능 > null 컬럼, default 컬럼
-- 3. null 명시적 대입 > null 상수 대입
-- 4. default 명시적 대입 > default 상수 대입

-- insert 추가 내용
select * from tblMemo;

insert into tblMemo (seq, name, memo, regdate, etc, page)
        values (memoSeq.nextVal, '아무개', '내용입니다..', sysdate, '테스트', 5);

-- 컬럼 리스트를 생략할 수 있다.
-- 1. 원본 테이블 컬럼 순서대로 값을 대입해야 한다.(피곤;;;)
-- 2. null을 넣기 위해 컬럼(값)을 생략할 수 없다.
insert into tblMemo values (memoSeq.nextVal, '아무개', '내용입니다..', sysdate, '테스트', 5);
insert into tblMemo values (memoSeq.nextVal, '아무개', '내용입니다..', '테스트', sysdate, 5);
insert into tblMemo values (memoSeq.nextVal, '아무개', '내용입니다..', sysdate);
insert into tblMemo values (memoSeq.nextVal, '아무개', '내용입니다..', sysdate, null, null);




-- 요구사항] tblMemo > (복사) tblMemoCopy
drop table tblMemoCopy;

create table tblMemoCopy
(
    seq number primary key, --메모번호(PK)
    name varchar2(30) not null, --작성자
    memo varchar2(1000) not null, --메모 내용
    regdate date default sysdate not null, --작성날짜
    etc varchar2(500) default '비고없음' null, --비고
    page number null --작성 페이지 수
);

select * from tblMemo; -- select 11건
select * from tblMemoCopy; -- insert 11건

insert into tblMemoCopy select * from tblMemo where page is not null;
insert into tblMemoCopy select * from tblInsa; --X


-- 직원 60명
select * from tblinsa;

-- 장급(부장,과장) 테이블 만들어 주세요.
CREATE TABLE tblInsa1 (
        num NUMBER(5) NOT NULL CONSTRAINT tblInsa1_pk PRIMARY KEY
       ,name VARCHAR2(20) NOT NULL
       ,ssn  VARCHAR2(14) NOT NULL
       ,ibsaDate DATE     NOT NULL
       ,city  VARCHAR2(10)
       ,tel   VARCHAR2(15)
       ,buseo VARCHAR2(15) NOT NULL
       ,jikwi VARCHAR2(15) NOT NULL
       ,basicPay NUMBER(10) NOT NULL
       ,sudang NUMBER(10) NOT NULL
);

insert into tblInsa1
    select * from tblInsa where jikwi in ('부장', '과장');
select * from tblInsa1;

-- 사원급(대리,사원) 테이블 만들어 주세요.

create table tblInsa2
as
    select * from tblInsa where jikwi in ('대리', '사원');

select * from tblInsa2;

-- create table + insert select : 장급
-- : 테이블 별도 생성(제약 사항 생성)
-- : 업무용 O + 개발자 테스트용 O

-- create table select : 사원급
-- : 테이블 자동 생성
-- : 컬럼의 복사 > 제약 사항 복사가 안된다.
-- : 업무용 X + 개발자 테스트용 O

create table tblMemoClone
as
    select * from tblMemo;

select * from tblMemoCopy; --장급 : 제약사항O
select * from tblMemoClone; --사원급 : 제약사항X

insert into tblMemoCopy
    select * from tblMemo;

insert into tblMemoClone
    select * from tblMemo;

























