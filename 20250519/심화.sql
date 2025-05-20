-- 테이블, 뷰 심화

-- 1. 보기 컬럼을 가지는 userTBL과 buyTBL 정의 (기존에 테이블이 존재하면 삭제)
DROP TABLE IF EXISTS userTBL, buyTBL;

CREATE TABLE userTBL (
    userID CHAR(8) NOT NULL PRIMARY KEY ,
    name VARCHAR(10) NOT NULL ,
    birthyear INT NOT NULL
);

CREATE TABLE buyTBL (
    num INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    FOREIGN KEY(userID) REFERENCES usertbl(userID)
);

-- 2. 보기 조건 만족하는 userTBL 테이블 정의
-- 1) 기존 buyTBL, userTBL 삭제
DROP TABLE buyTBL, userTBL;

CREATE TABLE userTBL(
    userID CHAR(8) NOT NULL PRIMARY KEY ,
    name VARCHAR(10) NOT NULL ,
    birthyear INT NOT NULL,
    email CHAR(30) UNIQUE
);


-- 3. 보기 조건을 만족하는 userTBL 테이블 정의
-- 1) 기존 userTBL 삭제
DROP TABLE userTBL;

CREATE TABLE userTBL(
    userID CHAR(8) NOT NULL PRIMARY KEY ,
    name VARCHAR(10),
    birthyear INT CHECK(birthyear >= 1900 AND birthyear <= 2023),
    mobile CHAR(3) NOT NULL
);

-- 4. 보기 조건을 만족하는 userTBL 정의
-- 1) 기존 userTBL 삭제
DROP TABLE userTBL;

CREATE TABLE userTBL(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthyear INT NOT NULL DEFAULT -1,
    addr CHAR(2) NOT NULL DEFAULT '서울',
    mobile1 CHAR(3) NULL,
    mobi1e2 CHAR(8) NULL,
    height SMALLINT NULL DEFAULT 170,
    mDate DATE NULL
);

-- 5. 앞에서 만든 userTBL에 대해 보기 조건 처리
-- 1) mobile1 컬럼을 삭제
ALTER TABLE userTBL DROP COLUMN mobile1;
-- 2) name 컬럼명을 uName으로 변경
ALTER TABLE usertbl
    CHANGE COLUMN name uName VARCHAR(20) NULL;

-- 6. 보기 정보를 가지는 직원 정보를 출력하는 EMPLOYEES_INFO 뷰를 작성
USE employees;

CREATE VIEW EMPLOYEES_INFO AS
SELECT
    e.emp_no,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    t.title,
    t.from_date AS t_from,
    t.to_date AS t_to,
    s.salary,
    s.from_date AS s_from,
    s.to_date AS s_to
FROM employees e
         JOIN titles t ON e.emp_no = t.emp_no
         JOIN salaries s ON e.emp_no = s.emp_no;

-- 7. 위 뷰에서 재직자의 현재 정보만 출력
SELECT
    e.emp_no,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.gender,
    e.hire_date,
    t.title,
    t.from_date AS t_from,
    t.to_date AS t_to,
    s.salary,
    s.from_date AS s_from,
    s.to_date AS s_to
FROM employees e
         JOIN titles t ON e.emp_no = t.emp_no
         JOIN salaries s ON e.emp_no = s.emp_no
WHERE t.to_date = '9999-01-01'
  AND s.to_date = '9999-01-01';

-- 8. 보기 정보를 가지는 부서 정보를 출력하는 뷰를 작성
CREATE VIEW EMP_DEPT_INFO AS
SELECT
    de.emp_no,
    de.dept_no,
    d.dept_name,
    de.from_date,
    de.to_date
FROM dept_emp de
         JOIN departments d ON de.dept_no = d.dept_no;

-- 9. EMP_DEPT_INFO로 현재 재직자의 부서 정보를 출력
SELECT *
FROM EMP_DEPT_INFO
WHERE to_date = '9999-01-01';