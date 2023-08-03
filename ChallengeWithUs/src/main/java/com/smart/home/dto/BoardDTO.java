package com.smart.home.dto;

import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {
	private int qaNo;
	private String qaTitle;
	private String qaContent;
	private String memberId;
	private String qaDate;
	private int qaHit;
	//������ ���ϸ�
	private List<String> delFile;
	
}

