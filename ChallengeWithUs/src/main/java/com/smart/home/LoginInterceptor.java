package com.smart.home;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// �α��� �ȵ� ��쿡 interceptor �ϱ� ���� �ʿ�
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		
		// ���� �α��� ������ Ȯ���ؼ� �α����� �Ȱ�� ���� �����ּҷ� �̵��ϰ�
		// �α����� �ȵȰ�� �α��������� ���εǵ��� �����ּ� ����
		
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("logId");
		String logStatus = (String)session.getAttribute("logStatus");
		if (userid==null || logStatus==null || userid.equals("") 
				|| !logStatus.equals("Y")) {
			// �α��� �ȵ� ���
			response.sendRedirect("/home/register/login");
			return false; // ���� �������� ���� �ʰ� �α��� �������� �̵��Ѵ�.
		}
		// �α����� �� ���
		return true; // ���� �������� �̵��Ѵ�.
	}
}
