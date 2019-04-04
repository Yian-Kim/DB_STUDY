-- hr > ex18_update.sql

/*

UPDATE 문
- DML(INSERT, UPDATE, DELETE)
- 원하는 행의 원하는 컬럼을 (셀값) 수정하는 명령어
- UPDATE 테이블명 SET 컬럼명 = 수정할값 [, 컬럼명 = 수정할값] x n회 [WHRER 절]
- WHERE을 명시안하면 모든 행을 수정한다.(*******************)

*/
commit; --작업 승인(Save)
rollback; --작업 취소(되돌리기, Ctrl + Z)

select * from tblcountry;

-- 중국의 수도가 변경 > 청도
update tblcountry set capital = '청도';
update tblcountry set capital = '청도' where name = '중국';
update tblcountry set capital = '청도' where name = '프랑스';

select * from tblinsa;

-- 연봉 협상 > 1.1배 인상
update tblinsa set basicpay = basicpay * 1.1; --2610000 > 2871000
-- 부장 > 수당 x 2배 인상
update tblinsa set sudang = sudang * 2 where jikwi = '부장'; --200000


select * from tbltodo;

-- 16. 과제 제출하기 > 지금 완료 : 빈칸(셀)을 채우는 작업은 UPDATE
update tbltodo set
    completedate = sysdate
        --where title = '과제 제출하기'; --유일한 1개의 할일을 찾아야 한다.(PK 조건으로 건다.***)
        where seq = 16;

update tbltodo set
    completedate = null
        where seq = 16;

update tbltodo set
    adddate = null
        where seq = 16;

update tbltodo set
    seq = 100
        where seq = 16; --절대 금지!!!!!!!!!!!!!!!!!!!!!!!!!(PK는 수정하지 않는다.)











































