-- ex03_datatype.sql

/*

ANSI-SQL 자료형
- DBMS에 따라 상이하게 다름(서로 호환이 안되는 경우가 많음)
- 오라클 자료형
- 오라클 자료형은 테이블의 컬럼을 정의하는데 사용한다.(변수 X)

1. 숫자형
    - 정수 + 실수
    a. NUMBER
        - (유효한)38자리 이하의 숫자를 표현
        - 20byte
        - NUMBER(precision, scale)
            1. precision : 소수 이하를 포함된 전체 자릿수(1 ~ 38자리)
            2. scale : 소수점 이하 자릿수
            ex) NUMBER : 38자리까지 표현 가능한 모든 숫자(정수,실수 포함)
                NUMBER(3) : 3자리까지 표현이 가능한 숫자(-999 ~ 999)
                NUMBER(4,2) : 4자리까지 표현이 가능한 숫자 + 소수이하 2자리까지 표현(-99.99 ~ 99.99)
                NUMBER(10,3) : -9999999.999 ~ 9999999.999
        - 숫자형 상수(리터럴) 표현법
            1. 정수 : 10
            2. 실수 : 3.14
                
    
2. 문자형
    - 문자형 + 문자열
    - 자바의 String : String name;
    a. CHAR
        - 고정 자릿수 문자열
        - char(n) : n(1 이상의 정수), n자리 문자열, n 바이트        
        - 최대 크기 : 2000 바이트
        - 최소 크기 : 1 바이트
        - ex) char(3) : 최대 3바이트까지 저장할 수 있는 자료형. 
        - ex) char(10) : 영어(1~10글자), 한글(1~3글자)
        
    b. NCHAR
        - N : National > 유니코드 지원 > UTF-16으로 동작
        - 모든 글자를 오라클 인코딩과 상관없이 2바이트로 저장한다.
        - ex) char(10) : 10바이트, 영어(10글자), 한글(3글자)
        - ex) nchar(10) : 10글자(=20바이트), 영어(10글자), 한글(10글자)
    
    c. VARCHAR2
        - 가변 자릿수 문자열
        - varchar2(n) : n(1 이상의 정수), n자리 문자열, n 바이트
        - 최대 크기 : 2000 바이트
        - 최소 크기 : 1 바이트
        - ex) varchar2(3) : 최대 3바이트까지 저장할 수 있는 자료형. 
        - ex) varchar2(10) : 영어(1~10글자), 한글(1~3글자)
        
    d. NVARCHAR2
        - 가변자릿수 + 유니코드 지원
        - ex) NVARCHAR2(10) : 문자(10글자) > 크기 줄어든다.

3. 날짜시간형
    - 자바의 Calendar
    a. DATE(***)
        - 년월일 시분초
        - 7byte
        - 최소단위 : 초
        
    b. TIMESTAMP
        - DATE 버전업
        - 나노초(10-e9)
    
    c. INTERVAL > NUMBER
        - 시간
        - 틱값

4. 대용량 자료형
    a. LOB(롭), Large Object
        1. BLOB
        2. CLOB

*/

-- 자료형 테스트 테이블

-- 테이블 = 컬럼의 집합 //구조 <- 정의
-- 테이블 = 레코드의 집합 //데이터 <- 사용

drop table tblType; --테이블 삭제

create table tblType
(
    -- 테이블을 구성할 컬럼 정의
    -- 컬럼명 자료형 제약사항
    --num number
    --num number(3)
    --num number(4,2)
    --name char(10)
    regdate date
);


-- 데이터 가져오기
select * from tblType;

-- 데이터 넣기
insert into tblType (num) values (30);


-- NUMBER 테스트
-- tblType.num NUMBER
select * from tblType;
insert into tblType (num) values (100); --정수
insert into tblType (num) values (3.14); --실수
insert into tblType (num) values (-100); --음수
insert into tblType (num) values (12345678901234567890123456789012345678);
insert into tblType (num) values (123456789012345678901234567890123456789);
insert into tblType (num) values (123456789012345678901234567890123456789012345);

--num number(3) : 자릿수를 지정했는데 scale이 지정이 안되면 정수 타입
select * from tblType;
insert into tblType (num) values (1);
insert into tblType (num) values (12);
insert into tblType (num) values (123);
insert into tblType (num) values (1234); --사용자가 키보드 입력한 숫자
insert into tblType (num) values (-999); --최댓값
insert into tblType (num) values (999); --최솟값
insert into tblType (num) values (3.14); --실수


--num number(4,2)
select * from tblType;
insert into tblType (num) values (1);
insert into tblType (num) values (12);
insert into tblType (num) values (123); -- 오버플로우
insert into tblType (num) values (99.99); --최댓값
insert into tblType (num) values (-99.99); --최솟값
insert into tblType (num) values (12.3456789); --반올림 됨.


--name char(10)
select * from tblType;
insert into tblType (name) values ('홍길동'); --문자 리터럴('')
insert into tblType (name) values ('홍길동님');
insert into tblType (name) values ('abc');
insert into tblType (name) values ('abcdefghij');
insert into tblType (name) values ('abcdefghijk');


--regdate date
select * from tblType;
insert into tblType (regdate) values ('2019-03-18'); --날짜시간 리터럴
insert into tblType (regdate) values (sysdate);

--자바에서 날짜를 상수 표기? 없음 > Calendar
--자바에서 숫자를 상수 표기? 10, 4.5
--자바에서 문자열 상수 표기? "홍길동"
--자바에서 문자 상수 표기? 'a'
