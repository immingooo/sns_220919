package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
public class LikeRestController {

	// /like?postId=13  => @RequestParam
	// /like/13 둘이 같음  => @PathVariable
	@GetMapping("/like/{postId}")
	public Map<String, Object> like(
			@PathVariable int postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		
		// 로그인 정보
		Integer userId =(Integer)session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 500);
			result.put("errorMessage", "로그인 해주세요.");
		}
		
		// 어느글에 좋아요를 눌렀는지 select
		
		return result;
	}
}
