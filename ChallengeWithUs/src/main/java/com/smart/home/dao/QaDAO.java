package com.smart.home.dao;

import com.smart.home.dto.QaDTO;
import java.util.List;
//���� �ۼ� ��
public interface QaDAO {
	// ��� ���Ǳ� ��������
    List<QaDTO> getAllQa();  
    
    // Ư�� ������� ���Ǳ� ��������
    List<QaDTO> getMyQaList(String memberId);  
    
    // ���Ǳ� �ۼ�
    void insertQa(QaDTO qa);  
    
    // ���Ǳ� ����
    void updateQa(QaDTO qa);  
    
    // ���Ǳ� ����
    void deleteQa(int qaNo);  
}
