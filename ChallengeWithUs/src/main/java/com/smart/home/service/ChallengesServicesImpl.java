package com.smart.home.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smart.home.dao.ChallengesDAO;
import com.smart.home.dto.ChallengesDTO;

@Service
public class ChallengesServicesImpl implements ChallengesService {

	@Autowired
	ChallengesDAO dao;
	
	@Override
	public List<ChallengesDTO> ChallengesList() {
		return dao.ChallengesList();
	}

}
