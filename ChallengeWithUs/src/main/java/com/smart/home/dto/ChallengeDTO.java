package com.smart.home.dto;
import lombok.Data;
import java.util.Date;

@Data
public class ChallengeDTO {
	// ç������ȣ
	private int chalNo; 
	
	// ȸ�����̵�
	private String memberId; 
	
	// ç��������
    private String chalTitle;
    
    // ç��������
    private String chalContent; 
    
    // ç���������ڼ�
    private int  participantsCnt; 
    
    // ç����������
    private int  chalFee; 
    
    // ç������������
    private int  chalTotalFee; 
    
    // ç����������
    private String chalStartDate; 
    
    // ç����������
    private String chalEndDate; 
    
    // ç����Ȱ��ȭ����
    private String chalStatus; 
    
    // 85%�̻�100%�̸��޼��ڼ�
    private int successParticipants85; 
    
    // 100%�޼��ڼ�
    private int successParticipants100; 
}

