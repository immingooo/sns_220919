package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeDAO;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;
	
	public void likeToggle(int postId, int userId) {
		// 누가 어느글에 좋아요를 눌렀는지 like DB select boolean
		//boolean existLike = likeDAO.existLike(postId, userId);
		//int rowCount = likeDAO.selectLikeCountByPostIdOrUserId(postId, userId)
		if (likeDAO.selectLikeCountByPostIdOrUserId(postId, userId) > 0) { // true. 이미 좋아요를 눌렀을 때 (like DB delete)
			likeDAO.deleteLikeByPostIdUserId(postId, userId);
		} else { // false. 새로 좋아요를 눌른 상황 (like DB insert)
			likeDAO.insertLike(postId, userId);
		}
	}
	
	public boolean existLike(int postId, Integer userId) { // 여기서 비로그인 처리도 할 거임
		if (userId == null) { // 비로그인 처리
			return false;
		}
		//return likeDAO.existLike(postId, userId);
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, userId) > 0 ? true : false; // 로그인
	}
	
	public int getLikeCountByPostId(int postId) {
		//return likeDAO.selectLikeCountByPostId(postId);
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, null);
	}
	
	public void deleteLikeByPostId(int postId) {
		likeDAO.deleteLikeByPostId(postId);
	}
}
