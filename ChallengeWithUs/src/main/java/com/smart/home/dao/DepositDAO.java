
package com.smart.home.dao;

import java.util.List;


import com.smart.home.dto.DepositDTO;

public interface DepositDAO {
	
	// ��ġ�� �ܾ� ��ȸ�ϱ�
    int getMyBalance(String memberId);
    
    // ��ġ�� �ŷ� ���� ��������
    List<DepositDTO> getMyDepositTransactions(String memberId);
    
    // ��ġ�� �����ϱ� (�̹� ���ǵǾ� ����)
    
}

