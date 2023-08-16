/* ȸ������ */
CREATE TABLE Members (
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	MemberPwd VARCHAR2(50) NOT NULL, /* ȸ����й�ȣ */
	MemberAddr VARCHAR2(100), /* ȸ���ּ� */
	MemberEmail VARCHAR2(100) NOT NULL, /* ȸ���̸��� */
	MemberName VARCHAR2(50) NOT NULL, /* ȸ���̸� */
	MemberTel VARCHAR2(20), /* ȸ����ȭ��ȣ */
	MemberBirth VARCHAR2(20), /* ȸ��������� */
	MemberGender VARCHAR(5), /* ȸ������ */
	MemberGradeName VARCHAR2(50) NOT NULL, /* ȸ����� */
	MemberDeposit NUMBER DEFAULT 0 /* ȸ����ġ�� */
);

ALTER TABLE Members
	ADD
		CONSTRAINT PK_Members
		PRIMARY KEY (
			MemberId
		);

ALTER TABLE Members
	ADD
		CONSTRAINT UK_Members
		UNIQUE (
			MemberEmail
		);

/* ç�������� */
CREATE TABLE Challenges (
	ChalNo NUMBER NOT NULL, /* ç������ȣ */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	ChalTitle VARCHAR2(100) NOT NULL, /* ç�������� */
	ChalContent CLOB NOT NULL, /* ç�������� */
	ParticipantsCnt NUMBER DEFAULT 0 NOT NULL, /* ç���������ڼ� */
	ChalFee NUMBER NOT NULL, /* ç���������� */
	ChalTotalFee NUMBER DEFAULT 0 NOT NULL, /* ç������������ */
	ChalStartDate DATE NOT NULL, /* ç���������� */
	ChalEndDate DATE NOT NULL, /* ç���������� */
	ChalStatus CHAR(1) DEFAULT 0 NOT NULL, /* ç����Ȱ��ȭ���� */
	ChalFileName VARCHAR2(100), /* ÿ���������̸� */
	SuccessParticipants85 NUMBER DEFAULT 0 NOT NULL, /* 85%�̻�100%�̸��޼��ڼ� */
	SuccessParticipants100 NUMBER DEFAULT 0 NOT NULL /* 100%�޼��ڼ� */
);

ALTER TABLE Challenges
	ADD
		CONSTRAINT PK_Challenges
		PRIMARY KEY (
			ChalNo
		);

/* ç������� */
CREATE TABLE ChallengeComments (
	ChalCommentNo NUMBER NOT NULL, /* ç������۹�ȣ */
	ChalNo NUMBER NOT NULL, /* ç������ȣ */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	ChalCommentContent CLOB NOT NULL, /* ç������۳��� */
	ChalCommentDate DATE DEFAULT sysdate NOT NULL /* ç��������ۼ��� */
);

ALTER TABLE ChallengeComments
	ADD
		CONSTRAINT PK_ChallengeComments
		PRIMARY KEY (
			ChalCommentNo
		);

/* ��ġ�ݳ��� */
CREATE TABLE DepositTransactions (
	DepositTransNo NUMBER NOT NULL, /* ��ġ�ݳ�����ȣ */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	DepositAmount NUMBER, /* ��ġ�ݰ����ݾ� */
	DepositPayDate DATE DEFAULT SYSDATE, /* ��ġ�ݰ����� */
	DepositContent VARCHAR2(100), /* ��ġ�ݰ������� */
	DepositBalance NUMBER /* ��ġ���ܾ� */
);

ALTER TABLE DepositTransactions
	ADD
		CONSTRAINT PK_DepositTransactions
		PRIMARY KEY (
			DepositTransNo
		);

/* QA�Խ��� */
CREATE TABLE QABoard (
	QANo NUMBER NOT NULL, /* QA�۹�ȣ */
	QATitle VARCHAR2(100) NOT NULL, /* QA������ */
	QAContent CLOB NOT NULL, /* QA���� */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	QADate DATE DEFAULT sysdate NOT NULL, /* QA�ۼ��� */
	QAHit NUMBER DEFAULT 0 NOT NULL /* QA��ȸ�� */
);

ALTER TABLE QABoard
	ADD
		CONSTRAINT PK_QABoard
		PRIMARY KEY (
			QANo
		);

/* QA��� */
CREATE TABLE QAComments (
	QACommentNo NUMBER NOT NULL, /* QA��۹�ȣ */
	QACommentContent CLOB NOT NULL, /* QA��۳��� */
	QACommentDate DATE DEFAULT sysdate NOT NULL, /* QA����ۼ��� */
	QANo NUMBER NOT NULL /* QA�۹�ȣ */
);

ALTER TABLE QAComments
	ADD
		CONSTRAINT PK_QAComments
		PRIMARY KEY (
			QACommentNo
		);

/* ȸ����� */
CREATE TABLE UserGrade (
	MemberGradeName VARCHAR2(50) NOT NULL, /* ȸ����� */
	MemberGradeDesc VARCHAR2(100) NOT NULL, /* ȸ����޻󼼼��� */
	MemberGradeRequirement VARCHAR2(50) NOT NULL /* ȸ��������� */
);

ALTER TABLE UserGrade
	ADD
		CONSTRAINT PK_UserGrade
		PRIMARY KEY (
			MemberGradeName
		);

/* QA���� */
CREATE TABLE QABoardFile (
	QAFileNo NUMBER NOT NULL, /* QA���Ϲ�ȣ */
	QANo NUMBER NOT NULL, /* QA�۹�ȣ */
	QAFileName VARCHAR2(100) NOT NULL /* QA�����̸� */
);

ALTER TABLE QABoardFile
	ADD
		CONSTRAINT PK_QABoardFile
		PRIMARY KEY (
			QAFileNo
		);

/* ç��������ȸ���α� */
CREATE TABLE ChalParticipantLogs (
	ChalAuthNo Number NOT NULL, /* ç���������α׹�ȣ */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	ChalAuthDate DATE DEFAULT sysdate NOT NULL, /* ç������������� */
	ChalNo NUMBER NOT NULL /* ç������ȣ */
);

ALTER TABLE ChalParticipantLogs
	ADD
		CONSTRAINT PK_ChalParticipantLogs
		PRIMARY KEY (
			ChalAuthNo
		);

/* �޼������� */
CREATE TABLE MemberAchievement (
	MemberAchievementNo NUMBER NOT NULL, /* ȸ��������ȣ */
	MemberId VARCHAR2(50) NOT NULL, /* ȸ�����̵� */
	ChalNo NUMBER, /* ç������ȣ */
	AchievementRate  NUMBER DEFAULT 0 /* �޼��� */
);

ALTER TABLE MemberAchievement
	ADD
		CONSTRAINT PK_MemberAchievement
		PRIMARY KEY (
			MemberAchievementNo
		);

ALTER TABLE Challenges
	ADD
		CONSTRAINT FK_Members_TO_Challenges
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		);

ALTER TABLE ChallengeComments
	ADD
		CONSTRAINT FK_Members_TO_ChalComments
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		)
		ON DELETE CASCADE;

ALTER TABLE ChallengeComments
	ADD
		CONSTRAINT FK_Challenges_TO_ChalComments
		FOREIGN KEY (
			ChalNo
		)
		REFERENCES Challenges (
			ChalNo
		)
		ON DELETE CASCADE;

ALTER TABLE DepositTransactions
	ADD
		CONSTRAINT FK_Members_TO_DepositTrans
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		)
		ON DELETE CASCADE;

ALTER TABLE QABoard
	ADD
		CONSTRAINT FK_Members_TO_QABoard
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		)
		ON DELETE CASCADE;

ALTER TABLE QAComments
	ADD
		CONSTRAINT FK_QABoard_TO_QAComments
		FOREIGN KEY (
			QANo
		)
		REFERENCES QABoard (
			QANo
		)
		ON DELETE CASCADE;

ALTER TABLE QABoardFile
	ADD
		CONSTRAINT FK_QABoard_TO_QABoardFile
		FOREIGN KEY (
			QANo
		)
		REFERENCES QABoard (
			QANo
		)
		ON DELETE CASCADE;

ALTER TABLE ChalParticipantLogs
	ADD
		CONSTRAINT FK_Challenges_TO_ChalPartLogs
		FOREIGN KEY (
			ChalNo
		)
		REFERENCES Challenges (
			ChalNo
		)
		ON DELETE CASCADE;

ALTER TABLE ChalParticipantLogs
	ADD
		CONSTRAINT FK_Members_TO_ChalPartLogs
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		)
		ON DELETE CASCADE;

ALTER TABLE MemberAchievement
	ADD
		CONSTRAINT FK_Challenges_TO_MemAchieve
		FOREIGN KEY (
			ChalNo
		)
		REFERENCES Challenges (
			ChalNo
		)
		ON DELETE CASCADE;

ALTER TABLE MemberAchievement
	ADD
		CONSTRAINT FK_Members_TO_MemAchieve
		FOREIGN KEY (
			MemberId
		)
		REFERENCES Members (
			MemberId
		)
		ON DELETE CASCADE;
        
CREATE SEQUENCE chalno_seq
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE chalfileno_seq
    START WITH 1
    INCREMENT BY 1;    
    
CREATE SEQUENCE chalcommentno_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE chalauthno_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE MemberAchievementNo_seq
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE DepositTransNo_seq
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE QAno_seq
    START WITH 1
    INCREMENT BY 1; 

CREATE SEQUENCE QAFileNO_seq
    START WITH 1
    INCREMENT BY 1;            
    
CREATE SEQUENCE QACOMMENTNO_seq
    START WITH 1
    INCREMENT BY 1;        


CREATE OR REPLACE TRIGGER trg_UpdateMemberAchievement
BEFORE INSERT ON ChalParticipantLogs
FOR EACH ROW
DECLARE
  v_TotalDays NUMBER;
  v_AchievementCount NUMBER;
  v_AchievementRate NUMBER;
BEGIN
  -- �ش� ç������ �� �Ⱓ ��� (Challenges ���̺�κ���)
  SELECT ChalEndDate - ChalStartDate + 1 INTO v_TotalDays
  FROM Challenges
  WHERE ChalNo = :NEW.ChalNo;
  
  -- �ش� ç������ ���� ���� Ƚ�� ��� (ChalParticipantLogs ���̺�κ���)
  SELECT COUNT(*) + 1 INTO v_AchievementCount
  FROM ChalParticipantLogs
  WHERE ChalNo = :NEW.ChalNo AND MemberId = :NEW.MemberId;

  -- �޼��� ���
  IF v_TotalDays > 0 THEN
    v_AchievementRate := (v_AchievementCount / v_TotalDays) * 100;
  ELSE
    v_AchievementRate := 0;
  END IF;

  -- ������Ʈ�� �޼����� MemberAchievement ���̺� �����ϰų� �� ���ڵ带 �߰�
  UPDATE MemberAchievement
  SET AchievementRate = v_AchievementRate
  WHERE ChalNo = :NEW.ChalNo AND MemberId = :NEW.MemberId;

  IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO MemberAchievement (MemberAchievementNo, MemberId, ChalNo, AchievementRate)
    VALUES (MemberAchievementNo_seq.NEXTVAL, :NEW.MemberId, :NEW.ChalNo, v_AchievementRate);
  END IF;
  
  -- ���� ���� Challenges ���̺� ������Ʈ
  UPDATE Challenges
  SET SuccessParticipants85 = (
    SELECT COUNT(*)
    FROM MemberAchievement
    WHERE ChalNo = :NEW.ChalNo AND AchievementRate >= 85 AND AchievementRate < 100
  ),
  SuccessParticipants100 = (
    SELECT COUNT(*)
    FROM MemberAchievement
    WHERE ChalNo = :NEW.ChalNo AND AchievementRate >= 100
  )
  WHERE ChalNo = :NEW.ChalNo;
END;
drop procedure PROCESS_CHAL_DEPO_PROC;
CREATE OR REPLACE PROCEDURE PROCESS_CHAL_DEPO_PROC AS
  v_chal_no Challenges.chalno%TYPE;
  v_chal_fee Challenges.chalfee%TYPE;
  v_success_participants_85 Challenges.successparticipants85%TYPE;
  v_success_participants_100 Challenges.successparticipants100%TYPE;
  v_total_fee Challenges.chaltotalfee%TYPE;
  v_return_amount Challenges.chaltotalfee%TYPE;
BEGIN
  FOR chal_rec IN (SELECT chalno, chalfee, successparticipants85, successparticipants100, chaltotalfee
                   FROM challenges
                   WHERE chalstatus = '1'
                   AND chalenddate <= SYSDATE) -- Consider only active challenges that have ended
  LOOP
    v_chal_no := chal_rec.chalno;
    v_chal_fee := chal_rec.chalfee;
    v_success_participants_85 := chal_rec.successparticipants85;
    v_success_participants_100 := chal_rec.successparticipants100;
    v_total_fee := chal_rec.chaltotalfee;
    
    -- Calculate the return amount per 100% achiever
    v_return_amount := (v_total_fee - (v_success_participants_85 * v_chal_fee)) / v_success_participants_100;
    
    -- Process 85% <= AchievementRate < 100%
    FOR ach_rec IN (SELECT ma.memberid, ma.achievementrate
                    FROM memberachievement ma
                    WHERE ma.chalno = v_chal_no
                      AND ma.achievementrate >= 85
                      AND ma.achievementrate < 100)
    LOOP
      UPDATE members m
      SET m.memberdeposit = m.memberdeposit + v_chal_fee
      WHERE m.memberid = ach_rec.memberid;
      
      -- Insert into deposittransactions table for 85% <= AchievementRate < 100%
      INSERT INTO deposittransactions (deposittransno, memberid, depositamount, depositcontent, depositbalance)
      SELECT deposittransno_seq.NEXTVAL, ach_rec.memberid, v_chal_fee, 'ç���� �޼� ����', m.memberdeposit
      FROM members m
      WHERE m.memberid = ach_rec.memberid;
      
      
    END LOOP;
    
    -- Process 100% AchievementRate
    FOR ach_rec IN (SELECT ma.memberid, ma.achievementrate
                    FROM memberachievement ma
                    WHERE ma.chalno = v_chal_no
                      AND ma.achievementrate >= 100)
    LOOP
      UPDATE members m
      SET m.memberdeposit = m.memberdeposit + v_return_amount
      WHERE m.memberid = ach_rec.memberid;
      
      -- Insert into deposittransactions table for 100% AchievementRate
      INSERT INTO deposittransactions (deposittransno, memberid, depositamount, depositcontent, depositbalance)
      SELECT deposittransno_seq.NEXTVAL, ach_rec.memberid, v_return_amount, 'ç���� 100% �޼� ����', m.memberdeposit
      FROM members m
      WHERE m.memberid = ach_rec.memberid;
    END LOOP;
    
    -- Set challenge status to 0 after distributing deposits
    UPDATE challenges
    SET chalstatus = '0'
    WHERE chalno = v_chal_no;
  END LOOP;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'PROCESS_CHALLENGE_JOB',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'PROCESS_CHAL_DEPO_PROC',
    start_date      => TO_TIMESTAMP('2023-07-28 00:00:01', 'YYYY-MM-DD HH24:MI:SS'),
    repeat_interval => 'FREQ=DAILY; BYHOUR=00; BYMINUTE=01; BYSECOND=0;',
    enabled         => TRUE,
    comments        => 'Process challenge deposits job');
END;
/

select c.chaltitle, c.chalcontent, c.ChalStatus, Round(m.AchievementRate,2), m.memberid
from Challenges c join MemberAchievement m
on c.chalno = m.chalno where m.memberid='yjkim';

SELECT mem.memberid, mem.membergradename, mem.membername,
		(SELECT COUNT(*)
		FROM MEMBERACHIEVEMENT a
		JOIN challenges c ON a.chalno =
		c.chalno
		WHERE a.memberId = mem.memberId
		AND c.CHALENDDATE < SYSDATE
		AND a.achievementrate >= 85
		) AS achievementcount
		FROM members mem
		where memberid='yjkim';
        
        select c.chaltitle, c.chalcontent, c.ChalStatus,
		Round(m.AchievementRate,2), m.memberid
		from Challenges c join MemberAchievement m
		on c.chalno = m.chalno where m.memberid='yjkim';
        
commit;
select * from DepositTransactions;
insert into DepositTransactions values(DepositTransNo_seq.nextval, 'yjkim', -5000, sysdate, 'ç���� ����', 110100);
insert into DepositTransactions values(DepositTransNo_seq.nextval, 
	#{param1}, ${param2}, sysdate, 'ç���� ����', ${param3});
commit;