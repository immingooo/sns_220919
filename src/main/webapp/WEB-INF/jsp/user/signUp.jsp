<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="contents d-flex justify-content-center">
	<div class="col-8 mt-3">
	    <div class="pb-2 pt-3">
	        <h3 class="font-weight-bold">회원 가입</h3>
	    </div>
	    <div class="box1 w-100">
	        <div class="p-4">
	        <form id="signUpForm" method="post" action="/user/sign_up">
	            <div class="form-group">
	                <label for="loginId">ID</label>
	                <div class="d-flex">
	                    <input type="text" id="loginId" name="loginId" class="form-control" placeholder="ID를 입력해주세요">
	                    <button type="button" id="loginIdCheckBtn" class="btn btn-primary ml-3">중복확인</button>
	                </div>
	                
	                <div id="idCheckLength" class="small text-danger d-none">아이디를 4자 이상 입력해주세요.</div>
	                <div id="idCheckOk" class="small text-success d-none">사용 가능한 아이디입니다.</div>
	                <div id="idCheckDuplicated" class="small text-danger d-none">사용중인 아이디입니다.</div>
	            </div>
	            <div class="form-group">
	                <label for="password">password</label>
	                <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요">
	            </div>
	            <div class="form-group">
	                <label for="confirmPassword">confirm password</label>
	                <input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력해주세요">
	            </div>
	            <div class="form-group">
	                <label for="name">이름</label>
	                <input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력해주세요">
	            </div>
	            <div class="form-group">
	                <label for="email">이메일</label>
	                <input type="text" id="email" name="email" class="form-control" placeholder="이메일을 입력해주세요">
	            </div>
	            
	            <div class="d-flex justify-content-center">
	                <button type="submit" id="signUpBtn" class="btn btn-primary col-3">가입하기</button>
	            </div>
	        </form>
	        </div>
	    </div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 중복확인 버튼 클릭
		$('#loginIdCheckBtn').on('click', function() {
			//alert('제일먼저 클릭이 되는지 확인하기');
			$('#idCheckLength').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			$('#idCheckDuplicated').addClass('d-none');
			
			let loginId = $('input[name=loginId]').val().trim();
			if (loginId.length < 4) {
				$('#idCheckLength').removeClass('d-none');
				return;
			}
			
			$.ajax({
				type:"get"
				, url:"/user/is_duplicated_id"
				, data:{"loginId":loginId}
			
				, success:function(data) {
					if (data.code == 1) {
						if (data.result) { // 중복일 때
							$('#idCheckDuplicated').removeClass('d-none');
						} else { // 사용가능 할 때
							$('#idCheckOk').removeClass('d-none');
						}
					} else if (data.code == 500) {
						alert(data.errorMessage);
					}
				}
				, error:function(e) {
					alert("중복확인에 실패했습니다.");
				}
			});
		});
		
		// 회원가입 버튼 클릭
		$('#signUpForm').on('submit', function(e) {
			//alert('111');
			e.preventDefault();
			
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let confirmPassword = $('#confirmPassword').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			if (loginId == '') {
				alert("아이디를 입력해주세요");
				return false;
			}
			if (password == '' || confirmPassword == '') {
				alert("비밀번호를 입력해주세요");
				return false;
			}
			if (name == '') {
				alert("이름을 입력해주세요");
				return false;
			}
			if (email == '') {
				alert("이메일을 입력해주세요");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if ($('#idCheckOk').hasClass('d-none')) {
				alert("아이디 중복확인을 다시 해주세요.");
				return false;
			}
			
			let url = $(this).attr('action');
			let params = $(this).serialize();
			//alert(url);
			//console.log(params);
			
			$.post(url, params)
			.done(function(data) {
				if (data.code == 1) {
					alert('가입을 환영합니다! 로그인 해주세요.');
					//location.href="/user/sign_in_view";
				} else {
					alert(data.errorMessage);
				}
			});
		});
	});
</script>