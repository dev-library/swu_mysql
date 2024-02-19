-- GROUP BY는 기준컬럼을 하나 이상 제시할 수 있고, 기준컬럼에서 동일한 값을 가지는 것 끼리
-- 같은 집단으로 보고 집계하는 쿼리문입니다.
-- SELECT 집계컬럼명 FROM 테이블명 GROUP BY 기준컬럼명;

-- 지역별 평균 키를 구해보겠습니다.(지역정보 : user_address)
SELECT * FROM user_tbl;
SELECT
	user_address AS 지역명,
    AVG(user_height) AS 평균키
FROM
	user_tbl
GROUP BY
	user_address;
    
-- 생년별 인원수를 구해주세요.
-- 생년, 인원수 컬럼이 노출되어야 합니다.
SELECT
	user_birth_year AS 생년,
	COUNT(user_num) AS 인원수
FROM 
	user_tbl
GROUP BY
	user_birth_year;

-- user_tbl 전체에서 가장 큰 키, 가장 빠른 출생년도가 각각 무슨 값인지 구해주세요.
-- GROUP BY 없이 집계함수를 사용해주시면 됩니다.
SELECT
	MAX(user_height) AS 가장큰키,
    MIN(user_birth_year) AS 가장빠른출생년도
FROM
	user_tbl;
    
-- HAVING을 써서 거주자가 2명이상인 지역만 카운팅해보세요
-- 거주지별 생년평균도 같이 보여주세요.
SELECT
	user_address AS 거주지역,
    AVG(user_birth_year) AS 생년평균,
    COUNT(user_num) AS 인원수
FROM
	user_tbl
GROUP BY
	user_address
HAVING
	COUNT(user_address) >= 2;


-- HAVING 사용 문제
-- 생년 기준으로 평균 키가 160 이상인 생년만 출력해주세요.
-- 생별 평균 키도 같이 출력해주세요.
SELECT
	user_birth_year,
	AVG(user_height) AS 평균키
FROM
	user_tbl
GROUP BY
	user_birth_year
HAVING
	AVG(user_height) >= 160;
    
    
    
    
