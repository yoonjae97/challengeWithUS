package com.smart.home.service;


import java.util.List;

import com.smart.home.dto.ChallengeDTO;
import com.smart.home.dto.MemberAchievementDTO;

public interface MemberAchievementService {
	
	//�α��� �Ǿ��ִ� ������� �޼����� ç���� ���� �ҷ�����
	public List<ChallengeDTO> getMyAchievementsRate(ChallengeDTO cDTO);
	
	// �α��� �Ǿ��ִ� ������� ç���� �޼� Ƚ��
	public int getmyAchievementCnt(String memberId);
	
	// �α��� �Ǿ��ִ� ������� ȸ����� 
	public String getmyGrade(String memberId);

	
}
