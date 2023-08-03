package com.smart.home.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smart.home.dto.ChallengeReplyDTO;
import com.smart.home.service.ChallengeReplyService;

// ç���� �Խ��� ��� �ۼ��� ���� ����� �����ϴ� controller
@Controller
@RequestMapping("/yj")
public class ChallengeReplyController {
	
	@Autowired
	ChallengeReplyService service;
	
	// ç���� �Խ��� ��� �ۼ�
	@PostMapping("/ChallengeReplyWrite")
	@ResponseBody
	public String ChallengeReplyWrite(ChallengeReplyDTO dto, HttpSession session) {
		dto.setMemberId((String)session.getAttribute("logId"));
		int result = service.ChallengeReplyInsert(dto); // db ç���� ��� ���̺� ��� �߰�
		return result+"";
	}
	
	// ç���� �Խ��� ��� ����Ʈ ȣ��
	@GetMapping("/ChallengeReplyList")
	@ResponseBody
	public List<ChallengeReplyDTO> ChallengeReplyList(int chalNo) { // ���۱۹�ȣ
		return service.ChallengeReplyList(chalNo); // db���� �ش� ç������ ��� ����Ʈ ��ȸ

	}
	
	// ç���� �Խ��� ��� ����
	@PostMapping("/ChallengeReplyEditOk")
	@ResponseBody
	public int ChallengeReplyEditOk(ChallengeReplyDTO dto) {
		return service.ChallengeReplyEditOk(dto); // db ��� ����
		
	}
	
	// ç���� �Խ��� ��� ����
	@GetMapping("/ChallengeReplyDel")
	@ResponseBody
	public int ChallengeReplyDel(int chalNo) {
		return service.ChallengeReplyDel(chalNo); // db���� ��� ����
	}
}
