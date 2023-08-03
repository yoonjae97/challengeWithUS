package com.smart.home.dao;

import java.util.List;
import com.smart.home.dto.BoardDTO;
import com.smart.home.dto.QaBoardFileDTO;
import com.smart.home.dto.PagingDTO;

public interface BoardDAO {
	// �۵�� 
	public int boardWriteOk(BoardDTO dto);
	// �۸�ϼ��� (paging, search)
	public List<BoardDTO> boardList(PagingDTO pDTO);
	// �� ���ڵ� ��
	public int totalRecord(PagingDTO pDTO);
	public void hitCount(int no);
	//���ϸ� ���
	public int qaboardfileInsert(List<QaBoardFileDTO> fileList);
	// �� ����(update)
	public int boardEdit(BoardDTO dto);
	//�� ����
	public int boardDel(int no, String memberId);
	//÷������ ��� ����
	public int qaboardfileDelete(int no);
	//�ش���� ÷�� ���� ����
	public List<QaBoardFileDTO> qaboardfileSelect(int no);
	public BoardDTO boardSelect(int no);


	
}
