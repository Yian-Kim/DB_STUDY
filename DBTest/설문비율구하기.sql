
select * from tblinsa;
drop table tblinsa3;
create table tblinsa3
as
select name, substr(ssn, 8, 1) as gender, buseo from tblinsa;


select * from tblinsa3;

select (select 문항질문 from 설문 where 번호=a.buseo),
    count(case
        when gender = 1 then 1
        else null
    end) / count(*) as 매우,
    count(case
        when gender = 2 then 1
        else null
    end) / count(*) as 아니다
from tblinsa3 a
    group by buseo;

