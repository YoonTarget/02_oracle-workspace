-- [DDL]

-- 1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다.
-- 다음과 같은 테이블을 작성하시오.
DROP TABLE TB_CATEGORY;

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
DROP TABLE TB_CLASS_TYPE;

CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

-- 3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성하시오.
-- (KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이름을 지정하고자 한다면 이름은 본인이 알아서 적당한 이름을 사용한다.)
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY (NAME);

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

-- 5. 두 테이블에서 컬럼명이 NO인 것은 기존 타입을 유지하면서 크기는 10으로, 
-- 컬럼명이 NAME인 것은 마찬가지로 기존 타입을 유지하면서 크기 20으로 변경하시오.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE 
    MODIFY NO VARCHAR2(10)
    MODIFY NAME VARCHAR2(20);
    
-- 6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각각 TB_를 제외한 테이블 이름이 앞에 붙은 형태로 변경한다.
-- (EX. CATEGORY_NAME)
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
    RENAME COLUMN NO TO CLASS_TYPE_NO;
    
ALTER TABLE TB_CLASS_TYPE
    RENAME COLUMN NAME TO CLASS_TYPE_NAME;
    
-- 7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
-- PRIMARY KEY의 이름은 "PK + 컬럼이름"으로 지정하시오. (EX. PK_CATEGORY_NAME)
ALTER TABLE TB_CATEGORY
    RENAME CONSTRAINT SYS_C007236 TO PK_CATEGORY_NAME;
    
ALTER TABLE TB_CLASS_TYPE
    RENAME CONSTRAINT SYS_C007182 TO PK_CLASS_TYPE_NO;
    
-- 8. 다음과 같은 INSERT 문을 수행한다.
INSERT INTO TB_CATEGORY VALUES ('공학', DEFAULT);
INSERT INTO TB_CATEGORY VALUES ('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

DELETE FROM TB_CATEGORY;

SELECT * FROM TB_CATEGORY;

-- 9. TB_DEPARTMENT의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모값으로 참조하도록 FOREIGN KEY를 지정하시오
-- 이때, KEY 이름은 FK_테이블이름_컬럼이름으로 지정한다. (EX. FK_DEPARTMENT_CATEGORY)
ALTER TABLE TB_DEPARTMENT 
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) 
    REFERENCES TB_CATEGORY;
    
-- 10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생 일반정보 VIEW를 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL문을 작성하시오.
/*
    뷰 이름
        VW_학생일반정보
    컬럼
        학번
        학생이름
        주소
*/
GRANT CREATE VIEW TO workbook;

CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT;
     
DROP VIEW VW_학생일반정보;

SELECT * FROM VW_학생일반정보;

-- 11. 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
-- 이를 위해 사용할 학생이름, 학과이름, 담당교수 이름으로 구성되어 있는 VIEW를 만드시오.
-- 이때, 지도 교수가 없는 학생이 있을 수 있음을 고려하시오.
-- (단, 이 VIEW는 단순 SELECT만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
/*
    뷰 이름
        VW_지도면담
    컬럼
        학생이름
        학과이름
        지도교수이름
*/
CREATE OR REPLACE VIEW VW_지도면담
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
     FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     LEFT JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
     ORDER BY 2;
     
DROP VIEW VW_지도면담;
     
SELECT * FROM VW_지도면담;

-- 12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW를 작성해보자.
/*
    뷰 이름
        VW_학과별학생수
    컬럼
        DEPARTMENT_NAME
        STUDENT_COUNT
*/
CREATE OR REPLACE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME, COUNT(STUDENT_NAME) AS "STUDENT_COUNT"
     FROM TB_DEPARTMENT
     LEFT JOIN TB_STUDENT USING (DEPARTMENT_NO)
     GROUP BY DEPARTMENT_NAME;
     
DROP VIEW VW_학과별학생수;
     
SELECT * FROM VW_학과별학생수;

-- 13.위에서 생성한 학생일반정보 VIEW를 통해서 학번이 A213046인 학생의 이름을 본인 이름으로 변경하는 SQL문을 작성하시오.
UPDATE VW_학생일반정보
SET STUDENT_NAME = '윤관현'
WHERE STUDENT_NO = 'A213046';

SELECT * FROM VW_학생일반정보;

-- 14. 13번에서와 같이 VIEW를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW를 어떻게 생성해야 하는지 작성하시오.
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT
WITH CHECK OPTION;

-- 15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려 문제가 되고 있다.
-- 최근 3년을 기준으로 수강인원이 가장 많았던 3과목을 찾는 구문을 작성해보시오.
SELECT *
FROM (SELECT CLASS_NO, CLASS_NAME, COUNT(STUDENT_NO)
        FROM TB_CLASS
        JOIN TB_GRADE USING (CLASS_NO)
        JOIN TB_STUDENT USING (STUDENT_NO)
        WHERE SUBSTR(TERM_NO, 1, 4) BETWEEN '2005' AND '2009'
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY 3 DESC)
WHERE ROWNUM <= 3;

-- [DML]
-- 1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
/*
    번호, 유형이름
    ------------
    01, 전공필수
    02, 전공선택
    03, 교양필수
    04, 교양선택
    05. 논문지도
*/

SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE VALUES ('1', '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES ('2', '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES ('3', '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES ('4', '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES ('5', '논문지도');

-- 2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL문을 작성하시오. (서브쿼리를 이용하시오)
/*
    테이블이름
        TB_학생일반정보
    컬럼
        학번
        학생이름
        주소
*/
CREATE TABLE TB_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT;
     
DROP TABLE TB_학생일반정보;
     
SELECT * FROM TB_학생일반정보;

-- 3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL문을 작성하시오.
-- (힌트 : 방법은 다양함, 소신껏 작성하시오)
/*
    테이블이름
        TB_국어국문학과
    컬럼
        학번
        학생이름
        출생년도(네 자리 년도로 표기)
        교수이름
*/
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;

CREATE TABLE TB_국어국문학과
AS SELECT STUDENT_NO, STUDENT_NAME, '19' || SUBSTR(STUDENT_SSN, 1, 2) AS "BIRTH", PROFESSOR_NAME
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
    WHERE DEPARTMENT_NAME = '국어국문학과';
    
DROP TABLE TB_국어국문학과;

SELECT * FROM TB_국어국문학과;

-- 4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL 문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);

SELECT * FROM TB_DEPARTMENT;

-- 5. 학번 A413042인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21"로 변경되었다고 한다.
-- 주소지를 정정하기 위해 사용할 SQL문을 작성하시오.
SELECT * FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';

-- 6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 결정하였다.
-- 이 내용을 반영할 적절한 SQL문을 작성하시오. (예. 830530-2124663 => 830530)
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT * FROM TB_STUDENT;

-- 7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강한 '피부생리학' 점수가 잘못되었다는 것을 발견하고는 정정을 요청하였다.
-- 담당 교수의 확인 받은 결과 해당 과목의 학점을 3.5로 변경키로 결정되었다. 적절한 SQL문을 작성하시오.
SELECT *
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE STUDENT_NAME = '김명훈'
AND DEPARTMENT_NAME = '의학과'
AND TERM_NO = 200501;

UPDATE (SELECT * 
        FROM TB_GRADE
        JOIN TB_STUDENT USING (STUDENT_NO)
        JOIN TB_CLASS USING (CLASS_NO)
        WHERE TERM_NO = 200501
        AND STUDENT_NAME = '김명훈'
        AND CLASS_NAME = '피부생리학')
SET POINT = 3.5;

-- 8. 성적 테이블(TB_GRADE)에서 휴학생들의 성적항목을 제거하시오.
SELECT * 
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO);

DELETE (SELECT *
        FROM TB_GRADE
        JOIN TB_STUDENT USING (STUDENT_NO))
WHERE ABSENCE_YN = 'Y';

ROLLBACK;
