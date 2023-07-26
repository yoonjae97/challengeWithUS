package com.smart.home.dto;

import lombok.Data;

@Data
public class MemberAchievementDTO {
	// 회원아이디
	private String memberId;
	
	// 챌린지 번호
    private int chalNo;
    
    // 챌린지 달성률
    private double achievementRate;
    
    // 챌린지 달성횟수
    private int achievement_count;
    
}
