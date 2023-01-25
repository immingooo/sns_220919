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
}
