package com.smart.home.dto;

import lombok.Data;

@Data
public class MemberGradeDTO {
	// 회원등급이름(Basic 또는 Leader)
	private String memberGradeName;
	
	// 회원등급 상세설명
    private String memberGradeDesc;
    
    // 회원등급 조건
    private String memberGradeRequirement;
}
