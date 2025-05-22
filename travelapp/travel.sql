SELECT * FROM travel3;

-- travel.csv 파일을 DB에 임포트하기 위한 테이블 준비
DROP TABLE IF EXISTS tbl_travel;
CREATE TABLE tbl_travel
(
    no INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    district VARCHAR(50) NOT NULL,
    title VARCHAR(512) NOT NULL,
    description TEXT,
    address VARCHAR(512),
    phone VARCHAR(256)
);

select * from tbl_travel;

-- travel_image를 저장할 테이블 준비
DROP TABLE IF EXISTS tbl_travel_image;
CREATE TABLE tbl_travel_image
(
    no INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    filename VARCHAR(512) NOT NULL,
    travel_no INT,
    CONSTRAINT FOREIGN KEY (travel_no) REFERENCES tbl_travel (no)
        ON DELETE CASCADE
);

select * from tbl_travel_image;