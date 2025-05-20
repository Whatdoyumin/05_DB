-- 인덱스, 사용자

USE sqldb;

-- 1. sqldb에 테이블 tbl1을 생성 후 자동 생성된 인덱스 목록 확인
CREATE TABLE tbl1 (
    a INT PRIMARY KEY,
    b INT,
    C INT
);

SHOW INDEX FROM tbl1;

-- 2. sqldb에 테이블 tbl2 생성 후 자동 생성된 인덱스 목록을 확인
CREATE TABLE tbl2(
    a INT PRIMARY KEY,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);

SHOW INDEX FROM tbl2;

-- 3. sqldb에 테이블 tbl3 생성 후 자동 생성된 인덱스 목록 확인
CREATE TABLE tbl3 (
    a INT UNIQUE,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);

SHOW INDEX FROM tbl3;

-- 4. sqldb에 테이블 tbl4 생성 후 자동 생성된 인덱스 목록 확인
CREATE TABLE tbl4 (
    a INT UNIQUE NOT NULL,
    b INT UNIQUE,
    c INT UNIQUE,
    d INT
);

SHOW INDEX FROM tbl4;

-- 5. sqldb에 테이블 tbl5 생성 후 자동 생성된 인덱스 목록 확인
CREATE TABLE tbl5 (
    a INT UNIQUE NOT NULL ,
    b INT UNIQUE ,
    c INT UNIQUE ,
    d INT PRIMARY KEY
);

SHOW INDEX FROM tbl5;

-- 6. testdb에 usertbl 생성
CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

DROP TABLE IF EXISTS usertbl;

CREATE TABLE usertbl (
    userId CHAR(8) NOT NULL  PRIMARY KEY ,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr NCHAR(2) NOT NULL
);

-- 7. usertbl에 데이터 추가

INSERT INTO usertbl VALUE ('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUE ('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUE ('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUE ('JYP', '조용필', 1950, '경기');
INSERT INTO usertbl VALUE ('S나', '성시경', 1979, '서울');

-- 8. ALTER를 사용하여 usertbl에 PRIMARY KEY 제약조건을 제거하고, name 컬럼에 pk_name이라는 제약조건명으로 기본키 설정
ALTER TABLE usertbl DROP PRIMARY KEY;

ALTER TABLE usertbl ADD CONSTRAINT pk_name PRIMARY KEY(name);

-- 9. usertbl의 내용을 출력하여, 새로운 클러스터형 인덱스 확인
SELECT * FROM usertbl;