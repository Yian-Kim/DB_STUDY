-- ex02.sql

-- 관리자로만 실행 가능
-- 잠겨있는 계정을 풀기
-- alter user 계정명 account unlock;
alter user hr account unlock;

-- 비밀번호 변경하기
-- alter user 계정명 identified by 비밀번호;
alter user hr identified by java1234;


-- 현재 계정이 소유하고 있는 테이블 목록 보기
select * from tabs; --system, hr

-- 주석
-- 단일라인 주석
/*
    다중라인 주석
*/

-- 현재 파일
-- - 워크 시트(SQL Developer)
-- - 범용 : SQL Script(명령어들을 모아놓은 파일), 스크립트 파일

-- 명령어 실행 방법
-- 1. 단일 라인 명령
-- - 명령어를 선택하고(블럭 잡고) 실행 : Ctrl + Enter
select * from tabs;
-- 2. 다중 라인 명령
-- - 1번을 여러개 동시에 실행
-- - 여러 라인을 선택하고 실행 : Ctrl + Enter;
select * from tabs;
select * from tabs;

-- 문장 종결자
-- ;(선택) > 생략하지 말 것



/*

SQL, Structured Query Language
- 구조화된 질의 언어
- 관계형 데이터베이스 시스템에서 서버와 대화할 수 있는 언어(명령어)

SQL의 종류
1. DDL
    - Data Definition Language
    - 데이터 정의어
    - 테이블, 객체, 사용자 등을 생성 및 수정 및 삭제
    a. create : 생성 
    b. drop : 삭제
    c. alter : 수정
    - 데이터베이스 관리자 or 담당자, 프로그래머(일부)

2. DML(****)
    - Data Manipulation Language
    - 데이터 조작어
    - 데이터베이스에 데이터 추가/삭제/수정/검색(읽기) 작업
    - 가장 많이 사용
    - 데이터 CRUD 작업
        a. select : 데이터 가져오기(R)
        b. insert : 데이터 추가하기(C)
        c. update : 데이터 수정하기(U)
        d. delete : 데이터 삭제하기(D)
    - 데이터베이스 관리자 및 담당자, 프로그래머(주업무)

3. DCL
    - Data Control Language
    - 데이터 제어어
    - 계정, 보안, 트랜잭션 등등 제어
        a. commit
        b. rollback
        c. grant
        d. revoke
    
4. DQL
    - Data Query Language
    - 데이터 질의어
    - DML 중 select만을 이렇게 부른다.
    
5. TCL
    - Transact Control Language
    - DCL 중 트랜잭션 관련 명령어만 이렇게 부른다.
    - commit, rollback



SQL의 종류
- 제품에 따른 구분
- 데이터베이스 만든 회사마다 SQL 문법이 다르다.
1. ANSI-SQL
    - 표준화된 SQL
    - DBMS 종류와 무관하게 공통으로 정해진 문법(SQL)
    - 70 ~ 80%
2. PL/SQL
    - Procedural Language for SQL
    - 오라클에서 별도로 만든 확장 SQL 문법
    - 오라클에서만 동작


오라클 기본 인코딩 환경
1. ~ 8i : EUC-KR
2. 9i ~ 현재 : UTF-8


자잘한 내용
- SQL은 대소문자를 구분하지 않는다.

*/
select * from tabs;
SELECT * FROM tabs;
SELECT * FROM TABS;

-- 대중화된 표기법(코드 인벤션 - 코드 작성하는 규칙 정리)
-- 1. 키워드 대문자
-- 2. 식별자 소문자
SELECT * FROM tabs;
