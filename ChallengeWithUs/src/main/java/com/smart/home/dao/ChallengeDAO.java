package com.smart.home.dao;

import java.util.List;


import com.smart.home.dto.ChallengeDTO;


public interface ChallengeDAO {
	//ç���� ���
	public int registerChal(ChallengeDTO cDTO);
	
	//��� ç���� ��ȸ
	public List<ChallengeDTO> getAllChallenges();
	
	
}
