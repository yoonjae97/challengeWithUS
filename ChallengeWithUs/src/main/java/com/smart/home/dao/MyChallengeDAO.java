package com.smart.home.dao;

import java.util.List;

import com.smart.home.dto.MyChallengeCntDTO;
import com.smart.home.dto.MyChallengeDTO;

public interface MyChallengeDAO {
	MyChallengeCntDTO MyChallengeCnt(String lodId);
	
	List<MyChallengeDTO> MyChallengeList(String lodId);
}
