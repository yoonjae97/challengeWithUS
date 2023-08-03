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

// ������������ �� ç����, ��ġ�� ����, qa�Խ���, ȸ������ ���� ����� �����ϴ� controller
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

	// ��ġ�� ���� �������� �̵�
	@GetMapping("/myDeposit")
	public ModelAndView getMyDeposit(HttpSession session) {

		// 1. �α��� ������� ���̵� (���ǿ��� �޾ƿ��Ƿ� ���� �޾ƿ� �ʿ䰡 ����.)
		String memberId = (String) session.getAttribute("logId");

		// 2. �α��� ������� ��ġ�ݿ� ���� ������ ��ġ�� ������ �޾ƿ´�.
		List<PayDTO> list = pservice.GetPayList(memberId);
		MemberDTO dto = memservice.getMember(memberId);
		// Model And view
		ModelAndView mav = new ModelAndView();

		// 3. <��ġ�� ����>�� ������ �α��� ������� ���̵�, �� ��ġ��, �����ϱ�(��ư)
		mav.addObject("mdto", dto);
		mav.addObject("list", list); // �α��� ������� ���̵�
		mav.setViewName("mypage/myaccount");

		return mav;
	}

	// ȸ������ ������ �̵� ->
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

	// ȸ������ ���� ->
	@PostMapping("/myInfoOk")
	@ResponseBody
	public String MemberUpdateOk(MemberDTO dto) {
		int result = 0;
		ModelAndView mav = new ModelAndView();

		// db���� null �� ������ �Ӽ��� ���ؼ� mapper ������ �߻���Ű�� �ʱ� ���� null ��� "" ó��
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
	
	// �� ç���� �Խ������� �̵�
	@GetMapping("/myChallenge")
	public ModelAndView myChallenge(HttpSession session) {
		ModelAndView mav = new ModelAndView();	
		String lodId = (String)session.getAttribute("logId");
		
		MyChallengeCntDTO dto = mcservice.MyChallengeCnt(lodId); // ������� ������ ç������ ī��Ʈ�ؼ� �����ɴϴ�.
		List<MyChallengeDTO> list = mcservice.MyChallengeList(lodId); // ���� �������� ç������ ��ȸ

		mav.addObject("dto", dto);
		mav.addObject("list", list);
		mav.setViewName("mypage/myChallenge");
		return mav;
	}
	
	// ��ġ�� ���� ȭ��
	@GetMapping("/payForm")
	public ModelAndView payForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mypage/PayForm");
		return mav;
	}
	
	// ��ġ�� ���� ��û
	@PostMapping("/PayRequest")
	@ResponseBody
	public String PayRequest(PayDTO dto, HttpSession session) {
		// ���� �α��� ���� Ȯ��
		String logId = (String)session.getAttribute("logId");
		if (logId == "" || logId == null) {
			return "needlogin";
		}
		try {
			int nowMemberDeposit = service.GetDeposit((String)session.getAttribute("logId")); // ���� ���̵��� ��ġ�� �ܾ� ��ȸ
			nowMemberDeposit += dto.getDepositAmount();
			dto.setMemberId((String)session.getAttribute("logId"));
			service.MemberDepositUpdate(dto); // ��ġ�� �ܾ� ����
			dto.setDepositBalance(nowMemberDeposit); 
			dto.setDepositContent("��ġ�� ����");
			service.DepositInsert(dto); // ��ġ�� �ŷ����� �Խ��ǿ� ������ ����
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return "fail";
	}
	
	
}
