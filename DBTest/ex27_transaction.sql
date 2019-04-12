-- hr > ex27_transaction.sql

/*

트랜잭션, Transaction
- 오라클(DMBS)에서 발생하는 1개 이상의 명령어들을 하나의 논리 집합으로 묶어 놓은 단위 > 제어
- 트랜잭션에 의해서 관리되는 명령어 : DML만 포함된다.(INSERT, UPDATE, DELETE) <- 데이터에 조작을 가하는 명령어

트랜잭션 관리(처리)
- DCL
1. COMMIT
2. ROLLBACK
3. SAVEPOINT

트랜잭션 기본 원칙
- 하나의 트랜잭션으로 묶여있는 모든 명령어 대상 > 오라클이 감시
    > 모든 명령어가 성공하면 트랜잭션 성공 or 일부 명령어가 실패하면 트랜잭션 실패


새 트랜잭션이 시작하는 경우
1. 클라이언트가 접속할 때
2. rollback을 실행했을 때
3. commit을 실행했을 때

트랜잭션이 종료되는 경우
1. commit을 실행했을 때 > 작업 결과를 DB에 반영함.
2. rollback을 실행했을 때 > 작업 결과를 DB에 반영 안함.
3. 클라이언트가 접속을 종료했을 때 > 클라이언트의 선택에 따라 commit or rollback
4. 클라이언트 툴 기능 > Auto Commit 지원 > DML 문장을 실행할 때마다 자동으로 commit 실행

*/

create table 기획부
as
select name, city, buseo, jikwi from tblinsa where buseo = '기획부';



-- 클라이언트 접속 > 트랜잭션 시작

delete from 기획부 where name = '홍길동';

select * from 기획부;

delete from 기획부 where name = '이영숙';

select * from 기획부;


-- 현시점 잘못 발견 > 되돌리기
rollback; -- 되돌리기 + 새 트랜잭션 시작

select * from 기획부;

delete from 기획부 where name = '홍길동';

select * from 기획부;

delete from 기획부 where name = '김말자';

select * from 기획부;

--현시점 > 문제가 없다고 판단 > 실제 DB에 반영
commit; -- 승인 + 새 트랜잭션 시작

select * from 기획부;

rollback; -- 새 트랜잭션 시작


delete from 기획부 where name = '이영숙';


-- 여태 했던 마지막 트랜잭션에서 뭘했는지 기억이 안나도
-- 새로운 작업을 시작하려면 일단 rollback이나 commit을 실행한 뒤 작업을 시작한다.
commit;

select * from 기획부;

delete from 기획부 where name = '김신제';

select * from 기획부;

rollback;



/*

자동 커밋, Auto Commit
- 오라클(DBMS)에서 지원
- 개발자(사용자)가 명시적으로 commit을 실행하지 않았는데 자동으로 commit이 되는 경우
- DDL, DCL을 실행하면 자동으로 commit이 된다.
    CREATE, DROP, ALTER, TRUCATE 등을 실행하면 commit이 포함된다.
    > 구조를 조작하는 명령어

*/

select * from 기획부;

delete from 기획부 where name = '김신제';

select * from 기획부;

create table tblTemp
(
    num number primary key
);

rollback;

select * from 기획부;



/*
1. COMMIT
2. ROLLBACK
3. SAVEPOINT
*/

select * from 기획부;

delete from 기획부 where name = '이영숙';

savepoint a;

delete from 기획부 where name = '지재환';

savepoint b;

delete from 기획부 where name = '이정석';

-- 현시점
rollback;
rollback to b;
rollback to a;

select * from 기획부;


delete from 기획부 where name = '지재환';


commit;


select * from 기획부;





























