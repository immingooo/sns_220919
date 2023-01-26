package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.model.CommentView;
import com.sns.like.bo.LikeBO;
import com.sns.post.bo.PostBO;
import com.sns.post.model.Post;
import com.sns.timeline.model.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;

	// 로그인이 되지 않은 사람도 카드 목록이 보여야 한다.
	public List<CardView> generateCardList(Integer userId) { // 응답을 내리기 위한 객체로 가공할 땐 generate라는 이름으로 만든다.
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록 가져오기(post DB select)
		List<Post> postList = postBO.getPostList();
		
		// postList 반복문 => CardView => CardViewList에 넣는다.
		for (Post post : postList) {
			CardView card = new CardView(); // 객체 생성
			
			// 글 가져오기
			card.setPost(post);
			
			// 글쓴이 정보 가져오기!!!(user DB select) - 모든 사용자의 정보를 전부 다 가져오는 게 아닌 글 작성한 사람의 정보만 가져오기 => 글 작성한 사람의 로그인 아이디가 필요해서
			User user = userBO.getUserById(post.getUserId());
			card.setUser(user);
			
			// 글 하나에 해당하는 댓글들 채우기(원래 Comment객체로 가져와서 getCommentListByPostId로 했다가 댓글쓴이 정보까지 얻어오기위해 가공해서 가져오는걸로 바꿈)
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			card.setCommentList(commentList);
			
			// 내가 좋아요를 눌렀는지 filledLike. (로그인 안된 사람도 에러안나도록 해야함 => like BO에서 처리)
			card.setFilledLike(likeBO.existLike(post.getId(), userId)); // 디버깅으로 확인하면 좋음
			
			// 글에 눌린 좋아요 개수
			card.setLikeCount(likeBO.getLikeCountByPostId(post.getId())); // 디버깅으로 확인하면 좋음
			
			// 카드 리스트 채우기
			cardViewList.add(card);
		}
		
		return cardViewList;
	}
}
