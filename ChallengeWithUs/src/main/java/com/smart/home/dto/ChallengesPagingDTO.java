package com.smart.home.dto;

// ������ ���� ����, �˻��� ���� ����
public class ChallengesPagingDTO {
	private int nowPage = 1; // ���� ������ 
	private int onePageRecord = 5; // �� �������� ���ڵ� ��
	private int totalRecord;// �� ���ڵ� ��
	private int totalPage; // �� ������ ��
	
	private int onePageNumCount = 5; // �� �������� ǥ�õǴ� ������ ��
	private int startPageNum = 1; // ����������
	
	private int lastPageRecord = 5; // ������ �������� �����ִ� ���ڵ� ��
	private int lastNo = 0;
	private String searchKey;// �˻�Ű : subject, content, userid
	private String searchWord;// �˻��� : �Է��� ����
	
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		// �� ������ �� ����ϱ�    16->4������
		
		// ceil(), round(), floor()
		totalPage = (int)Math.ceil((double)totalRecord/onePageRecord);
		
		// ������ �������� �����ִ� ���ڵ� ��
		lastPageRecord = onePageRecord;//5
		if(totalPage==nowPage) {
			if(totalRecord%onePageRecord!=0) {
				lastPageRecord = totalRecord%onePageRecord; // 1,2,3,4 �� �ϳ��� ��
			}
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		
		// ���۹�ȣ = ((����������-1)/���������� ǥ���� ��������)*���������� ǥ���� �������� + 1
		startPageNum = ((nowPage-1)/onePageNumCount)*onePageNumCount+1; // ���������� ����
	
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	
	public int getOnePageNumCount() {
		return onePageNumCount;
	}
	public void setOnePageNumCount(int onePageNumCount) {
		this.onePageNumCount = onePageNumCount;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getLastPageRecord() {
		return lastPageRecord;
	}
	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
	public int getLastNo() {
		return lastNo;
	}
	public void setLastNo(int lastNo) {
		this.lastNo = lastNo;
	}
	@Override
	public String toString() {
		return "ChallengesPagingDTO [nowPage=" + nowPage + ", onePageRecord=" + onePageRecord + ", totalRecord="
				+ totalRecord + ", totalPage=" + totalPage + ", onePageNumCount=" + onePageNumCount + ", startPageNum="
				+ startPageNum + ", lastPageRecord=" + lastPageRecord + ", lastNo=" + lastNo + ", searchKey="
				+ searchKey + ", searchWord=" + searchWord + "]";
	}

	
	
	
	
}
