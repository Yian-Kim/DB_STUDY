-- hr > ex28_account.sql

/*

계정 SQL
- DCL
- 계정 생성(소멸)
- 리소스 접근 권한 제어


사용자 계정 생성하기
- 시스템 권한을 가지고 있는 계정만 가능하다.
    - 관리자만 가능
    - sys, system
    - 계정 생성 권한을 가지고 있는 일반 계정

*/

-- system으로 전환

-- CREATE USER 계정명 IDENTIFIED BY 암호 : 계정 생성
-- ALTER USER 계정명 IDNENTIFIED BY 암호 : 암호 변경
-- DROP USER 계정명 : 계정 삭제
create user hong identified by java1234;

-- 접속 테스트
-- 새로운 계정에게 접속 권한 부여하기
-- GRANT 권한 TO 유저명;
grant create session to hong; --접속 권한 부여



-- hong 변경
select * from tabs;

create table tblmyinfo
(
    seq number primary key,
    data varchar2(1000) not null
);



-- system 변경
grant create table to hong; --테이블 생성 권한
grant create view to hong; --뷰 생성 권한
grant resource to hong; --resource 여러 권한들을 하나의 패키지로 만들어 놓음(권한 집합 : Role)


-- hong 변경
create table tblmyinfo
(
    seq number primary key,
    data varchar2(1000) not null
);

/*

관리자 시스템 권한
1. create user : 계정 생성 권한
2. drop user : 계정 삭제 권한
3. drop any table : 소유주와 상관없이 모든 테이블 삭제 권한
..

사용자 시스템 권한
1. create session : DB 접속 권한
2. create table : 테이블 생성 권한
3. create view 
4. create seqeunce
5. create procedure

130 ~ 140여가지

grant 권한명 to 유저명;


역할, Role
- 사용자에게 여러개의 권한을 주기 위한 권한 그룹

1. connect
    - 사용자 DB 접속 + 기본 행동 포함
2. resource
    - 사용자 객체 생성 + 조작 행동 포함
3. dba
    - 관리자 권한

*/

--평범한 상황(프로젝트 계정 만들기) > system 계정
--1. 계정 생성
create user team identified by java1234;

--2. 권한 부여
grant connect, resource to team;

--3. 권한 뺏기
revoke resource from team;



































