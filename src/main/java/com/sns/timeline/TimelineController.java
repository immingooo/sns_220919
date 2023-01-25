package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.comment.bo.CommentBO;
import com.sns.post.bo.PostBO;
import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.model.CardView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private TimelineBO timelineBO;

	@GetMapping("/timeline_view")
	public String timelineView(Model model, HttpSession session) {
		
		// post DB select
		//List<Post> postList = postBO.getPostList();
		List<CardView> cardList = timelineBO.generateCardList((Integer)session.getAttribute("userId")); // 비로그인인 경우도 에러가 나지 않도록 하기위해 캐스팅을 Integer로. 가져와지는지 디버깅으로 확인하기
		
		// comment DB select - 조건: 
		//List<Comment> commentList = commentBO.getCommentList();
		
		//model.addAttribute("commentList", commentList);
		//model.addAttribute("postList", postList);
		model.addAttribute("cardList", cardList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}
