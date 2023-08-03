package com.smart.home.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.smart.home.dto.QaCommentsDTO;
import com.smart.home.service.QaCommentsService;


@RestController
public class QaCommentsController {
    @Autowired
    QaCommentsService service;

    // ��۵��
    @PostMapping("/qacomments/qacommentsWrite")
    public String qacommentsWrite(QaCommentsDTO dto, HttpSession session) {
        // session�۾��� ���ϱ�
        dto.setMemberId((String)session.getAttribute("logId"));
        System.out.println(dto.toString());
        
        int result = service.qacommentsInsert(dto);
        return result + "";
    }

    // ��۸��
    @GetMapping("/qacomments/qacommentsList")
    public List<QaCommentsDTO> qacommentsList(int qaNo) { // ���� �� ��ȣ
        return service.qacommentsSelect(qaNo);
    }

    @PostMapping("/qacomments/qacommentsEditOk")
    // ��ۼ���(DB:update)
    public String qacommentsEditOk(QaCommentsDTO dto) {
        return String.valueOf(service.qacommentsUpdate(dto));
    }

    // ��ۻ���
    @GetMapping("/qacomments/qacommentsDel")
    public String qacommentsDel(int qacommentNo) {
        return String.valueOf(service.qacommentsDelete(qacommentNo));
    }
}
