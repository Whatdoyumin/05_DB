/* 사용자 계정 생성 + 권한 부여하기 */

-- scoula_db 데이터베이스(스키마) 생성
CREATE DATABASE scoula_db;


DROP USER IF EXISTS 'scoula'@'%';

-- 모든 호스트에서 접속 가능한 사용자 scoula 생성
CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';

-- scoula계정에 scoula_db 모든 권한 부여
GRANT ALL PRIVILEGES ON scoula_db.* TO 'scoula'@'%';

-- scoula 계정에 sqldb 모든 권한 부여
GRANT ALL PRIVILEGES ON sqldb.* TO 'scoula'@'%';

-- 권한 적용
FLUSH PRIVILEGES;



SELECT @@autocommit;

set autocommit = false;

SELECT @@autocommit;

USE sqldb;

SELECT * FROM buytbl;

START TRANSACTION;


DELETE FROM buytbl WHERE num = 1;
DELETE FROM buytbl WHERE num = 2;

SELECT * FROM BUYTBL;

ROLLBACK;

SELECT * FROM BUYTBL;