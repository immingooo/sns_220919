package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeDAO;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;

	public boolean getLikeByPostIdUserId(int postId, int userId) {
		return likeDAO.selectLikeByPostIdUserId(postId, userId);
	}
	
	public void deleteLikeByPostIdUserId(int postId, int userId) {
		likeDAO.deleteLikeByPostIdUserId(postId, userId);
	}
	
	public void addLikeByPostIdUserId(int postId, int userId) {
		likeDAO.insertLikeByPostIdUserId(postId, userId);
	}
	
	public boolean existLike(int postId, Integer userId) { // 여기서 비로그인 처리도 할 거임
		if (userId == null) { // 비로그인 처리
			return false;
		}
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, userId) > 0 ? true : false; // 로그인
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, null);
	}
}
