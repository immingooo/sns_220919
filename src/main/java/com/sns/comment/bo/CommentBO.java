package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentDAO;
import com.sns.comment.model.Comment;
import com.sns.comment.model.CommentView;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private UserBO userBO;

	public void addCommentListByUserIdPostId(int userId, int postId, String comment) {
		commentDAO.insertCommentListByUserIdPostId(userId, postId, comment);
	}
	
	public List<Comment> getCommentList() {
		return commentDAO.selectCommentList();
	}
	
	// 글번호에 해당하는 댓글목록만 가져옴. 내 클래스 안에서만 사용할려면 private로 바꾸면 됨
	private List<Comment> getCommentListByPostId(int postId) {
		return commentDAO.selectCommentListByPostId(postId);
	}
	
	// input: 글번호
	// output: 글번호에 해당하는 댓글목록(+댓글쓴이 정보)을 가져온다. => 가공해서(generate)
	public List<CommentView> generateCommentViewListByPostId(int postId) {
		// 결과물을 담을 객체
		List<CommentView> commentViewList = new ArrayList<>();
		
		// 댓글 목록 가져오기
		List<Comment> commentList = getCommentListByPostId(postId);
		
		// 반복문 => CommentView => 결과물에 넣는다.
		for (Comment comment : commentList) {
			CommentView commentView = new CommentView();
			
			// 댓글 한개
			commentView.setComment(comment);
			
			// 댓글쓴이!!!
			User user = userBO.getUserById(comment.getUserId());
			commentView.setUser(user);
			
			// 리스트에 담는다.
			commentViewList.add(commentView);
		}
		
		// 결과물 리턴
		return commentViewList;
	}
	
	public void deleteCommentByPostId(int postId) {
		commentDAO.deleteCommentByPostId(postId);
	}
}
