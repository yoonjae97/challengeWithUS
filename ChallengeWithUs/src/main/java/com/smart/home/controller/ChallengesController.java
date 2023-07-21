package com.smart.home.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.smart.home.dto.ChallengesDTO;
import com.smart.home.dto.ChallengesPagingDTO;
import com.smart.home.service.ChallengesService;

@Controller
@RequestMapping("/yj")
public class ChallengesController {
	
	@Autowired
	ChallengesService service;
	
	@GetMapping("ChallengesList")
	public ModelAndView ChallengesList(ChallengesPagingDTO pDTO) {
		
		pDTO.setTotalRecord(service.ChallengesTotalRecord(pDTO));
		List<ChallengesDTO> list = service.ChallengesList(pDTO);
		System.out.println(pDTO);
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.addObject("pDTO", pDTO);
		mav.setViewName("yj/ChallengesList");
		return mav;
	}
	
	@GetMapping("ChallengesListMore")
    @ResponseBody
    public List<ChallengesDTO> ChallengesListMore(int nowPage, int lastNo) {
        // pDTO에 nowPage 설정
        ChallengesPagingDTO pDTO = new ChallengesPagingDTO();
        pDTO.setNowPage(nowPage);
        pDTO.setLastNo(lastNo);
        System.out.println("hi");
        System.out.println(pDTO.toString());
        // 다음 페이지 데이터를 가져와서 리스트로 반환
        List<ChallengesDTO> list = service.ChallengesListMore(pDTO);
        System.out.println(list);
        return list;
    }
}











