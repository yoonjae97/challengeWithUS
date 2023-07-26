package com.smart.home.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smart.home.dto.DepositDTO;


public interface DepositService {

	public int getmyBalance(String memberId);
	public List<DepositDTO> getMyDepositTransactions(String memberId);
}
