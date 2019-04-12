-- 상관 서브쿼리 > 컬럼 용도
select name, height, couple, (select height from tblWomen where name=a.couple) from tblMen a;

-- 일반 서브쿼리 > 컬럼 용도
select name, height, couple, (select height from tblWomen where name='장도연') from tblMen a;

-- 조건에 사용되는 값으로 
select * from tblMen where height >= (select height from tblMen where name = '무명씨');

-- 테이블로 사용 > 인라인 뷰
select * from (select * from tblMen where weight >= 80 );
    
select * from (select * from tblMen where weight >= 80
                union
                select * from tblWoMen where weight >= 80);



