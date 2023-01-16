<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="contents d-flex justify-content-center">
	<div class="col-8 h-100 mt-3">
       <div class="pb-2">
           <h3 class="font-weight-bold">로그인</h3>
       </div>
       <div class="box2 d-flex justify-content-center align-items-center">
           <form id="loginForm" method="post" action="/user/sign_in">
               <div class="form-group">
                   <input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디">
               </div>
               <div class="form-group">
                   <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호">
               </div>

               <div class="d-flex justify-content-between">
                   <a class="btn btn-dark col-5" href="/user/sign_up_view">회원가입</a>
                   <button type="submit" id="loginBtn" class="btn btn-primary col-5">로그인</button>
               </div>
           </form>
       </div>
   </div>
</div>

<script>
	$(document).ready(function() {
		$('#loginForm').on('submit', function(e) {
			e.preventDefault();
			
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val();
			
			if (loginId == '') {
				alert("아이디를 입력해주세요");
				return false;
			}
			if (password == '') {
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			let url = $(this).attr('action');
			console.log(url);
			let params = $(this).serialize();
			console.log(params);
			
			$.post(url, params)
			.done(function(data) {
				if (data.code == 1) {
					location.href="/timeline/timeline_view";
				} else {
					alert(data.errorMessage);
				}
			});
		});
	});
</script>