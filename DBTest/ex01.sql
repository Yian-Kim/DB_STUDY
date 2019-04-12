D:\class\oracle\ex01.sql

오라클 11g xe 설치하기
1. OracleXE112_Win64.zip //오라클 서버, 오라클, 데이터베이스, DBMS, DB 서버 등
2. sqldeveloper-18.4.0-376.1900-x64.zip //오라클 클라이언트, SQL Developer, 클라이언트, 데이터베이스 클라이언트, DB 클라이언트, 클라이언트 툴(**)
3. eXERD : 모델링 툴

오라클, Oracle
- 회사명 & 제품명
- 데이터베이스, 데이터베이스 관리 시스템(DBMS), 관계형 데이터베이스 관리 시스템(RDBMS)
- 응용 프로그램(X) > 서비스 프로그램(O)
- Win+R > services.msc
  1. OracleServiceXE
    - 오라클 자체
    - 데이터베이스 서버 서비스
  2. OracleXETNS Listener
    - 클라이언트 요청 관리 서비스

오라클 서비스 시작/멈춤
  1. 바로가기 메뉴 사용
  2. services.msc 사용
  3. C:\oraclexe\app\oracle\product\11.2.0\server\bin
     a. StartDB.bat //배치 파일
     b. StopDB.bat
  4. 명령어 사용
     a. net start 서비스명 > net start OracleServiceXE
     b. net stop 서비스명 > net stop OracleServiceXE


데이터베이스 서버(관계형 데이터베이스)
1. Oracle
2. MS-SQL
	- MS
	- 개인용, 소호용, 기업용
3. MySQL
	- 개인용 > 기업용
	- 오라클 소유
4. MariaDB
	- MySQL 다른 버전
	- 무료
5. DB2
6. PostgreSQL
7. 티베로(티맥스 - 티베로, 제우스)


데이터베이스 클라이언트 툴
1. SQL Developer
	- 무료
	- Oracle
2. Toad(***)
3. Query Box
4. SQLGate
5. DataGrip(JetBrain) - 대학교 이메일(***@***.ac.kr)
6. SQL*Plus
	- 오라클 설치하면 자동으로 설치



접속 정보
1. 접속 이름
	- 맘대로
	- @서버주소/계정명
	- @211.63.89.100/hr
	- localhost(내컴퓨터)
		- 127.0.0.1
		- 루프백 주소, 핑 주소
		- C:\Windows\System32\drivers\etc\hosts
2. 사용자 이름
	- 접속할 계정명
		- 관리자 계정 : sys, system, sysdba
		- 사용자 계정 : scott(tiger), hr(lion)(human resources), 프로젝트계정
3. 비밀번호
	- 주기적으로 변경
4. 호스트 이름
	- localhost
	- 오라클 서버 주소
	- 도메인 주소, IP 주소
5. 포트
	- 1521(리스너 포트번호)
6. SID(서비스 이름)
	- Service ID
	- 오라클 서버 이름(별칭)
	- xe(Express Edition)
	- orcl1, orcl2, orcl3



C:\Users\sist00\AppData\Roaming\SQL Developer\system18.4.0.376.1900\o.sqldeveloper\product-preferences.xml
