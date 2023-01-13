<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="contents d-flex justify-content-center">
	<div class="col-8 h-100 mt-3">
	    <div>
	        <h3 class="font-weight-bold">회원 가입</h3>
	    </div>
	    <div class="box1">
	        <div class="p-4">
	            <div class="form-group m-0">
	                <label for="loginId">ID</label>
	                <div class="d-flex">
	                    <input type="text" id="loginId" class="form-control" placeholder="ID를 입력해주세요">
	                    <button type="button" class="btn btn-primary ml-3">중복확인</button>
	                </div>
	                <small class="text-danger">사용중인 아이디입니다.</small>
	            </div>
	            <div class="form-group">
	                <label for="password">password</label>
	                <input type="password" id="password" class="form-control">
	            </div>
	            <div class="form-group">
	                <label for="passwordCheck">confirm password</label>
	                <input type="password" id="passwordCheck" class="form-control">
	            </div>
	            <div class="form-group">
	                <label for="name">이름</label>
	                <input type="text" id="name" class="form-control" placeholder="이름을 입력해주세요">
	            </div>
	            <div class="form-group">
	                <label for="email">이메일</label>
	                <input type="text" id="email" class="form-control" placeholder="이메일을 입력해주세요">
	            </div>
	            
	            <div class="d-flex justify-content-center">
	                <button type="button" class="btn btn-primary col-6">가입하기</button>
	            </div>
	        </div>
	    </div>
	</div>
</div>