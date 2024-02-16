/* 실행은 ctrl + enter
데이터베이스 생성 명령
데이터베이스 내부에 테이블들이 적재되기 때문에 먼저
데이터베이스를 생성해야 합니다.
DEFAULT CHARACTER SET UTF8; 을 붙여주시면 한글설정이 됩니다.
SQL은 대소문자 구분을 기본적으로 하지 않으나 내가 지정하는 이름 등을 제외한 쿼리문은 대문자로 작성합니다. */
CREATE DATABASE swudb DEFAULT CHARACTER SET UTF8;

/* 데이베이스 조회는 좌측 하단 중간쯤의 Schemas를 클릭하고 -> 새로고침 한 다음
방금 만든 스키마(데이터베이스)가 생성된게 확인되면 우클릭 -> set as default schemas
선택시 볼드처리되고(혹은 더블클릭해도 됨), 지금부터 적는 쿼리문이 해당 DB로 전달된다는 의미임 */
/* 해당 DB에 접근할 수 있는 사용자 계정 생성
USER - id역할, IDENTIFIED BY - pw역할 */
CREATE USER 'adminid' IDENTIFIED BY '20240215';

/* 사용자에게 권한 부여 : GRANT 주고싶은기능1, 기능2...
만약 모든 권한을 주고 싶다면 ALL PRIVELEGES(모든권한)
TO 부여받을 계정명 */
-- swudb라는 데이터베이스에 대한 모든 권한을 adminid 라는 계정에 부여하겠다
GRANT ALL PRIVILEGES ON swudb.* TO 'adminid';

/* 테이블 생성 명령
PRIMARY KEY : 컬럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸함
모든 테이블의 컬럼 중 하나는 반드시 PK속성이 부여되어 있어야 함.
NOT NULL : 해당 컬럼을 비워둘 수 없다는 의미
UNIQUE : 중복 데이터가 입력되는것을 방지함 */
CREATE TABLE users(
	u_number INT(3) PRIMARY KEY,
    u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);

/* 데이터 적재
INSERT INTO 테이블명(컬럼1, 컬럼2...) VALUE(s) (값1, 값2....);
만약 모든 컬럼에 값을 넣는다면 위 구문에서 테이블명 다음 오는 컬럼명을 생략할 수 있음. */
INSERT INTO users(u_number, u_id, u_name, email) VALUES
				(1, 'abc1234', '가나다', null);
    
/* 해당 테이블 내 전체 데이터 조회구문 */
SELECT * FROM users;
INSERT INTO users VALUES (2, 'abc3456', '마바사', 'abc@ab.com');

/* 문제
3번 유저를 임의로 추가해주세요.
조회구문은 이메일, 회원번호, 아이디 순으로 세 컬럼만 조회해보세요 */
INSERT INTO users(u_id, u_number, u_name) VALUES
				('qwer1234', 3, '쿼리문');

SELECT email, u_number, u_id FROM users;

/* 계정을 하나 더 생성하겠습니다.
이번 계정은 swudb 데이터베이스에 대해 SELECT 권한만 주겠습니다. */
CREATE USER 'adminid2' IDENTIFIED BY '20240215';
GRANT SELECT ON swudb.* TO 'adminid2';

-- users 테이블에 주소 컬럼을 추가해보겠습니다.
# ALTER TABLE 테이블명 ADD (추가컬럼명, 자료타입(크기));
ALTER TABLE users ADD (u_address varchar(30));

SELECT * FROM users;

# users 테이블에서 이메일 컬럼을 삭제해주세요.
ALTER TABLE users DROP COLUMN email;

# u_address 컬럼에 UNIQUE 제약조건 별칭 부여해서 걸기
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

-- INSERT INTO 구문으로 6, 7번 유저를 추가해주시되
# 주소는 둘 다 '노원구' 로 넣으려고 시도해보세요.
INSERT INTO users VALUES(6, "sixsix", "육육이", '노원구');
INSERT INTO users VALUES(7, "sesese", "칠칠이", '노원구');

SELECT * FROM users;	

-- u_address에 걸린 unique 제약을 없애고 7번을 마저 추가해주세요.
-- 위에서 u_address 컬럼에 걸린 제약조건의 별칭인 u_address_unique 를 삭제하면 됩니다.
ALTER TABLE users DROP CONSTRAINT u_address_unique;

-- users 테이블명을 members로 바꿔보겠습니다.
RENAME TABLE users to members;

SELECT * FROM members;

-- TRUNCATE TABLE은 내부 데이터만 소각합니다. 빈 테이블은 남아있습니다.
TRUNCATE TABLE members;

-- DROP TABLE은 내부 데이터 및 테이블 구조 자체를 없앱니다.
DROP TABLE members;


