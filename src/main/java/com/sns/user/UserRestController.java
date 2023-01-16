package com.sns.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.common.EncryptUtils;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
public class UserRestController {
	
	@Autowired
	private UserBO userBO;

	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return
	 */
	@GetMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		boolean isDuplicated = userBO.existLoginId(loginId);
		Map<String, Object> result = new HashMap<>();
		if (isDuplicated) { // 중복일 때
			result.put("code", 1);
			result.put("result", true);
		} else if (!isDuplicated) { // 중복 아닐 때
			result.put("code", 1);
			result.put("result", false);
		} else {
			result.put("code", 500);
			result.put("errorMessage", "에러");
		}
		
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		String hashedPassword = EncryptUtils.md5(password);
		
		Map<String, Object> result = new HashMap<>();
		
		int row = userBO.addUser(loginId, hashedPassword, name, email);
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "추가된 행이 없습니다.");
		}
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpSession session) {
		
		String hashedPassword = EncryptUtils.md5(password);
		
		User user = userBO.getUserByLoginIdPassword(loginId, hashedPassword);
		
		Map<String, Object> result = new HashMap<>();
		if (user != null) {
			result.put("code", 1);
			result.put("result", "성공");
			
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
		} else {
			result.put("code", 500);
			result.put("errorMessage", "존재하지 않는 사용자 입니다.");
		}
		
		return result;
	}
}
