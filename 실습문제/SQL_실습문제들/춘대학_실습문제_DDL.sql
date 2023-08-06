-- [DDL]

-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�.
-- ������ ���� ���̺��� �ۼ��Ͻÿ�.
DROP TABLE TB_CATEGORY;

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

-- 2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
DROP TABLE TB_CLASS_TYPE;

CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

-- 3. TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY�� �����Ͻÿ�.
-- (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸��� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY (NAME);

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

-- 5. �� ���̺��� �÷����� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10����, 
-- �÷����� NAME�� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20���� �����Ͻÿ�.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE 
    MODIFY NO VARCHAR2(10)
    MODIFY NAME VARCHAR2(20);
    
-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� ���� TB_�� ������ ���̺� �̸��� �տ� ���� ���·� �����Ѵ�.
-- (EX. CATEGORY_NAME)
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
    RENAME COLUMN NO TO CLASS_TYPE_NO;
    
ALTER TABLE TB_CLASS_TYPE
    RENAME COLUMN NAME TO CLASS_TYPE_NAME;
    
-- 7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
-- PRIMARY KEY�� �̸��� "PK + �÷��̸�"���� �����Ͻÿ�. (EX. PK_CATEGORY_NAME)
ALTER TABLE TB_CATEGORY
    RENAME CONSTRAINT SYS_C007236 TO PK_CATEGORY_NAME;
    
ALTER TABLE TB_CLASS_TYPE
    RENAME CONSTRAINT SYS_C007182 TO PK_CLASS_TYPE_NO;
    
-- 8. ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO TB_CATEGORY VALUES ('����', DEFAULT);
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

DELETE FROM TB_CATEGORY;

SELECT * FROM TB_CATEGORY;

-- 9. TB_DEPARTMENT�� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ����� �����ϵ��� FOREIGN KEY�� �����Ͻÿ�
-- �̶�, KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�. (EX. FK_DEPARTMENT_CATEGORY)
ALTER TABLE TB_DEPARTMENT 
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) 
    REFERENCES TB_CATEGORY;
    
-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л� �Ϲ����� VIEW�� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�.
/*
    �� �̸�
        VW_�л��Ϲ�����
    �÷�
        �й�
        �л��̸�
        �ּ�
*/
GRANT CREATE VIEW TO workbook;

CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT;
     
DROP VIEW VW_�л��Ϲ�����;

SELECT * FROM VW_�л��Ϲ�����;

-- 11. �� ������б��� 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
-- �̸� ���� ����� �л��̸�, �а��̸�, ��米�� �̸����� �����Ǿ� �ִ� VIEW�� ����ÿ�.
-- �̶�, ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�.
-- (��, �� VIEW�� �ܼ� SELECT���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
/*
    �� �̸�
        VW_�������
    �÷�
        �л��̸�
        �а��̸�
        ���������̸�
*/
CREATE OR REPLACE VIEW VW_�������
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
     FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     LEFT JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
     ORDER BY 2;
     
DROP VIEW VW_�������;
     
SELECT * FROM VW_�������;

-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW�� �ۼ��غ���.
/*
    �� �̸�
        VW_�а����л���
    �÷�
        DEPARTMENT_NAME
        STUDENT_COUNT
*/
CREATE OR REPLACE VIEW VW_�а����л���
AS SELECT DEPARTMENT_NAME, COUNT(STUDENT_NAME) AS "STUDENT_COUNT"
     FROM TB_DEPARTMENT
     LEFT JOIN TB_STUDENT USING (DEPARTMENT_NO)
     GROUP BY DEPARTMENT_NAME;
     
DROP VIEW VW_�а����л���;
     
SELECT * FROM VW_�а����л���;

-- 13.������ ������ �л��Ϲ����� VIEW�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� �̸����� �����ϴ� SQL���� �ۼ��Ͻÿ�.
UPDATE VW_�л��Ϲ�����
SET STUDENT_NAME = '������'
WHERE STUDENT_NO = 'A213046';

SELECT * FROM VW_�л��Ϲ�����;

-- 14. 13�������� ���� VIEW�� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW�� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT
WITH CHECK OPTION;

-- 15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���� ������ �ǰ� �ִ�.
-- �ֱ� 3���� �������� �����ο��� ���� ���Ҵ� 3������ ã�� ������ �ۼ��غ��ÿ�.
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
-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
/*
    ��ȣ, �����̸�
    ------------
    01, �����ʼ�
    02, ��������
    03, �����ʼ�
    04, ���缱��
    05. ������
*/

SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE VALUES ('1', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('2', '��������');
INSERT INTO TB_CLASS_TYPE VALUES ('3', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('4', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('5', '������');

-- 2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
/*
    ���̺��̸�
        TB_�л��Ϲ�����
    �÷�
        �й�
        �л��̸�
        �ּ�
*/
CREATE TABLE TB_�л��Ϲ�����
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
     FROM TB_STUDENT;
     
DROP TABLE TB_�л��Ϲ�����;
     
SELECT * FROM TB_�л��Ϲ�����;

-- 3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�.
-- (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�)
/*
    ���̺��̸�
        TB_������а�
    �÷�
        �й�
        �л��̸�
        ����⵵(�� �ڸ� �⵵�� ǥ��)
        �����̸�
*/
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;

CREATE TABLE TB_������а�
AS SELECT STUDENT_NO, STUDENT_NAME, '19' || SUBSTR(STUDENT_SSN, 1, 2) AS "BIRTH", PROFESSOR_NAME
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
    WHERE DEPARTMENT_NAME = '������а�';
    
DROP TABLE TB_������а�;

SELECT * FROM TB_������а�;

-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�.
-- (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);

SELECT * FROM TB_DEPARTMENT;

-- 5. �й� A413042�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21"�� ����Ǿ��ٰ� �Ѵ�.
-- �ּ����� �����ϱ� ���� ����� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042';

-- 6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���.
-- �� ������ �ݿ��� ������ SQL���� �ۼ��Ͻÿ�. (��. 830530-2124663 => 830530)
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT * FROM TB_STUDENT;

-- 7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���.
-- ��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5�� ����Ű�� �����Ǿ���. ������ SQL���� �ۼ��Ͻÿ�.
SELECT *
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE STUDENT_NAME = '�����'
AND DEPARTMENT_NAME = '���а�'
AND TERM_NO = 200501;

UPDATE (SELECT * 
        FROM TB_GRADE
        JOIN TB_STUDENT USING (STUDENT_NO)
        JOIN TB_CLASS USING (CLASS_NO)
        WHERE TERM_NO = 200501
        AND STUDENT_NAME = '�����'
        AND CLASS_NAME = '�Ǻλ�����')
SET POINT = 3.5;

-- 8. ���� ���̺�(TB_GRADE)���� ���л����� �����׸��� �����Ͻÿ�.
SELECT * 
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO);

DELETE (SELECT *
        FROM TB_GRADE
        JOIN TB_STUDENT USING (STUDENT_NO))
WHERE ABSENCE_YN = 'Y';

ROLLBACK;
