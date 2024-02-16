-- user_tbl을 조회해보겠습니다.
SELECT * FROM user_tbl;

-- 지금까지 배운 문법으로 수도권(서울, 경기)에 사는 사람을 쿼리문 하나로 조회해주세요.
SELECT * FROM user_tbl WHERE user_address = '서울' OR user_address = '경기';

-- IN 문법을 활용하면 좀 더 간결하게 수도권 사는 사람을 쿼리문 하나로 조회할 수 있습니다.
SELECT * FROM user_tbl WHERE user_address IN ('서울', '경기');

-- IN 문법을 응용해서 구매내역이 있는 유저만 출력해 보세요.
SELECT * FROM buy_tbl;

-- 힌트 : 구매내역이 있는 유저를 IN 뒤쪽에 SELECT문으로 조회
SELECT DISTINCT user_num FROM buy_tbl;
SELECT * FROM user_tbl WHERE user_num IN (SELECT DISTINCT user_num FROM buy_tbl);

-- LIKE구문은 패턴 일치 여부를 통해서 조회합니다.
-- %는 와일드카드 문자로, 어떤 문자가 몇 글자가 와도 좋다는 의미입니다.
-- _는 와일드카드 문자로, _하나당 1글자가 매칭된다는 의미입니다.
-- 이름 글자수 상관없이 "희"로 끝나는 사람을 조회해주세요.
SELECT * FROM user_tbl WHERE user_name LIKE '%희';

-- _를 활용해서 XX남도에 사는 사람만 조회해보세요.
SELECT * FROM user_tbl WHERE user_address LIKE '_남';

-- 이름에 '자바' 가 들어가는 사람을 모두 조회해주세요.
SELECT * FROM user_tbl WHERE user_name LIKE '%자바';
SELECT * FROM user_tbl WHERE user_name LIKE '_자바';

-- 키가 170 이상 180 이하인 사람을 AND로도 조회해 보시고, BETWEEN으로도 조회해보세요.
SELECT * FROM user_tbl WHERE user_height >= 170 AND user_height <= 180;
SELECT * FROM user_tbl WHERE user_height BETWEEN 170 AND 180;

-- NULL을 가지는 데이터 생성
INSERT INTO user_tbl VALUES
	(null, '박진영', 1990, '제주', null, '2024-10-01'),
    (null, '김혜경', 1992, '강원', null, '2024-10-02'),
    (null, '신지수', 1993, '서울', null, '2024-10-05');

-- user_height이 null인 자료를 비교연산자로 먼저 조회해보세요.
SELECT * FROM user_tbl WHERE user_height = null;
SELECT * FROM user_tbl WHERE user_height IS NULL;

