-- hr > ex08_column.sql

/*

distinct
- 컬럼 리스트에서 사용
- 결과 테이블의 컬럼을 만드는 역할
- distinct 컬럼명
- 중복값을 제거한다.
- null도 데이터의 한 종류로 인식한다. -> null도 여러개면 중복값이 제거된다.

*/

-- tblcountry 테이블에는 어떤 대륙이 있습니까?
select distinct continent from tblcountry;

-- 당신네 회사에는 어떤 부서가 있습니까?
select distinct buseo from tblinsa;

select distinct name from tblcountry;
select distinct population from tblcountry;

select distinct tel from tblinsa; --60명, 3명


select city, buseo from tblinsa;
select distinct city, buseo from tblinsa;
select distinct buseo, jikwi from tblinsa order by buseo;



/*

case
- 컬럼 리스트에서 사용
- 조건절에서 사용
- 자바에서 if문 & switch문

*/

-- m(남자), f(여자)
select last || first as name, gender from tblcomedian;
select last || first as name, case when gender = 'm' then '남자' when gender = 'f' then '여자' end from tblcomedian;

select 
    last || first as name, 
    case 
        when gender = 'm' then '남자' 
        when gender = 'f' then '여자' 
    end as gender
from tblcomedian;

--조건을 만족하지 못하는 컬럼값이면 null 반환(****)
select name, 
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        --else '기타'
        --else continent
        --else capital --하면 안되는 행동
        --else population --할 수 없는 행동
    end
from tblcountry;


select last || first as name,
    case
        when weight > 100 then '과체중'
        when weight > 50 then '정상체중'
        when weight > 0 then '저체중'
    end as state
from tblcomedian;

select * from tbltodo;

select title,
    case
        when completedate is not null then '완료한 일'
        when completedate is null then '해야할 일'
    end as state
from tbltodo;


select * from tblmen;
select * from tblwomen;


-- 솔로인 남자만 가져오기
select * from tblmen where couple is null;

-- 여자친구 있음 or 여자친구 없음
select name,
    case
        when couple is null then '여자친구 없음'
        when couple is not null then '여자친구 있음'
    end
from tblmen;


-- 보너스 추가 지급(직위별 차등 지급)
select name, buseo, jikwi, sudang, 
    case
        when jikwi = '부장' then sudang * 1
        when jikwi = '과장' then sudang * 0.7
        when jikwi = '대리' then sudang * 0.4
        when jikwi = '사원' then 0
    end as 추가수당
from tblinsa;




















