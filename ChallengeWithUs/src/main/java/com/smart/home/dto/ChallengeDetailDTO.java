package com.smart.home.dto;

import lombok.Data;

//���� ç���� ���������� MemberId(ȸ�����̵�)�� �������� �Ͽ� 
//MemberGrade(ȸ�����)�� AchievementCnt(ç���� �޼�Ƚ��)�� ���������� �����ش�.
@Data
public class ChallengeDetailDTO {
    //==ȸ�����==
    private String memberGrade;
    
    //==ç���� �޼�Ƚ��==(ç���� �޼�Ƚ���� ç���� �� MemberAchievementRate(�޼���)�� 85% �̻��� ���� �޼��� ������ �Ѵ�.)
    private int achievement_count;
  
}
