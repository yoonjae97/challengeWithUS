package com.smart.home.dao;

import java.util.List;

import com.smart.home.dto.ChallengeDTO;
import com.smart.home.dto.MemberAchievementDTO;

public interface MemberAchievementDAO {
    // �޼��� ��ȸ
	List<ChallengeDTO> getAchievementRate(ChallengeDTO cDTO);
	
	// �޼� Ƚ�� ��ȸ
	int getAchievementCnt(String memberId);
	
	// ȸ�� ��� ��ȸ 
	String getGrade(String memberId);
	
	
	// �޼��� ������Ʈ(Ư�� ���ǿ��� Ʈ���Ű� �۵��� �� �ڵ����� ������Ʈ) 	
	
	// �޼��� ����
}
