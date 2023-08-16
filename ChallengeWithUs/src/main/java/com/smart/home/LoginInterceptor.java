package com.smart.home;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 로그인 안된 경우에 interceptor 하기 위해 필요
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		
		// 현재 로그인 유무를 확인해서 로그인이 된경우 원래 매핑주소로 이동하고
		// 로그인이 안된경우 로그인폼으로 매핑되도록 매핑주소 변경
		
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("logId");
		String logStatus = (String)session.getAttribute("logStatus");
		if (userid==null || logStatus==null || userid.equals("") 
				|| !logStatus.equals("Y")) {
			// 로그인 안된 경우
			response.sendRedirect("/home/register/login");
			return false; // 원래 매핑으로 가지 않고 로그인 매핑으로 이동한다.
		}
		// 로그인이 된 경우
		return true; // 원래 매핑으로 이동한다.
	}
}
