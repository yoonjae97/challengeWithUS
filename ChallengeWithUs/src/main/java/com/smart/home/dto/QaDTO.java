package com.smart.home.dto;

import java.util.Date;

import lombok.Data;
@Data
public class QaDTO {
	// QA�۹�ȣ
	private int qaNo; 
	
	// QA������
    private String qaTitle; 
    
    // QA����
    private String qaContent; 
    
    // ȸ�����̵�
    private String memberId; 
    
    // QA�ۼ���
    private Date qaDate; 
    
    // QA��ȸ��
    private int qaHit; 

}
