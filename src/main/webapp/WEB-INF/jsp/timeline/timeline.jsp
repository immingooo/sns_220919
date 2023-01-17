<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="contents-box col-7">
		<%-- 글쓰기 영역 --%>
		<div class="write-box border rounded mt-3">
			<textarea class="w-100 border-0" id="writeTextArea" placeholder="내용을 입력해주세요"></textarea>
			<div class="d-flex justify-content-between">
				<div class="file-upload d-flex">
                    <%-- file 태그는 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 이벤트를 줄 것이다. --%>
                    <input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
                    <%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
                    <a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>

                    <%-- 업로드 된 임시 파일 이름 저장될 곳 --%>
                    <div id="fileName" class="ml-2">
                    </div>
                </div>
				<button id="writeBtn" class="btn btn-info">게시</button>
			</div>
		</div>
		
		<%-- 타임라인 영역 --%>
		<div class="timeline-box my-5">
			<%-- 카드1 --%>
			<div class="card border rounded p-0 mt-5">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="d-flex justify-content-between m-2">
					<div class="font-weight-bold">글쓰니</div>
					<%-- 더보기 --%>
					<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
                        <img src="/static/img/more-icon.png" alt="더보기 아이콘" width="30">
                    </a>
				</div>
				
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img src="https://cdn.pixabay.com/photo/2018/03/28/19/21/easter-3270234_960_720.jpg" alt="업로드한 사진" class="w-100">
				</div>
				
				<%-- 좋아요 --%>
				<div class="card-like p-2">
					<a href="#" class="like-btn">
                    	<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18" height="18" alt="empty heart">
                        좋아요 10개
                    </a>
				</div>
				
				<%-- 글 --%>
				<div class="card-post pr-2 pl-2">
					<span class="font-weight-bold">글쓰니</span>
					<span>글 내용입니다.</span>
				</div>
				
				<%-- 댓글 --%>
				<div class="card-comment-desc border-bottom">
					<div class="font-weight-bold mt-3 pr-2 pl-2 mb-2">댓글</div>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
					<div class="card-comment">
						<span class="font-weight-bold">댓글쓰니 :</span>
						<span>댓글 내용입니다.</span>
						
						<%-- 댓글 삭제 버튼 --%>
						<a href="#" class="commentDelBtn">
                            <img src="https://www.iconninja.com/files/603/22/506/x-icon.png" alt="삭제버튼" width="10px" height="10px">
                        </a>
					</div>
					
					<%-- 댓글 쓰기 --%>
					<div class="comment-write d-flex border-top mt-3">
                        <input type="text" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
                        <button type="button" class="comment-btn btn btn-light" data-post-id="${card.post.id}">게시</button>
                    </div>
				</div>
			</div>
		</div>
	</div>
</div>