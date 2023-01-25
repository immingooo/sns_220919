package com.sns.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {

	public boolean selectLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public void deleteLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public void insertLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
//	public boolean existLike(
//			@Param("postId") int postId, 
//			@Param("userId") int userId);
//	
//	public int selectLikeCountByPostId(int postId);
	
	public int selectLikeCountByPostIdOrUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);
}
