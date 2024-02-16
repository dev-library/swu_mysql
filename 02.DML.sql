/* 좌측의 SCHEMAS의 DATABASE는 더블클릭, 우클릭 등으로 지정가능하지만
cli에서는 use 스키마명; 으로 호출할수도 있습니다.; */

-- Workbench(윈도우)에서 수행가능한 구문은 거의 모두 CLI에서 수행가능합니다.
use sys;
use swudb;

/* DATABASE 정보 조회 */
show DATABASES;

-- 테이블 생성
CREATE TABLE user_tbl(
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- insert시 자동숫자배정
	user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일
    );

/* 특정 테이블은 원래 조회할 때 
SELECT * FROM 데이터베이스명.테이블명; 
형식으로 조회해야 합니다.
그러나 use 구문등을 이용해 데이터베이스를 지정한 경우는 DB명을 생략할 수 있습니다.*/
SELECT * FROM user_tbl;
		-- PRIMARY KEY가 걸린 컬럼에 AUTO_INCREMENT가 동시에 걸려있다면 null주면 자동숫자배정
INSERT INTO user_tbl VALUES(null, '김자바', 1987, '서울', 180, '2024-05-03');
INSERT INTO user_tbl VALUES(null, '이연희', 1992, '경기', 165, '2024-05-12');
INSERT INTO user_tbl VALUES(null, '박종현', 1990, '부산', 177, '2024-06-01');
INSERT INTO user_tbl
	(user_name, user_birth_year, user_address, user_height, entry_date)
	VALUES ('신영웅', 1995, '광주', 172, '2024-07-15');
    
-- WHERE 조건절을 이용해서 조회해보겠습니다.
-- 90년대 이후 출생자만 조회하기 : user_birth_year가 1989보다 큰 유저만 조회하기
SELECT * FROM user_tbl WHERE user_birth_year > 1989;
-- 키 175미만만 조회하는 구문을 작성해보세요.
SELECT * FROM user_tbl WHERE user_height < 175;
-- AND 혹은 OR을 이용해 조건을 두 개 이상 걸 수도 있습니다.
SELECT * FROM user_tbl WHERE user_num > 2 OR user_height < 178;

-- UPDATE FROM 테이블명 set 컬럼명1=대입값1, 컬럼명2=대입값2 ...;
-- 주의! WHERE을 걸지 않으면 해당 컬럼의 모든 값을 다 통일시켜버립니다.
UPDATE user_tbl SET user_address='서울';

-- WHERE절 + PK 없는 UPDATE 구문 실행 방지, 0대입시 안전모드 해제, 1대입시 안전모드 적용
SET sql_safe_updates=1;

SELECT * FROM user_tbl;

-- DROP TABLE은 테이블이 없는데 삭제명령을 내리면 에러 발생
DROP TABLE user_tbl;

-- 테이블이 존재하지 않는다면 삭제구문을 실행하지 않아 에러를 발생시키지 않음
DROP TABLE IF EXISTS user_tbl;

SELECT * FROM user_tbl;

-- 1번유저 김자바가 강원으로 이사를 갔습니다. 지역을 바꿔보세요.
UPDATE user_tbl SET user_address = '강원' WHERE user_num = 1;

-- 삭제는 특정 컬럼만 떼서 삭제할일이 없으므로 SELECT와는 달리 * 등을 쓰지 않습니다.
-- 박종현이 DB에서 삭제되는 상황을 구현해주세요. safety 모드를 끄고 user_name을 이용해주세요.
DELETE FROM user_tbl WHERE user_num = 3; -- user_name = '박종현';

-- 만약 WHERE절 없이 DELETE FROM 구문으로 삭제하면 truncate와 같이 테이블 구조는 유지하고 데이터만 삭제
DELETE FROM user_tbl;

-- 다중 INSERT 구문을 사용해보겠습니다.
/* INSERT INTO 테이블명 (컬럼1, 컬럼2, 컬럼3...)
		VALUES (값1, 값2, 값3 ...),
				(값4, 값5, 값6 ...),
                (값7, 값8, 값9 ...),
                ... */
INSERT INTO user_tbl
	VALUES (null, '강개발', 1994, '경남', 178, '2024-08-02'),
			(null, '최지선', 1998, '전북', 170, '2024-08-03'),
            (null, '류가연', 2000, '전남', 158, '2024-08-20');
SELECT * FROM user_tbl;

-- INSERT ~ SELECT 를 이용한 데이터 삽입을 위해 user_tbl과 동일한 테이블을 하나 더 만듭니다.
CREATE TABLE user_tbl2(
	user_num int(5) PRIMARY KEY AUTO_INCREMENT, -- insert시 자동숫자배정
	user_name varchar(10) NOT NULL,
    user_birth_year int NOT NULL,
    user_address char(5) NOT NULL,
    user_height int, -- 자리수 제한 없음
    entry_date date -- 회원가입일
    );

-- user_tbl2에 user_tbl의 자료 중 생년 1995년 이후인 사람 자료만 복사해서 삽입하기
INSERT INTO user_tbl2 
	(SELECT * FROM user_tbl WHERE user_birth_year > 1995);

SELECT * FROM user_tbl2;

-- 두 번째 테이블인 구매내역을 나타내는 buy_tbl을 생성해보겠습니다.
-- 어떤 유저가 무엇을 샀는지 저장하는 테이블입니다.
-- 어떤 유저는 반드시 user_tbl에 존재하는 유저만 추가할 수 있습니다.
CREATE TABLE buy_tbl (
	buy_num INT AUTO_INCREMENT PRIMARY KEY,
    user_num INT(5) NOT NULL,
    prod_name varchar(10) NOT NULL,
    prod_cate varchar(10) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL
    );

SELECT * FROM user_tbl;

-- 외래키 설정 없이 추가해보겠습니다.
INSERT INTO buy_tbl VALUES(null, 5, '아이패드', '전자기기', 100, 1);
INSERT INTO buy_tbl VALUES(null, 5, '애플펜슬', '전자기기', 15, 1);
INSERT INTO buy_tbl VALUES
	(null, 6, '트레이닝복', '의류', 10, 2),
    (null, 7, '안마의자', '의료기기', 400, 1),
    (null, 5, 'SQL책', '도서', 2, 1);

SELECT * FROM buy_tbl;
SELECT * FROM user_tbl;
-- 있지도 않은 99번 유저의 구매내역을 넣어보겠습니다.
INSERT INTO buy_tbl VALUES(null, 99, '핵미사일', '전략무기', 100000, 5);

-- 6번 구매내역을 삭제해주세요.
DELETE FROM buy_tbl WHERE buy_num = 6;

-- 이제 외래키 설정을 통해서, 있지 않은 유저는 등록될 수 없도록 처리하겠습니다.
-- buy_tbl의 user_num 컬럼에 들어갈 수 있는 값은, user_tbl의 user_num 컬럼에 존재하는 값으로 한정한다.
-- buy_tbl이 user_tbl을 참조하는 관계임.
			-- 참조하는 테이블	-- 제약조건이름부여			-- 어떤 컬럼을 참조
ALTER TABLE buy_tbl ADD CONSTRAINT fk_buy_tbl FOREIGN KEY (user_num)
				-- 원본테이블명(컬럼명)
	REFERENCES user_tbl(user_num);

-- 있지도 않은 99번 유저의 구매내역을 넣어보겠습니다.
INSERT INTO buy_tbl VALUES(null, 99, '핵미사일', '전략무기', 100000, 5);

SELECT * FROM user_tbl;
SELECT * FROM buy_tbl;

-- 만약 user_tbl에 있는 요소를 삭제하는 경우, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우는 참조 무결성 원칙에 위배되어 삭제가 되지 않습니다.
DELETE FROM user_tbl where user_num=5;

-- 임시테이블인 user_tbl2 를 조회해보겠습니다.
SELECT * FROM user_tbl2;

-- DELETE FROM을 이용해서 user_tbl2의 2024-08-15일 이후 가입자를 삭제해보세요.
-- UNIX 시간은 1970년 1월 1일 00시 00분 00초부터 얼마나 경과했는지로 시간을 따지므로
-- 시점이 뒤일수록 값이 더 큽니다.
DELETE FROM user_tbl2 WHERE entry_date > '2024-08-15';

-- DELETE FROM을 이용해서 2024년 08월 3일 가입한 유저만 정확하게 집어서 삭제해주세요.
DELETE FROM user_tbl2 WHERE entry_date = '2024-08-03';

SET sql_safe_updates=0;

-- DISTINCT 실습을 위해 데이터를 몇 개 집어넣습니다.
INSERT INTO user_tbl VALUES
	(null, '이자바', 1994, '서울', 178, '2024-09-01'),
    (null, '신디비', 1992, '경기', 164, '2024-09-01'),
    (null, '최다희', 1998, '경기', 158, '2024-09-01');

SELECT * FROM user_tbl;

-- DISTINCT는 특정 컬럼에 들어있는 데이터의 "종류"만 한 번씩 나열해 보여줍니다.
-- 교안을 보고 user_birth_year와 user_address에 들어있는 데이터의 종류를 DISTINCT를 이용해 조회해주세요.
SELECT DISTINCT user_birth_year FROM user_tbl;
SELECT DISTINCT user_address FROM user_tbl;

-- 컬럼 이름을 바꿔서 조회하고 싶다면, 컬럼명 AS 바꿀이름 형식을 따라주시면 됩니다.
-- user_name 컬럼을 '유저명' 이라는 이름으로 바꿔서 조회해보세요. 
SELECT user_name AS '유저명' FROM user_tbl;
