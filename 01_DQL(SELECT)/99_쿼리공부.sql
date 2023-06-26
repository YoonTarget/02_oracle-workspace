-- 저장 먼저 하기

---------------------------------------------------- QUIZ 1 --------------------------------------------------
-- 보너스를 받지 않지만 부서배치는 된 사원 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL 값에 대해 정상적으로 비교 처리 되지 않음!

-- 문제점 : NULL 값을 비교할 때는 단순한 일반 비교연산자를 통해 비교할 수 없음!!
-- 해결방법 : IS NULL / IS NOT NULL 연산자 이용해서 비교해야됨!!

-- 조치한 SQL문
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;

--------------------------------------------------------------------------------------------------------
-------------------------------------------- QUIZ 2 --------------------------------------
-- 검색하고자 하는 내용
-- JOB_CODE J7 이거나 J6 이면서 SALARY 값이 200만원 이상이고
-- BONUS가 있고 여자이며 이메일 주소는 _ 앞에 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회하려고 한다.
-- 정상적으로 조회가 잘된다면 실행결과는 2행이어야 한다.

-- 위의 내용을 실행시키고자 작성한 SQL문은 아래와 같음
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS NULL;

-- 위의 SQL문 실행시 원하는 결과가 제대로 조회되지 않는다. 이때 어떤 문제점들(5개의 문제점)이 있는지
-- 모두 찾아서 서술해 볼 것! 그리고 조치된 완벽한 SQL문을 작성해 볼 것
-- SUBSTR (컬럼, 시작인덱스, 개수)

-- 문제점
-- 1. JOB_CODE = 'J7' OR JOB_CODE = 'J6'를 괄호()로 묶어줘야 한다.
-- OR 연산자와 AND 연산자 나열되어있을 경우 AND 연산자 연산이 먼저 수행되기 때문에!!
-- 2. EMAIL LIKE '___$_%' ESCAPE '$'로 언더바를 구분시켜 줘야 한다.
-- 3. 보너스가 있으므로 IS NOT NULL을 써야한다.
-- 4. 조회 항목에 EMP_NO을 추가해야 한다.
-- 5. WHERE절에 여자인 경우의 조건도 추가해야 한다.
-- 6. SALARY 값이 200만원 이상이므로 >= 를 사용해야 한다.

-- 조치내용
SELECT EMP_NAME, EMP_NO,  JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR (EMP_NO, 8, 1) IN ('2', '4');

---------------------------------------------------- QUIZ 3 --------------------------------------------
-- [계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

-- 계정명 : SCOTT, 비밀번호 : TIGER 계정을 생성하고 싶다!!
-- 이때 일반사용자 계정인 KH계정에 접속해서 CREATE USER SCOTT;로 실행하니 문제 발생!!

-- 문제점 1. 사용자 계정 생성은 무조건 관리자 계정에서만 가능!!
-- 문제점 2. SQL문이 잘못되어 있음!! 비번까지 입력해야 함!!

-- 조치내용 1. 관리자 계정에 접속해야 한다.
-- 조치내용 2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL(CREATE)문만 실행 후 접속을 만들어 접속을 하려고 했더니 실패!!
-- 뿐만 아니라 해당 계정에 테이블 생성 같은 것도 되지 않음!! 왜 그럴까??

-- 문제점 1. 사용자 계정 생성 후 최소한의 권한 부여!!

-- 조치내용. GRANT CONNECT, RESOURCE TO SCOTT; 구문 실행해서 권한 부여















