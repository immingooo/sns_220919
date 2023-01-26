<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center">
	<div class="contents-box col-7">
		<%-- 글쓰기 영역: 로그인 된 상태에서만 보여짐(if문으로 처리) --%>
		<c:if test="${not empty userId}">
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
					<button type="button" id="writeBtn" class="btn btn-info">게시</button>
				</div>
			</div>
		</c:if>
		
		<%-- 타임라인 영역 --%>
		<div class="timeline-box my-4">
			<c:forEach var="card" items="${cardList}">
			<%-- 카드1 --%>
			<div class="card border rounded p-0 mt-4">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="d-flex justify-content-between m-2">
					<div class="font-weight-bold">${card.user.loginId}</div>
					
					<%-- 더보기(내가 쓴 글일 때만 노출) --%>
					<c:if test="${userId eq card.user.id}">
					<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
                        <img src="/static/img/more-icon.png" alt="더보기 아이콘" width="30">
                    </a>
                    </c:if>
				</div>
				
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img src="http://localhost:8080${card.post.imagePath}" alt="업로드한 사진" class="w-100">
				</div>
				
				<%-- 좋아요 --%>
				<div class="card-like p-2">
					<%-- 좋아요가 되어있을 때 --%>
					<c:if test="${card.filledLike eq true}">
					<a href="#" class="like-btn" data-user-id="${userId}" data-post-id="${card.post.id}">
                    	<img src="/static/img/full-heart-icon.png" width="18" height="18" alt="filled heart">
                    </a>
                    </c:if>
                    <%-- 좋아요가 해제되어 있을 때 --%>
                    <c:if test="${card.filledLike eq false}">
                    <a href="#" class="like-btn" data-user-id="${userId}" data-post-id="${card.post.id}">
                    	<img src="/static/img/empty-heart-icon.png" width="18" height="18" alt="empty heart">
                    </a>
                    </c:if>
                    좋아요 ${card.likeCount}개
				</div>
				
				<%-- 글 --%>
				<div class="card-post pr-2 pl-2">
					<span class="font-weight-bold">${card.user.loginId}</span>
					<span>${card.post.content}</span>
				</div>
				
				<%-- 댓글 --%>
				<div class="card-comment-desc border-bottom">
					<div class="font-weight-bold mt-3 pr-2 pl-2 mb-2">댓글</div>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
				
					<%-- 댓글 내용 --%>
					<c:forEach var="commentView" items="${card.commentList}">
						<div class="card-comment">
							<span class="font-weight-bold">${commentView.user.loginId} :</span>
							<span>${commentView.comment.content}</span>
							
							<%-- 댓글 삭제 버튼 --%>
							<a href="#" class="commentDelBtn">
	                            <img src="https://www.iconninja.com/files/603/22/506/x-icon.png" alt="삭제버튼" width="10px" height="10px">
	                        </a>
						</div>
					</c:forEach>
					
					<%-- 댓글 쓰기: 로그인이 되어있을 때만 보여진다. --%>
					<c:if test="${not empty userId}">
					<div class="comment-write d-flex border-top mt-3">
                        <input type="text" class="form-control border-0 mr-2" placeholder="댓글 달기"/> 
                        <button type="button" class="comment-btn btn btn-light" data-post-id="${card.post.id}">게시</button>
                    </div>
                    </c:if>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="modal">
	<%-- modal-sm: 작은 모달 창 --%>
	<%-- modal-dialog-centered: 모달 창 수직으로 가운데 정렬 --%>
  	<div class="modal-dialog modal-sm modal-dialog-centered">
    	<div class="modal-content text-center">
      		<div class="py-3 border-bottom">
      			<a href="#" id="deletePostBtn">삭제하기</a>
      		</div>
      		<div class="py-3">
      			<%-- data-dismiss="modal": 모달창 닫힘 --%>
      			<a href="#" data-dismiss="modal">취소하기</a>
      		</div>
    	</div>
  	</div>
</div>


<script>
	$(document).ready(function() {
		// 파일업로드 이미지 클릭 => 숨겨져 있는 file을 동작시킴
		$('#fileUploadBtn').on('click', function(e){
			//alert("1111");
			e.preventDefault(); // a태그의 스크롤이 저절로 올라가는 현상 방지(a태그의 성질)
			$('#file').click(); // input file을 사용자가 클릭한 것과 같은 효과
		});
		
		// 사용자가 이미지를 선택했을 때 유효성 확인 및 업로드 된 파일 이름 노출(file에 변경이 일어났을 때로 이벤트를 잡아야 함)
		$('#file').on('change', function(e) { // e에 파일이름도 들고 있음
			//alert("파일 선택");
			let fileName = e.target.files[0].name; // target은 this랑 같은 역할. 파일명만 가져옴 dog-4372036_960_720.jpg
			//alert(fileName);
			
			// 확장자 유효성 확인 - Memo랑 다른 방식
			let ext = fileName.split(".").pop().toLowerCase(); // jpg
			if (ext != 'jpg' && ext != 'jpeg' && ext != 'gif' && ext != 'png') {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$('#file').val(''); // 파일 태그의 실제 파일 제거(중요)
				$('#fileName').text(''); // 보이는 파일 이름 비우기
				return;
			}
			
			// 유효성 통과한 올바른 이미지는 상자에 업로드 된 파일 이름 노출
			$('#fileName').text(fileName); // text(): 태그사이에 값을 넣는것
		});
		
		// 게시버튼 클릭
		$('#writeBtn').on('click', function() {
			//alert("1111");
			// validation 체크
			let writeTextArea = $('#writeTextArea').val();
			if (writeTextArea == '') {
				alert("내용을 입력해주세요");
				return;
			}
			
			// 이미지 파일이 없는 경우 => ''
			let file = $('#file').val();
			if (file == '') {
				alert("파일을 업로드 해주세요");
				return;
			}
			
			// 파일이 업로드 된 경우 확장자 체크
			let ext = file.split(".").pop().toLowerCase(); //// 파일 경로를 .으로 나누고 확장자가 있는 마지막 문자열을 가져온 후 모두 소문자로 변경
			if ($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
				$('#file').val(''); // 파일을 비우기
				return;
			}
			
			// 폼태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("content", writeTextArea);
			formData.append("file", $('#file')[0].files[0]); // $('#file')[0]은 첫번째 input file 태그를 의미, files[0]는 업로드된 첫번째 파일
			
			$.ajax({
				type:"post"
				, url:"/post/create"
				, data:formData
				, enctype:"multipart/form-data" // 파일업로드를 위한 필수 설정
				, processData:false // 파일업로드를 위한 필수 설정
				, contentType:false // 파일업로드를 위한 필수 설정
				
				, success:function(data) {
					if (data.code == 1) {
						//alert("글 업로드 성공!");
						location.reload(true);
					} else if (data.code == 500){ // 비로그인일 때
						alert(data.errorMessage);
						location.href="/user/sign_in_view";
					} else {
						alert(data.errorMessage);
					}
				}
				, error:function(e) {
					alert("글 저장에 실패했습니다.");
				}
			});
		});
		
		// 댓글 게시버튼 클릭(댓글쓰기)
		$('.comment-btn').on('click', function() { // 지금 클릭된 건 모든 게시버튼은 모아놓은 배열이라고 생각하면 됨
			// 글번호, 댓글 내용 얻어오기
			let postId = $(this).data('post-id');
			console.log(postId);
			
			// 게시버튼이 클릭됐을 때 그 버튼에 해당하는 input의 val을 가져올 순 없음.
			// $(this)근처의 태그들을 살펴봐서 가져와야함. 나랑 형제인걸 가지고오기.
			// 지금 클릭된 게시버튼의 형제인 input 태그를 가져온다. siblings
			let comment = $(this).siblings('input').val().trim(); // 눌린 게시버튼과 형제가 되는 input태그의 값을 가져온다.
			//alert(comment);
			if (comment == '') {
				return;
			}
			
			$.ajax({
				url:"/comment/create"
				, data:{"postId":postId, "comment":comment}
			
				, success:function(data) {
					if (data.code == 1) {
						//alert("댓글작성 성공");
						location.reload(true);
					} else {
						alert(data.errorMessage);
					}
				}
				, error:function(jqXHR, testStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + testStatus);
				}
			});
		});
		
		// 좋아요/해제 버튼 클릭
		$('.like-btn').on('click', function(e) { // 이미지 바꾸기
			// a태그의 기본성질 막아두기
			e.preventDefault();
		
			// 로그인 여부 확인
			let userId = $(this).data('user-id');
			//alert(userId);
			if (userId == null) {
				alert("로그인 해주세요");
				return;
			}
			// 무슨 게시글에 있는 좋아요인지
			let postId = $(this).data('post-id');
			//alert(postId);
			
			$.ajax({
				// request
				url:"/like/" + postId
				
				// response
				, success:function(data) {
					if (data.code == 1) {
						location.reload(true);
					} else {
						alert(data.errorMessage);
					}
				}
				, error: function(e) {
					alert("좋아요/해제 하는데 실패했습니다.");
				}
			});
		});
		
		// 더보기 버튼(...) 클릭 -> 글 삭제를 위해
		$('.more-btn').on('click', function(e) {
			e.preventDefault(); // 거의 a태그에 붙임. 위로 올라가는 현상 방지
			
			let postId = $(this).data('post-id'); // getting(얻어옴)
			//alert(postId);
			
			$('#modal').data('post-id', postId) // setting(세팅함): 모달 태그에 data-post-id를 심어 넣어줌. 동적으로 심어넣고
		});
		
		// 모달 안에 있는 삭제하기 버튼 클릭 
		$('#modal #deletePostBtn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $('#modal').data('post-id'); // 동적으로 가져옴
			//alert(postId);
			
			// ajax 글 삭제
			$.ajax({
				type:"delete"
				, url:"/post/delete"
				, data:{"postId":postId}
			
				, success:function(data) {
					if (data.code == 1) {
						alert("글 삭제되었습니다.");
						location.reload(true);
					} else {
						alert(data.errorMessage);
					}
				}
				, error:function(e) {
					alert("글 삭제하는데 실패했습니다.");
				}
			});
		});
	});
</script>