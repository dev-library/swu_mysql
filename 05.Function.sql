-- 영어로 된 사람을 추가해보겠습니다.
SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES
	(null, 'alex', 1986, 'NY', 173, '2024-11-01'),
    (null, 'Smith', 1992, 'Texas', 181, '2024-11-05'),
    (null, 'Emma', 1995, 'Tampa', 168, '2024-12-13'),
    (null, 'JANE', 1996, 'LA', 157, '2024-12-15');
    
-- 문자열 함수를 활용해서, 하나의 컬럼을 여러 형식으로 조회해보겠습니다.
SELECT 
	user_name,
    UPPER(user_name) AS 대문자유저명,
    LOWER(user_name) AS 소문자유저명,
    LENGTH(user_name) AS 문자길이,
    SUBSTR(user_name, 1, 2) AS 첫2글자,
    CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 4글자 이상인 유저만 출력해주세요.
-- LENGTH()는 byte길이로 글자수를 산정하므로 한글은 한 글자에 3바이트로 간주합니다.
-- 따라서 LENGTH() 대신 CHAR_LENGTH()를 이용하면 언어상관없이 글자를 하나씩 세 줍니다.
SELECT * FROM user_tbl
	WHERE CHAR_LENGTH(user_name) > 3;
    
-- 함수 도움 없이 4글자만 뽑는 방법
SELECT * FROM user_tbl WHERE user_name LIKE '____';
-- 함수 도움 없이 4글자 이상만 뽑는 방법
SELECT * FROM user_tbl WHERE user_name LIKE '____%';

-- ALTER TABLE을 이용해서 user_tbl에 소수점 아래를 저장받을수 있는 컬럼을 추가해보겠습니다.
-- DECIMAL은 고정자리수이므로 반드시 소수점 아래 2자리까지 표시해야 합니다.
-- 전체 3자리 중, 소수점 아래에 2자리, 정수 부분은 1자리 배정하겠다
ALTER TABLE user_tbl ADD(user_weight DECIMAL(3, 2));
ALTER TABLE user_tbl MODIFY user_weight DECIMAL(5, 2);
SELECT * FROM user_Tbl;

-- 10번유저의 체중을 52.12로 바꿔보겠습니다.
UPDATE user_tbl SET user_weight = 52.12 WHERE user_num = 10;

-- 숫자 함수 사용 예제
SELECT
	user_name, user_weight,
    ROUND(user_weight, 0) AS 체중반올림,
    TRUNCATE(user_weight, 1) AS 체중소수점아래1자리절사,
    MOD(user_height, 150) AS 키150으로나눈나머지,
    CEIL(user_height) AS 키올림,
	FLOOR(user_height) AS 키내림,
    SIGN(user_height) AS 양수음수0여부,
    SQRT(user_height) AS 키제곱근
FROM
	user_tbl;
    
-- 날짜함수를 활용한 예제
SELECT
	user_name, entry_date,
    DATE_ADD(entry_date, INTERVAL 3 MONTH) AS _3개월후,
    LAST_DAY(entry_date) AS 해당월마지막날짜,
    TIMESTAMPDIFF(DAY, entry_date, STR_TO_DATE('20240216', '%Y%m%d')) AS 오늘과의일수차이
FROM
	user_tbl;

-- 현재 시간을 조회하는 구문
SELECT now();

-- 변환함수를 활용한 예제
SELECT
	user_num, user_name, entry_date,
    DATE_FORMAT(entry_date, '%Y%m%d') AS 일자표현변경,
    CAST(user_num AS CHAR) AS 문자로바꾼회원번호
FROM
	user_tbl;

-- user_height, user_weight이 NULL인 자료를 추가해보겠습니다.
INSERT INTO user_tbl VALUES(null, '임쿼리', 1986, '제주', null, '2025-01-03', null);

SELECT * FROM user_tbl;

-- IFNULL()을 이용해서 특정 컬럼의 값이 null인 경우 대체값으로 표현하는 예제
SELECT
	user_name,
    user_height, user_weight,
    IFNULL(user_height, 167) AS _NULL대신평균키,
    IFNULL(user_weight, 65) AS _NULL대신평균체중
FROM
	user_tbl;

-- SQL에서 0으로 수치를 나누면 무슨일이 벌어지는지 보겠습니다.
SELECT 3/0;

SELECT * FROM user_tbl;
-- user_tbl의 회원들 중 년도 기준으로
-- 1993년 이전 출생자는 고연령, 1997년 이전 출생자는 중위연령, 나머지는 저연령
SELECT
	user_name, user_birth_year,
	CASE
		WHEN user_birth_year  < 1993 THEN '고연령'
        WHEN user_birth_year < 1997 THEN '중위연령'
        ELSE '저연령'
	END AS 연령분류
FROM user_tbl;



