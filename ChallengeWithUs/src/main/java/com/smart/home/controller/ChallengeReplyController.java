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

// 챌린지 게시판 댓글 작성에 관한 기능을 지원하는 controller
@Controller
@RequestMapping("/yj")
public class ChallengeReplyController {
	
	@Autowired
	ChallengeReplyService service;
	
	// 챌린지 게시판 댓글 작성
	@PostMapping("/ChallengeReplyWrite")
	@ResponseBody
	public String ChallengeReplyWrite(ChallengeReplyDTO dto, HttpSession session) {
		dto.setMemberId((String)session.getAttribute("logId"));
		int result = service.ChallengeReplyInsert(dto); // db 챌린지 댓글 테이블에 댓글 추가
		return result+"";
	}
	
	// 챌린지 게시판 댓글 리스트 호출
	@GetMapping("/ChallengeReplyList")
	@ResponseBody
	public List<ChallengeReplyDTO> ChallengeReplyList(int chalNo) { // 원글글번호
		return service.ChallengeReplyList(chalNo); // db에서 해당 챌린지의 댓글 리스트 조회

	}
	
	// 챌린지 게시판 댓글 수정
	@PostMapping("/ChallengeReplyEditOk")
	@ResponseBody
	public int ChallengeReplyEditOk(ChallengeReplyDTO dto) {
		return service.ChallengeReplyEditOk(dto); // db 댓글 수정
		
	}
	
	// 챌린지 게시판 댓글 삭제
	@GetMapping("/ChallengeReplyDel")
	@ResponseBody
	public int ChallengeReplyDel(int chalNo) {
		return service.ChallengeReplyDel(chalNo); // db에서 댓글 삭제
	}
}
