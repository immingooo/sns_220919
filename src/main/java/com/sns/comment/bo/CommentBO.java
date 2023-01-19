package com.sns.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentDAO;
import com.sns.comment.model.Comment;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;

	public void addCommentListByUserIdPostId(int userId, int postId, String comment) {
		commentDAO.insertCommentListByUserIdPostId(userId, postId, comment);
	}
	
	public List<Comment> getCommentList() {
		return commentDAO.selectCommentList();
	}
}
