package com.smart.home.dto;

import lombok.Data;

@Data
public class MyChallengeDTO {
	private int chalNo;
	private String chalTitle;
	private String chalContent;
	private int chalStatus;
	private int AchievementRate;
	private String memberId;
	private String chalFilename;
}
