-- ORDER BY는 SELECT문의 질의결과를 정렬할때 사용합니다.
-- ORDER BY절 다음에는 어떤 컬럼을 기준으로 어떤방식으로 정렬할지 적어줘야 합니다.

-- 다음은 user_tbl에 대해서 키순으로 내림차순 정렬한 예시입니다.
SELECT * FROM user_tbl ORDER BY user_height DESC;

-- 문제
-- user_tbl에 대해서, 키순으로 오름차순 정렬해 주시되, 키가 동률이라면 체중순으로 내림차순 정렬해주세요.
SELECT * FROM user_tbl ORDER BY user_height ASC, user_weight DESC;

-- 이름을 가나다라 순으로 정렬하되, user_name 대신 un이라는 별칭을 써서 정렬해보겠습니다.
SELECT user_num, user_name as un, user_birth_year, user_address
FROM user_tbl
ORDER BY un DESC;

-- 컬럼 번호를(왼쪽부터 1번부터 시작, 우측으로 갈수록 1씩 증가) 이용해서도 정렬 가능합니다.
SELECT user_num, user_name AS un, user_birth_year, user_address
	FROM user_tbl
ORDER BY 3 DESC;

-- 지역별 키 평균을 내림차순으로 정렬해서 보여주세요.
SELECT user_address, AVG(user_height)
FROM user_tbl
GROUP BY user_address
ORDER BY AVG(user_height) DESC;

-- CASE, WHEN절을 써서 작성해주세요. 조건에 맞지 않는 경우 ELSE NULL 로 처리하면 null값이 들어갑니다.
-- 1992년생만 키를 기준으로 내림차순 정렬해주세요. 나머지 지역은 정렬기준이 없습니다.
SELECT
	user_name, user_birth_year, user_address, user_height, user_weight
FROM user_tbl
ORDER BY
	CASE user_address -- 지역컬럼에서
		WHEN '경기' THEN user_height
        ELSE NULL
	END DESC;
-- 경기인 지역만 원래 user_height값 표시, 나머지 지역은 null로 처리하는 구
SELECT
	*,
	CASE user_address -- 지역컬럼에서
		WHEN '경기' THEN user_height
        WHEN '서울' THEN user_height
        ELSE NULL
	END 
FROM user_tbl;

-- 생년도가 1992년인 사람은 키 기준 오름차순,
-- 생년도가 1998인 사람은 이름 기준 오름차순으로 정렬해서 출력해보세요.
-- 나머지들은 조건을 적용받지 않습니다.
SELECT *
	FROM user_tbl
ORDER BY
	CASE user_birth_year
		WHEN 1992 THEN user_height
        WHEN 1998 THEN user_name
        ELSE NULL
	END ASC;
        



