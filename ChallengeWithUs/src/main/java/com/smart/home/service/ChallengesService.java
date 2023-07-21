package com.smart.home.service;

import java.util.List;

import com.smart.home.dto.ChallengesDTO;
import com.smart.home.dto.ChallengesPagingDTO;

public interface ChallengesService {

	public List<ChallengesDTO> ChallengesList(ChallengesPagingDTO pDTO);

	public int ChallengesTotalRecord(ChallengesPagingDTO pDTO);

	public List<ChallengesDTO> ChallengesListMore(ChallengesPagingDTO pDTO);

}
