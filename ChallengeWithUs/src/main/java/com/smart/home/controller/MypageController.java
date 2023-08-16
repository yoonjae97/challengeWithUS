package com.smart.home.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.smart.home.dto.MemberDTO;
import com.smart.home.dto.MyChallengeCntDTO;
import com.smart.home.dto.MyChallengeDTO;
import com.smart.home.dto.PayDTO;
import com.smart.home.service.MemberService;
import com.smart.home.service.MyChallengeService;
import com.smart.home.service.PayService;

// 마이페이지의 내 챌린지, 예치금 관리, qa게시판, 회원정보 수정 기능을 지원하는 controller
@RestController
@RequestMapping("/myPage")
public class MypageController {

	@Autowired
	PayService service;
	
	@Autowired
	private MyChallengeService mcservice;
	
	@Autowired
	private PayService pservice;

	@Autowired
	private MemberService memservice;

	// 예치금 관리 페이지로 이동
	@GetMapping("/myDeposit")
	public ModelAndView getMyDeposit(HttpSession session) {

		// 1. 로그인 사용자의 아이디 (세션에서 받아오므로 따로 받아올 필요가 없다.)
		String memberId = (String) session.getAttribute("logId");

		// 2. 로그인 사용자의 예치금에 관한 정보와 예치금 내역을 받아온다.
		List<PayDTO> list = pservice.GetPayList(memberId);
		MemberDTO dto = memservice.getMember(memberId);
		// Model And view
		ModelAndView mav = new ModelAndView();

		// 3. <예치금 관리>에 보여질 로그인 사용자의 아이디, 총 예치금, 충전하기(버튼)
		mav.addObject("mdto", dto);
		mav.addObject("list", list); // 로그인 사용자의 아이디
		mav.setViewName("mypage/myaccount");

		return mav;
	}

	// 회원수정 폼으로 이동 ->
	@GetMapping("/myInfo")
	public ModelAndView memeberUpdateForm(HttpSession session) {
		String lodId = (String) session.getAttribute("logId");
		ModelAndView mav = new ModelAndView();
		MemberDTO dto = null;
		try {
			dto = memservice.getMember(lodId);
			mav.addObject("dto", dto);
			mav.setViewName("mypage/myInfo");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 회원정보 수정 ->
	@PostMapping("/myInfoOk")
	@ResponseBody
	public String MemberUpdateOk(MemberDTO dto) {
		int result = 0;
		ModelAndView mav = new ModelAndView();

		// db에서 null 값 가능한 속성에 대해서 mapper 오류를 발생시키지 않기 위해 null 대신 "" 처리
		if (dto.getMemberGender() == null) {
			dto.setMemberGender("");
		}
		if (dto.getMemberTel() == null) {
			dto.setMemberTel("");
		}
		if (dto.getMemberAddr() == null) {
			dto.setMemberAddr("", "", "", "");
		}
		if (dto.getMemberBirth() == null) {
			dto.setMemberBirth("");
		}

		try {
			result = memservice.memberUpdate(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "fali";
		}

		if (result > 0) {
			return "success";
		} else {
			return "fail";

		}
	}
	
	// 내 챌린지 게시판으로 이동
	@GetMapping("/myChallenge")
	public ModelAndView myChallenge(HttpSession session) {
		ModelAndView mav = new ModelAndView();	
		String lodId = (String)session.getAttribute("logId");
		
		MyChallengeCntDTO dto = mcservice.MyChallengeCnt(lodId); // 현재까지 성공한 챌린지를 카운트해서 가져옵니다.
		List<MyChallengeDTO> list = mcservice.MyChallengeList(lodId); // 내가 참여중인 챌린지만 조회

		mav.addObject("dto", dto);
		mav.addObject("list", list);
		mav.setViewName("mypage/myChallenge");
		return mav;
	}
	
	// 예치금 충전 화면
	@GetMapping("/payForm")
	public ModelAndView payForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mypage/PayForm");
		return mav;
	}
	
	// 예치금 충전 요청
	@PostMapping("/PayRequest")
	@ResponseBody
	public String PayRequest(PayDTO dto, HttpSession session) {
		// 현재 로그인 여부 확인
		String logId = (String)session.getAttribute("logId");
		if (logId == "" || logId == null) {
			return "needlogin";
		}
		try {
			int nowMemberDeposit = service.GetDeposit((String)session.getAttribute("logId")); // 현재 아이디의 예치금 잔액 조회
			nowMemberDeposit += dto.getDepositAmount();
			dto.setMemberId((String)session.getAttribute("logId"));
			service.MemberDepositUpdate(dto); // 예치금 잔액 갱신
			dto.setDepositBalance(nowMemberDeposit); 
			dto.setDepositContent("예치금 충전");
			service.DepositInsert(dto); // 예치금 거래내역 게시판에 데이터 삽입
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return "fail";
	}
	
	
}
