select * from tabs;

select * from TBLATTENDANCE; --근태
select * from TBLSTUDENT; --학생
select * from TBLSTUDENTINFO; --학생명
select * from TBLSUBJECT; --과목


-- 과목 기간 + 학생 리스트 + 근태 누적 결과
select 
    si.name,
    s.seq,
    (select count(*) from TBLATTENDANCE
        where studentseq = s.seq ) as "지각"
from TBLSTUDENT s
    inner join TBLSTUDENTINFO si
        on si.seq = s.studentinfoseq;



select 
    to_char(attendancedate, 'yyyy-mm-dd'),
    (select * from 
            (select a.*, rownum as rnum from 
                    (select to_char(attendancedate, 'yyyy-mm-dd hh24:mi:ss') 
                        from TBLATTENDANCE 
                                where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd')
                                        order by attendancedate asc) a)
                                                where rnum = 1) as 출근
from TBLATTENDANCE p
    where studentseq = 21
        group by to_char(attendancedate, 'yyyy-mm-dd')
            order by to_char(attendancedate, 'yyyy-mm-dd') asc;




select 
    to_char(attendancedate, 'yyyy-mm-dd'),
    to_char((
        select min(attendancedate) from TBLATTENDANCE
            where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
    ), 'yyyy-mm-dd hh24:mi:ss') as 출근,
    to_char((
        select max(attendancedate) from TBLATTENDANCE
            where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
    ), 'yyyy-mm-dd hh24:mi:ss') as 퇴근,
    case
        when 
            (
                select min(attendancedate) from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            )
            >
            to_date((
                select to_char(min(attendancedate), 'yyyy-mm-dd') from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            ) || '09:00:00', 'yyyy-mm-dd hh24:mi:ss')
        then 1
        else 0
    end as 지각,
    case
        when 
            (
                select max(attendancedate) from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            )
            <
            to_date((
                select to_char(max(attendancedate), 'yyyy-mm-dd') from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            ) || '18:00:00', 'yyyy-mm-dd hh24:mi:ss')
        then 1
        else 0
    end as 조퇴
from TBLATTENDANCE p
    where studentseq = 9
        group by to_char(attendancedate, 'yyyy-mm-dd')
            order by to_char(attendancedate, 'yyyy-mm-dd') asc;







select 
    to_char(attendancedate, 'yyyy-mm-dd'),
    to_char((
        select min(attendancedate) from TBLATTENDANCE
            where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
    ), 'yyyy-mm-dd hh24:mi:ss') as 출근,
    to_char((
        select max(attendancedate) from TBLATTENDANCE
            where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
    ), 'yyyy-mm-dd hh24:mi:ss') as 퇴근,
    
    
    case
        when 
            (
                select min(attendancedate) from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            )
            >
            to_date((
                select to_char(min(attendancedate), 'yyyy-mm-dd') from TBLATTENDANCE
                    where to_char(attendancedate, 'yyyy-mm-dd') =  to_char(p.attendancedate, 'yyyy-mm-dd') and  studentseq = 9
            ) || '09:00:00', 'yyyy-mm-dd hh24:mi:ss')
        then 1
        else 0
    end as 지각
    
    
    
from TBLATTENDANCE p
    where studentseq = 9
        group by to_char(attendancedate, 'yyyy-mm-dd')
            order by to_char(attendancedate, 'yyyy-mm-dd') asc;
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
