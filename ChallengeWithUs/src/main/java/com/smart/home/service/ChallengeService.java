package com.smart.home.service;

import java.util.List;

import com.smart.home.dto.ChallengeDTO;
import com.smart.home.dto.ChallengeDetailDTO;
import com.smart.home.dto.ChallengeListDTO;

public interface ChallengeService {
	
	// �α��� ������� ��� ç���� ��ȸ(ç���� �޼���, ç������, ç���� ���ϸ�, ç���� ����, ç���� ��������)
	public List<ChallengeListDTO> getAllChallenges(String memberId);
	
	// ȸ�����̵�, ȸ�����, ç���� �޼�Ƚ�� ��ȸ
	public ChallengeDetailDTO getChallengeDetail(String memberId);
	
	
}
