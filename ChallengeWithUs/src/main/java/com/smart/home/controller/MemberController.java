package com.smart.home.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.smart.home.dto.MemberDTO;
import com.smart.home.service.MemberService;

// 회원가입, 정보 수정, 로그인, 로그아웃 관련된 기능을 지원하는 controller
@Controller
@RequestMapping("/register")
public class MemberController {

	@Autowired
	MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	// 회원가입 폼으로 이동
	@GetMapping("/registerJoin")
	public String MemberRegForm() {
		return "register/registerJoin";
	}

	// 회원가입 확인
	@PostMapping("registerJoinOk")
	@ResponseBody
	public String MemberRegOk(MemberDTO dto) {
		int result = 0;
		ModelAndView mav = new ModelAndView();
		// 주소가 나눠져있기 때문에 하나로 합치기
		dto.setMemberAddr(dto.getZipcode(), dto.getZipcodeSub(), dto.getStreetAdr(), dto.getDetailAdr());

		// db에서 null 값 가능한 속성에 대해서 mapper 오류를 발생시키지 않기 위해 null 대신 "" 처리
		if(dto.getMemberGender()==null) {
			dto.setMemberGender("");
		}
		if(dto.getMemberTel()==null) {
			dto.setMemberTel("");
		}
		if(dto.getMemberAddr()==null) {
			dto.setMemberAddr("", "", "", "");
		}
		if(dto.getMemberBirth()==null) {
			dto.setMemberBirth("");
		}
		
		// 결과 반환
		try {
			result = service.MemberInsert(dto); // db에 회원 정보 삽입

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원가입실패" + e.getMessage());		}	
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 로그인 화면으로 이동
	@GetMapping("/login")
	public String login() {
		return "register/LoginPage";
	}

	// 로그인
	@PostMapping("/loginOk")
	@ResponseBody
	public String loginOk(String memberId, String memberPwd, HttpSession session) {
		
		// 로그인시 Session에 필요한 값들 설정
		try {
			MemberDTO dto = service.loginOk(memberId, memberPwd);
			session.setAttribute("logId", dto.getMemberId());
			session.setAttribute("logName", dto.getMemberName());
			session.setAttribute("logStatus", "Y");
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "failure";
		}

	}

	// 로그아웃
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}

	// 아이디 찾기 화면으로 이동
	@GetMapping("/findIdForm")
	public String findIdForm() {
		return "register/FindID";
	}

	// 아이디 찾아서 아이디만 반환
	@PostMapping("/findId")
	public ModelAndView findId(String memberName, String memberEmail) {
		String memberId = null;
		ModelAndView mav = new ModelAndView();
		
		// 아이디 찾기
		try {
			memberId = service.findId(memberName, memberEmail); // db 아이디 존재여부 확인

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 찾은 아이디에 따른 결과 반환
		if (memberId == null | memberId == "") {
			mav.addObject("message", "입력하신 이름 혹은 이메일이 일치하지 않습니다.");
			mav.setViewName("register/FindID");
		} else {
			mav.addObject("MemberId", memberId);
			mav.setViewName("register/FindIdForm");
		}

		return mav;
	}

	// 아이디 중복 체크
	@GetMapping("/doubleChk")
	@ResponseBody
	public Integer dupChk(String id) {
		Integer result = 0;
		String dupId = null;

		try {
			dupId = service.dupChk(id); // db에 같은 아이디 존재 여부 확인
			if (dupId == null) {
				result = 0;
			} else {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 비밀번호 찾기 페이지 이동
	@GetMapping("/pwSearch")
	public String findPwdForm() {
		return "register/pwSearch";
	}

	// 비밀번호 찾기
	@PostMapping("/findPwd")
	@ResponseBody
	public int findPwd(String memberId, String memberEmail) {
		String pwd = null;
		int result = 0;
		
		// 찾은 비밀번호가 null이 아닐 경우 메일로 전송
		try {
			pwd = service.findPwd(memberId, memberEmail); // db에서 아이디와 이메일로 비밀번호 조회
			if (pwd == null) {
				return result;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String setFrom = "winterer601@naver.com";
		String toMail = memberEmail;
		String title = "비밀번호 찾기 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "회원님의 비밀번호는 " + pwd + "입니다.";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
			result = 1;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
