/*
	조인(JOIN)
    2개 이상의 테이블을 결합, 여러 테이블에 나누어 삽입된 연관 데이터를 결합해주는 기능
    같은 내용의 컬럼이 존재해야만 사용할 수 있음.
    
    SELECT 테이블1.컬럼1, 테이블1.컬럼2 ... 테이블2.컬럼1, 테이블2.컬럼2 ...
    FROM 테이블1 JOIN구문 테이블2
    ON 테이블1.공통컬럼 = 테이블2.공통컬럼;
    
	WHERE 구문을 이용해 ON절로 합쳐진 결과 컬럼에 대한 필터링이 가능합니다.
*/
-- 예제 데이터를 삽입하기 위한 테이블 2개 생성(외래키는 걸지 않습니다.)
CREATE TABLE member_tbl (
	mem_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_name VARCHAR(10) NOT NULL,
    mem_addr VARCHAR(10) NOT NULL
);

CREATE TABLE purchase_tbl(
	pur_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_num INT,
    pur_date DATETIME DEFAULT now(), -- 구매시간을 입력하는 그 시간으로 지정
    pur_price INT
);

-- 예제 데이터 삽입
INSERT INTO member_tbl VALUES
	(null, '김회원', '서울'),
    (null, '박회원', '경기'),
    (null, '최회원', '제주'),
    (null, '박성현', '경기'),
    (null, '이성민', '서울'),
    (null, '강영호', '충북');
    
INSERT INTO purchase_tbl VALUES
	(null, 1, '2024-05-12', 50000),
    (null, 3, '2024-05-12', 20000),
    (null, 4, '2024-05-12', 10000),
    (null, 1, '2024-05-13', 40000),
    (null, 1, '2024-05-14', 30000),
    (null, 3, '2024-05-14', 30000),
    (null, 5, '2024-05-14', 50000),
    (null, 5, '2024-05-15', 60000),
    (null, 1, '2024-05-15', 15000);

SELECT * FROM member_tbl;
SELECT * FROM purchase_tbl;
SELECT member_tbl.mem_num, member_tbl.mem_name, member_tbl.mem_addr,
	purchase_tbl.pur_date, purchase_tbl.pur_num, purchase_tbl.pur_price
FROM member_tbl INNER JOIN purchase_tbl
ON member_tbl.mem_num = purchase_tbl.mem_num;

SELECT * FROM buy_tbl;
SELECT * FROM user_tbl;
-- buy_tbl과 user_tbl을 조인해주세요
-- user_tbl에서 조회할 컬럼 : user_name, user_address, user_num
-- buy_tbl에서 조회할 컬럼 : buy_num, prod_name, prod_cate, price, amount
SELECT 
	user_tbl.user_name, user_tbl.user_address, user_tbl.user_num,
	buy_tbl.buy_num, buy_tbl.prod_name, buy_tbl.prod_cate, buy_tbl.price, buy_tbl.amount
FROM buy_tbl INNER JOIN user_tbl; -- ON조건을 주지 않으면 자동으로 컬럼명이 일치하는 컬럼으로 조인을 시도합니다.

-- buy_tbl과 user_tbl이라는 테이블명을 전부 기입하면 불편하기 때문에
-- 보통 조인시에는 테이블명에 별칭을 붙여서 별칭으로 처리합니다.
SELECT u.user_name, u.user_address, u.user_num,
	b.buy_num, b.prod_name, b.prod_cate, b.price, b.amount
FROM buy_tbl b INNER JOIN user_tbl u
ON b.user_num = u.user_num;

-- LEFT JOIN, RIGHT JOIN은, JOIN절 왼쪽이나 오른쪽 테이블은 전부 데이터를 남기고
-- 반대쪽방향 테이블은 교집합만 남깁니다.
SELECT m.mem_num, p.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m NATURAL JOIN purchase_tbl p;
-- ON m.mem_num = p.mem_num;

-- RIGHT JOIN 확인을 위한 데이터 생성
INSERT INTO purchase_tbl VALUES
	(null, 8, '2024-05-16', 25000),
    (null, 9, '2024-05-16', 25000),
    (null, 8, '2024-05-17', 35000);

-- CROSS JOIN은 조인 대상인 테이블1과 테이블2간의 모든 ROW의 조합쌍을 출력합니다.
-- 그래서 결과 ROW의 개수는 테이블1의 ROW개수 * 테이블2의 ROW개수가 됩니다.

-- 테스트코드를 먼저 돌려보고, 예제 테이블을 다시 만들어보겠습니다.
SELECT u.user_num, b.buy_num FROM
	user_tbl u, buy_tbl b; -- JOIN구문 없이 테이블2개를 ,로 나열하면 cross join 구문을 생략할 수 잇음.
SELECT COUNT(*) FROM user_tbl;
SELECT COUNT(*) FROM buy_tbl;
SELECT DISTINCT user_num FROM user_tbl;
SELECT DISTINCT buy_num FROM buy_tbl;

-- 좀 더 이해하기 쉬운 예시
CREATE TABLE phone_volume(
	volume VARCHAR(3),
    model_name VARCHAR(10)
);

CREATE TABLE phone_color(
	color VARCHAR(5)
);

INSERT INTO phone_volume VALUES
	(128, 'galaxy'),
    (256, 'galaxy'),
    (512, 'galaxy'),
    (128, 'iphone'),
    (256, 'iphone'),
    (512, 'iphone');

INSERT INTO phone_color VALUES
	('빨간색'),
    ('파란색'),
    ('노란색'),
    ('회색');

SELECT * FROM phone_volume CROSS JOIN phone_color;

/*  SELF JOIN은 자기 테이블 내부 자료를 참조하는 컬럼이 있을 때,
	해당 자료를 온전히 노출시키기 위해서 사용하는 경우가 대부분입니다.
    예시로는 사원 목록중 자기 자신과 직속상사를 나타내거나 게시판에서 원본글과 답변글을 나타내는 경우
    연관된 자료를 한 테이블 형식으로 조회하기 위해 사용합니다.*/
CREATE TABLE staff(
	staff_num INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(20),
    staff_job VARCHAR(20),
    staff_salary INT,
    staff_supervisor INT
);
INSERT INTO staff VALUES
	(NULL, '설민경', '개발', 30000, NULL),
    (NULL, '윤동석', '총무', 25000, NULL),
    (NULL, '하영선', '인사', 18000, NULL),
    (NULL, '오진호', '개발', 5000, 1),
    (NULL, '류민지', '개발', 4500, 4),
    (NULL, '권기남', '총무', 4000, 2),
    (NULL, '조예지', '인사', 3200, 3),
    (NULL, '배성은', '개발', 3500, 5);

SELECT * FROM staff;

-- SELF JOIN을 이용해 직원이름과 직속상사의 이름이 같이 나오게 만들어보겠습니다.
-- SELF JOIN은 테이블 자기 자신을 자기가 참조하도록 만들기 때문에
-- JOIN시 테이블명은 좌, 우 같은 이름으로, AS를 이용해서 부여한 별칭은 다르게 해서
-- 좌측과 우측 테이블의 구분하면 됩니다. 이외에는 모두 같습니다.
SELECT
	r.staff_num, l.staff_name as 상급자이름, r.staff_name as 하급자이름
FROM
	staff as l INNER JOIN staff as r
ON
	l.staff_num = r.staff_supervisor; -- staff의 번호와 상사번호가 일치하는 경우에 출
    
-- UNION은 SELECT문 두 개를 위 아래로 배치해서 양쪽 결과를 붙여줍니다.
-- 수직적 확장을 주로 고려할때 사용합니다.
-- 고양이 테이블 생성
CREATE TABLE CAT(
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
    animal_type VARCHAR(20)
);
-- 강아지 테이블 생성
CREATE TABLE DOG(
	animal_name VARCHAR(20),
    animal_age INT,
    animal_owner VARCHAR(20),
    animal_type VARCHAR(20)
);

-- 고양이 2마리, 강아지 2마리 넣기
INSERT INTO cat VALUES
	('룰루', 4, '룰맘', '고양이'),
    ('어완자', 5, '양정', '고양이');
INSERT INTO dog VALUES
	('턱순이', 7, '이영수', '강아지'),
    ('구슬이', 8, '이영수', '강아지');

-- UNION으로 결과 합치기
SELECT * FROM CAT
UNION
SELECT * FROM DOG;

DROP TABLE CAT;
DROP TABLE DOG;

-- 고양이 테이블 생성
CREATE TABLE CAT(
	cat_name VARCHAR(20),
    cat_age INT,
    cat_owner VARCHAR(20),
    cat_type VARCHAR(20)
);
-- 강아지 테이블 생성
CREATE TABLE DOG(
	dog_name VARCHAR(20),
    dog_age INT,
    dog_owner VARCHAR(20),
    dog_type VARCHAR(20)
);

-- MySQL은 FULL OUTER JOIN을 UNION을 이용해서 합니다.
-- LEFT 조인 구문 UNION RIGHT 조인 구문
-- 순으로 작성하면 됩니다.
SELECT m.mem_num, p.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m LEFT JOIN purchase_tbl p
ON m.mem_num = p.mem_num
UNION
SELECT m.mem_num, p.mem_num, m.mem_name, m.mem_addr,
		p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m RIGHT JOIN purchase_tbl p
ON m.mem_num = p.mem_num;


