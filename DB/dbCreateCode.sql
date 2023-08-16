/* 회원정보 */
CREATE TABLE Members (
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	MemberPwd VARCHAR2(50) NOT NULL, /* 회원비밀번호 */
	MemberAddr VARCHAR2(100), /* 회원주소 */
	MemberEmail VARCHAR2(100) NOT NULL, /* 회원이메일 */
	MemberName VARCHAR2(50) NOT NULL, /* 회원이름 */
	MemberTel VARCHAR2(20), /* 회원전화번호 */
	MemberBirth VARCHAR2(20), /* 회원생년월일 */
	MemberGender VARCHAR(5), /* 회원성별 */
	MemberGradeName VARCHAR2(50) NOT NULL, /* 회원등급 */
	MemberDeposit NUMBER DEFAULT 0 /* 회원예치금 */
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

/* 챌린지정보 */
CREATE TABLE Challenges (
	ChalNo NUMBER NOT NULL, /* 챌린지번호 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	ChalTitle VARCHAR2(100) NOT NULL, /* 챌린지제목 */
	ChalContent CLOB NOT NULL, /* 챌린지내용 */
	ParticipantsCnt NUMBER DEFAULT 0 NOT NULL, /* 챌린지참가자수 */
	ChalFee NUMBER NOT NULL, /* 챌린지참가비 */
	ChalTotalFee NUMBER DEFAULT 0 NOT NULL, /* 챌린지총참가비 */
	ChalStartDate DATE NOT NULL, /* 챌린지시작일 */
	ChalEndDate DATE NOT NULL, /* 챌린지종료일 */
	ChalStatus CHAR(1) DEFAULT 0 NOT NULL, /* 챌린지활성화여부 */
	ChalFileName VARCHAR2(100), /* 첼린지파일이름 */
	SuccessParticipants85 NUMBER DEFAULT 0 NOT NULL, /* 85%이상100%미만달성자수 */
	SuccessParticipants100 NUMBER DEFAULT 0 NOT NULL /* 100%달성자수 */
);

ALTER TABLE Challenges
	ADD
		CONSTRAINT PK_Challenges
		PRIMARY KEY (
			ChalNo
		);

/* 챌린지댓글 */
CREATE TABLE ChallengeComments (
	ChalCommentNo NUMBER NOT NULL, /* 챌린지댓글번호 */
	ChalNo NUMBER NOT NULL, /* 챌린지번호 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	ChalCommentContent CLOB NOT NULL, /* 챌린지댓글내용 */
	ChalCommentDate DATE DEFAULT sysdate NOT NULL /* 챌린지댓글작성일 */
);

ALTER TABLE ChallengeComments
	ADD
		CONSTRAINT PK_ChallengeComments
		PRIMARY KEY (
			ChalCommentNo
		);

/* 예치금내역 */
CREATE TABLE DepositTransactions (
	DepositTransNo NUMBER NOT NULL, /* 예치금내역번호 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	DepositAmount NUMBER, /* 예치금결제금액 */
	DepositPayDate DATE DEFAULT SYSDATE, /* 예치금결제일 */
	DepositContent VARCHAR2(100), /* 예치금결제내용 */
	DepositBalance NUMBER /* 예치금잔액 */
);

ALTER TABLE DepositTransactions
	ADD
		CONSTRAINT PK_DepositTransactions
		PRIMARY KEY (
			DepositTransNo
		);

/* QA게시판 */
CREATE TABLE QABoard (
	QANo NUMBER NOT NULL, /* QA글번호 */
	QATitle VARCHAR2(100) NOT NULL, /* QA글제목 */
	QAContent CLOB NOT NULL, /* QA내용 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	QADate DATE DEFAULT sysdate NOT NULL, /* QA작성일 */
	QAHit NUMBER DEFAULT 0 NOT NULL /* QA조회수 */
);

ALTER TABLE QABoard
	ADD
		CONSTRAINT PK_QABoard
		PRIMARY KEY (
			QANo
		);

/* QA댓글 */
CREATE TABLE QAComments (
	QACommentNo NUMBER NOT NULL, /* QA댓글번호 */
	QACommentContent CLOB NOT NULL, /* QA댓글내용 */
	QACommentDate DATE DEFAULT sysdate NOT NULL, /* QA댓글작성일 */
	QANo NUMBER NOT NULL /* QA글번호 */
);

ALTER TABLE QAComments
	ADD
		CONSTRAINT PK_QAComments
		PRIMARY KEY (
			QACommentNo
		);

/* 회원등급 */
CREATE TABLE UserGrade (
	MemberGradeName VARCHAR2(50) NOT NULL, /* 회원등급 */
	MemberGradeDesc VARCHAR2(100) NOT NULL, /* 회원등급상세설명 */
	MemberGradeRequirement VARCHAR2(50) NOT NULL /* 회원등급조건 */
);

ALTER TABLE UserGrade
	ADD
		CONSTRAINT PK_UserGrade
		PRIMARY KEY (
			MemberGradeName
		);

/* QA파일 */
CREATE TABLE QABoardFile (
	QAFileNo NUMBER NOT NULL, /* QA파일번호 */
	QANo NUMBER NOT NULL, /* QA글번호 */
	QAFileName VARCHAR2(100) NOT NULL /* QA파일이름 */
);

ALTER TABLE QABoardFile
	ADD
		CONSTRAINT PK_QABoardFile
		PRIMARY KEY (
			QAFileNo
		);

/* 챌린지참가회원로그 */
CREATE TABLE ChalParticipantLogs (
	ChalAuthNo Number NOT NULL, /* 챌린지인증로그번호 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	ChalAuthDate DATE DEFAULT sysdate NOT NULL, /* 챌린지인증기록일 */
	ChalNo NUMBER NOT NULL /* 챌린지번호 */
);

ALTER TABLE ChalParticipantLogs
	ADD
		CONSTRAINT PK_ChalParticipantLogs
		PRIMARY KEY (
			ChalAuthNo
		);

/* 달성률정보 */
CREATE TABLE MemberAchievement (
	MemberAchievementNo NUMBER NOT NULL, /* 회원인증번호 */
	MemberId VARCHAR2(50) NOT NULL, /* 회원아이디 */
	ChalNo NUMBER, /* 챌린지번호 */
	AchievementRate  NUMBER DEFAULT 0 /* 달성률 */
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
  -- 해당 챌린지의 총 기간 계산 (Challenges 테이블로부터)
  SELECT ChalEndDate - ChalStartDate + 1 INTO v_TotalDays
  FROM Challenges
  WHERE ChalNo = :NEW.ChalNo;
  
  -- 해당 챌린지에 대한 인증 횟수 계산 (ChalParticipantLogs 테이블로부터)
  SELECT COUNT(*) + 1 INTO v_AchievementCount
  FROM ChalParticipantLogs
  WHERE ChalNo = :NEW.ChalNo AND MemberId = :NEW.MemberId;

  -- 달성률 계산
  IF v_TotalDays > 0 THEN
    v_AchievementRate := (v_AchievementCount / v_TotalDays) * 100;
  ELSE
    v_AchievementRate := 0;
  END IF;

  -- 업데이트된 달성률을 MemberAchievement 테이블에 저장하거나 새 레코드를 추가
  UPDATE MemberAchievement
  SET AchievementRate = v_AchievementRate
  WHERE ChalNo = :NEW.ChalNo AND MemberId = :NEW.MemberId;

  IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO MemberAchievement (MemberAchievementNo, MemberId, ChalNo, AchievementRate)
    VALUES (MemberAchievementNo_seq.NEXTVAL, :NEW.MemberId, :NEW.ChalNo, v_AchievementRate);
  END IF;
  
  -- 집계 값을 Challenges 테이블에 업데이트
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
      SELECT deposittransno_seq.NEXTVAL, ach_rec.memberid, v_chal_fee, '챌린지 달성 보상', m.memberdeposit
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
      SELECT deposittransno_seq.NEXTVAL, ach_rec.memberid, v_return_amount, '챌린지 100% 달성 보상', m.memberdeposit
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
insert into DepositTransactions values(DepositTransNo_seq.nextval, 'yjkim', -5000, sysdate, '챌린지 참여', 110100);
insert into DepositTransactions values(DepositTransNo_seq.nextval, 
	#{param1}, ${param2}, sysdate, '챌린지 참여', ${param3});
commit;