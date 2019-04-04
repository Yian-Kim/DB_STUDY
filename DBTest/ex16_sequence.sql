-- hr > ex16_sequence.sql

/*

시퀀스, sequence
- DB Object 중 하나
- 식별자를 만드는데 주로 사용한다.(PK에 적용)
- 중복되지 않고 순차적으로 증가하는 숫자를 반환한다.

시퀀스 객체 조작하기
1. CREATE : 생성
2. ALTER : 수정
3. DROP : 삭제

시퀀스 객체 생성하기
- CREATE SEQUENCE 시퀀스명;

시퀀스 객체 사용방법
1. testSeq.nextVal //사용
2. testSeq.currVal

*/
create sequence testSeq;

select testSeq.nextVal from dual;


drop table tblMemo;

create table tblMemo
(
    seq number primary key, --PK
    name varchar2(20),
    memo varchar2(2000),
    regdate date
);

insert into tblMemo (seq, name, memo, regdate)
    values (testSeq.nextVal, '홍길동', '메모', sysdate);

select * from tblMemo; --37

select testSeq.nextVal from dual; --값을 사용하는데 쓰임 > stack.pop()
select testSeq.currVal from dual; --값을 단순하게 확인하는데 쓰임 > stack.peek()



-- 테이블 식별자(PK)
-- 1. 숫자
-- 2. 문자열
--  ex) 상품 테이블
--      1   마우스 3000
--      2   키보드 5000
--  ex) 상품 테이블
--      A001    마우스 3000
--      B002    키보드 5000

create sequence productSeq;

-- 상품 등록 과정 > 대(AA) + 중(VB) + 소(OP) 선택 과정 > 'AAVBOP001'
select 'AAVBOP' || ltrim(to_char(productSeq.nextVal, '000')) from dual;

--------------------------------------------------------------------- 끝

-- 시퀀스 내부 + 옵션
-- create sequence testSeq; --기본형(가장 많이 사용)
-- create sequence testSeq 옵션 옵션 옵션 옵션...;

--ORA-00955: name is already used by an existing object
drop sequence testSeq;
create sequence testSeq; --다시 1부터 시작
create sequence testSeq 
    increment by -1 --증감치 조절(양수/음수 모두 가능) specify the increment to be a non-zero value
    start with 20 --시작값(seed)
    maxvalue 30 --최댓값(넘으면 에러 발생)
    minvalue 10; --최솟값(넘으면 에러 발생)
    
drop sequence testSeq;
create sequence testSeq
    increment by 1
    start with 1
    maxvalue 40
    cycle --순환
    cache 20;
    
select testSeq.nextVal from dual;




drop sequence testSeq;
create sequence testSeq cache 20;
   
select testSeq.nextVal from dual; --51



























