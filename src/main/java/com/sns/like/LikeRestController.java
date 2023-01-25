package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.sns.like.bo.LikeBO;

import jakarta.servlet.http.HttpSession;

@RestController
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;

	// /like?postId=13  => @RequestParam
	// /like/13 둘이 같음  => @PathVariable
	@GetMapping("/like/{postId}")
	public Map<String, Object> like(
			@PathVariable int postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		
		// 로그인 정보
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 500);
			result.put("errorMessage", "로그인 해주세요.");
			return result;
		}
		
		// 누가 어느글에 좋아요를 눌렀는지 like DB select boolean
		// if문 같은 로직이 컨트롤러에 있으면 안좋음!!! => BO에서 하기
		boolean existLike = likeBO.getLikeByPostIdUserId(postId, userId);
		if (existLike) { // true. 이미 좋아요를 눌렀을 때 (like DB delete)
			likeBO.deleteLikeByPostIdUserId(postId, userId);
		} else { // false. 새로 좋아요를 눌른 상황 (like DB insert)
			likeBO.addLikeByPostIdUserId(postId, userId);
		}
			
		return result;
	}
}
