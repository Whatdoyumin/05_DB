USE sqldb;

SELECT *
FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID
ORDER BY buytbl.userID;


-- 구매 이력이 없는 사용자만 출력하세요.
SELECT *
FROM buytbl b
	RIGHT OUTER JOIN usertbl u
		ON b.userID = u.userID
-- (X) WHERE b.userID = NULL
WHERE IFNULL(b.userID, TRUE)
ORDER BY b.userID; 


-- 주강사님 실습
SELECT IF (100>200, '참이다', '거짓이다'); -- 거짓이다



USE sqldb;
SELECT *
FROM usertbl
WHERE
	-- mobile1 = NULL; -- 조회 X
    IFNULL(mobile1, FALSE);
    
SELECT name,
	birthYear,
	CASE birthYear
		WHEN birthYear >= 1980 THEN '80년대생'
		WHEN birthYear >= 1970 THEN '70년대생'
		WHEN birthYear >= 1960 THEN '60년대생'
		ELSE '50년대생'
	END '몇년도생'
FROM usertbl;

-- GROUP_CONCAT(문자열 SEPARATOR ',')
SELECT 
	u.userID, 
	u.name,
	GROUP_CONCAT(b.prodName SEPARATOR ',') AS '상품목록'
FROM 
	usertbl u
LEFT OUTER JOIN 
	buytbl b ON u.userID = b.userID
GROUP BY 
	u.userID, u.name
ORDER BY 
	u.userID;

SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요'); -- 널이군요,100

SELECT NULLIF(100,100), IFNULL(200,100); -- NULL, 200

SELECT 
	CASE 10    
		WHEN 1 THEN '일'    
		WHEN 5 THEN '오'    
		WHEN 10 THEN '십'
		END AS 'CASE연습'; -- 십

SELECT CONCAT_WS('/', '2025', '01', '01');  -- 2025/01/01


-- 조인 실습
USE sqldb;

/* emptbl 테이블 생성 */
CREATE TABLE emptbl(
	emp CHAR(3),
	manager CHAR(3),
	empTel VARCHAR(8)
);


INSERT INTO empTbl VALUES('나사장', NULL, '0000');
INSERT INTO empTbl VALUES('김재무', '나사장', '2222');
INSERT INTO empTbl VALUES('김부장', '김재무', '2222-1');
INSERT INTO empTbl VALUES('이부장', '김재무', '2222-2');
INSERT INTO empTbl VALUES('우대리', '이부장', '2222-2-1');
INSERT INTO empTbl VALUES('지사원', '이부장', '2222-2-2');
INSERT INTO empTbl VALUES('이영업', '나사장', '1111');
INSERT INTO empTbl VALUES('한과장', '이영업', '1111-1');
INSERT INTO empTbl VALUES('최정보', '나사장', '3333');
INSERT INTO empTbl VALUES('윤차장', '최정보', '3333-1');
INSERT INTO empTbl VALUES('이주임', '윤차장', '3333-1-1');

COMMIT;


/* stdtbl, clubtbl, stdclubtbl 테이블 생성 */
USE sqldb;

CREATE TABLE stdtbl (
  stdName  VARCHAR(10) NOT NULL PRIMARY KEY,
  addr  CHAR(4) NOT NULL
);

CREATE TABLE clubtbl (
  clubName  VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo  CHAR(4) NOT NULL
);

CREATE TABLE stdclubtbl(
  num int AUTO_INCREMENT NOT NULL PRIMARY KEY,
  stdName  VARCHAR(10) NOT NULL,
  clubName  VARCHAR(10) NOT NULL,
  FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
  FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);

INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

COMMIT;



-- INNER JOIN 실습
SELECT *
FROM 
	buytbl
INNER JOIN 
	usertbl ON buytbl.userID = usertbl.userID
WHERE 
	buytbl.userID = 'JYP';
    

-- LEFT OUTER JOIN 실습
SELECT
    u.userID,
     u.name,
    GROUP_CONCAT(b.prodName SEPARATOR ',') AS '상품목록'
FROM
    usertbl u
LEFT OUTER JOIN
     buytbl b ON u.userID = b.userID
GROUP BY
    u.userID, u.name
ORDER BY
    u.userID;

-- ROUTER OUTER JOIN 실습
SELECT
    u.userID,
     u.name,
    GROUP_CONCAT(b.prodName SEPARATOR ',') AS '상품목록'
FROM
    usertbl u
RIGHT OUTER JOIN
     buytbl b ON u.userID = b.userID
GROUP BY
    u.userID, u.name
ORDER BY
    u.userID;
    
    
-- CROSS JOIN 실습
USE employees;

SELECT 
	COUNT(*) AS '데이터개수'
FROM 
	employeesCROSS 
JOIN 
	titles;
    
-- SELF JOIN 실습
USE sqldb;

SELECT
    A.emp AS '부하직원',
    B.emp AS '직속상관',
    B.empTel AS '직속상관연락처'
FROM
    empTbl A
INNER JOIN
    empTbl B ON A.manager = B.emp
WHERE
    A.emp = '우대리';
