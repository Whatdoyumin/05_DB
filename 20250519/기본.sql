-- 테이블 기본

-- 1. tabledb 데이터베이스를 생성, 만일 이미 존재한다면 삭제
DROP DATABASE tabledb;
CREATE DATABASE tabledb;
USE tabledb;

-- 2. 보기 컬럼을 가지는 usertbl 테이블 만들기
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate DATE NULL
);

-- 3. 보기 컬럼을 가지는 buytbl 테이블 만들기
DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl(
   num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userid CHAR(8) NOT NULL,
   prodName CHAR(6) NOT NULL,
   groupName CHAR(4) NULL,
   price INT NOT NULL,
   amount SMALLINT NOT NULL,
   FOREIGN KEY(userid) REFERENCES usertbl(userID)
);

-- 4. 회원 테이블에 다음 데이터 입력
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

-- 5. 구매 테이블에 다음 데이터 입력
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
-- 에러가 나는 이유: buytbl.userid는 usertbl.userID에 무조건 존재해야만 삽입이 가능한데, 현재는 존재하지 않기 때문이다.

-- 6. 보기 컬럼을 가지는 usertbl 정의
-- 1) 기존 usertbl이 존재하는 경우 삭제함
DROP TABLE IF EXISTS buytbl, usertbl;
-- 2) 기본키는 테이블 레벨에서 정의하고 제약조건명을 함께 지정함
CREATE TABLE usertbl(
    userID CHAR(8) NOT NULL,
    name VARCHAR(10) NOT NULL,
    birthyear INT NOT NULL,
    CONSTRAINT pk_usertbl_userid PRIMARY KEY (userId)
);

-- 7. 보기 컬럼을 가지는 prodTbl 정의 (기존 prodTbl이 존재하는 경우 삭제)
DROP TABLE IF EXISTS prodTbl;

CREATE TABLE prodTbl(
    prodCode CHAR(3) NOT NULL,
    prodID CHAR(4) NOT NULL,
    prodDate DATETIME NOT NULL,
    prodCur CHAR(10) NULL,
    CONSTRAINT PK_prodtbl_proCode_prodID
        PRIMARY KEY (prodCode, prodID)
);

-- 8. usertbl과 buytbl을 바탕으로 보기 결과가 나오는 뷰 정의
USE sqldb;

CREATE VIEW v_userbuytbl
AS
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM usertbl U
    JOIN buytbl B ON U.userID = B.userID;

-- 9. 위에서 정의한 뷰에서 userid가 '김범수'인 데이터만 출력
SELECT * FROM v_userbuytbl WHERE name='김범수';