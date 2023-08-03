package com.smart.home.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smart.home.dto.DepositDTO;


public interface DepositService {
	
	// ��ġ�� �ܾ� ��ȸ
	public int getmyBalance(String memberId);
	
	// ��ġ�� ���� ��ȸ 
	public List<DepositDTO> getMyDepositTransactions(String memberId);
}
