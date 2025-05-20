-- 인덱스, 사용자 심화

-- 1. sqldb에서 usertbl 테이블에서 다음 내용 확인하기
USE sqldb;
-- 1) 내용 확인
SELECT * FROM usertbl;
-- 2) 인덱스 목록 확인
SHOW INDEX FROM usertbl;
-- 3) 데이터 크기와 인덱스의 크기 확인
SHOW TABLE STATUS LIKE 'usertbl';

-- 2. usertbl의 addr 컬럼에 대해 idx_usertbl_addr 이름으로 인덱스 만든 후 목록 확인
CREATE INDEX idx_usertbl_addr ON usertbl(addr);

SHOW INDEX FROM usertbl;

-- 3. usertbl의 상태를 출력하여 인덱스 내용 만들어졌는지 확인, 없다면 실제 적용되도록 한 후 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'usertbl'; -- Index_length가 0임을 확인

ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

-- 4. usertbl에 대해 다음을 처리
-- 1) birthYear 컬럼에 대해 idx_usertbl_birthYear 이름의 인덱스 만들기
CREATE INDEX idx_usertbl_birthYear ON usertbl(birthYear);
-- 2) name 컬럼에 대해 idx_usertbl_name 이름의 인덱스를 만들기
CREATE INDEX idx_usertbl_name ON usertbl(name);
-- 3) 생성된 인덱스의 목록을 확인
SHOW INDEX FROM usertbl;

-- 5. usertbl에 대해 다음을 처리
-- 1) name 컬럼에 대한 보조 인덱스를 삭제
DROP INDEX idx_usertbl_name ON usertbl;
-- 2) name과 birthYear 컬럼 조합으로 idx_usertbl_name_birthYear 이름의 인덱스를 생성
CREATE UNIQUE INDEX idx_usertbl_name_birthYear ON usertbl(name, birthYear);
-- 3) 인덱스 목록 확인
SHOW INDEX FROM usertbl;

-- 6. usertbl에서 앞에서 만든 인덱스 삭제
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
