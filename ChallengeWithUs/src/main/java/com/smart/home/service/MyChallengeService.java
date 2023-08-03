package com.smart.home.service;

import java.util.List;

import com.smart.home.dto.MyChallengeCntDTO;
import com.smart.home.dto.MyChallengeDTO;

public interface MyChallengeService {

	MyChallengeCntDTO MyChallengeCnt(String lodId);

	List<MyChallengeDTO> MyChallengeList(String lodId);

}
