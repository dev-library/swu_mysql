-- SUB QUERY란 쿼리문 내에 쿼리문을 중첩하는 것입니다.
-- 기본적으로 SELECT 문의 범위를 좁히는 경우 많이 사용합니다.

-- 회원별 평균 키를 구하는 집계함수 AVG를 사용해보겠습니다.
SELECT AVG(user_height) FROM user_tbl;

SELECT * FROM user_tbl;

-- 유저 이름과 유저키, 그리고 평균치를 같이 한 테이블에서 보고 싶습니다.
SELECT user_name, AVG(user_height) 
FROM user_tbl
GROUP BY user_name;

-- 위에서 설명했듯, GROUP BY는 우선 동명이인을 하나의 집단으로 보기 때문에 전 인원 평균을 못 넣고 있습니다.
-- 이 때 서브쿼리를 이용해서 전체 평균을 집어넣을 수 있습니다.
SELECT user_name, user_height, (SELECT AVG(user_height) FROM user_tbl) as avg_height
FROM user_tbl;

-- FROM절 SUB QUERY를 활용한 범위좁히기 개념에 대해서 보겠습니다.
-- FROM절 다음에는 테이블명만 올 수 잇는게 아니고, 데이터 시트형식을 갖춘 자료라면
-- 모든 형태의 자료가 올 수 있습니다.
-- user_tbl중 키가 170미만인 요소만 1차적으로 조회한 결과시트를 토대로 전체데이터 조회구문 작성
-- 서브쿼리를 FROM절에서 사용할 때는 별칭(alias)가 무조건 부여되어야 합니다.
SELECT A.* FROM
	(SELECT * FROM user_tbl WHERE user_height < 170) AS A;

-- 서브쿼리의 실제 활용 : 최지선보다 키가 큰 사람을 단일 쿼리문으로 결과 얻기.
-- 서브쿼리가 없는 경우
-- 1. 최지선의 키를 WHERE절을 이용해서 확인하기
SELECT user_height FROM user_tbl WHERE user_name = '최지선';

-- 2. 위 구문으로 얻어온 170이라는 값보다 큰 사람만 다시 두 번째 쿼리문으로 조회함
SELECT user_name FROM user_tbl WHERE user_height > 170;

-- 위의 1, 2 구문을 서브쿼리로 통합해주시고 실행 순서를 정리해보세요.
-- 힌트) 위에서 170이 들어갈 자리에 170을 구해주는 쿼리문을 서브쿼리 형식으로 집어넣으면 됩니다.
SELECT user_name FROM user_tbl WHERE user_height > 
	(SELECT user_height FROM user_tbl WHERE user_name = '최지선');

-- 위 코드를 참조해서, 평균보다 나이가 적은 사람만 조회하는 쿼리문을 서브쿼리를 활용해 만들어주세요.
SELECT user_name, user_birth_year 
FROM user_tbl 
WHERE user_birth_year > (SELECT AVG(user_birth_year) FROM user_tbl);

SELECT AVG(user_birth_year) FROM user_tbl;


