-- hr > ex19_delete.sql

/*

DELETE 문
- DML
- (행) 데이터를 삭제하는 명령어
- 특정 셀안의 값을 삭제하고 싶다 ? > update 컬럼 = null
- DELETE [FROM] 테이블명 [WHERE 절]

*/
commit;
rollback;

select * from tblinsa;
delete from tblinsa where jikwi = '부장';
delete from tblinsa;
































