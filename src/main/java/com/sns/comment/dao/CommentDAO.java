package com.sns.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.comment.model.Comment;

@Repository
public interface CommentDAO {

	public void insertCommentListByUserIdPostId(
			@Param("userId") int userId, 
			@Param("postId") int postId, 
			@Param("comment") String comment);
	
	public List<Comment> selectCommentList();
}
