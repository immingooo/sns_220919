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
			<c:forEach var="post" items="${postList}">
			<%-- 카드1 --%>
			<div class="card border rounded p-0 mt-4">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="d-flex justify-content-between m-2">
					<div class="font-weight-bold">${post.userId}</div>
					<%-- 더보기 --%>
					<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
                        <img src="/static/img/more-icon.png" alt="더보기 아이콘" width="30">
                    </a>
				</div>
				
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img src="http://localhost:8080${post.imagePath}" alt="업로드한 사진" class="w-100">
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
					<span class="font-weight-bold">${post.userId}</span>
					<span>${post.content}</span>
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
			</c:forEach>
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
	});
</script>