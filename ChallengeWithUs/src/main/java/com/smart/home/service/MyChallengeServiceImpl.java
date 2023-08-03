package com.smart.home.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smart.home.dao.MyChallengeDAO;
import com.smart.home.dto.MyChallengeCntDTO;
import com.smart.home.dto.MyChallengeDTO;

@Service
public class MyChallengeServiceImpl implements MyChallengeService {

	@Autowired
	MyChallengeDAO dao;
	
	@Override
	public MyChallengeCntDTO MyChallengeCnt(String lodId) {
		return dao.MyChallengeCnt(lodId);
	}

	@Override
	public List<MyChallengeDTO> MyChallengeList(String lodId) {
		return dao.MyChallengeList(lodId);
	}

}
