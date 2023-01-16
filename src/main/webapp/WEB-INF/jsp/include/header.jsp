<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex align-items-center justify-content-between h-100">
    <h4 class="font-weight-bold m-0 ml-4">Marondalgram</h4>
    
    <c:choose>
    	<c:when test="${not empty userId}">
		    <div class="pr-3">
		    	<span>${userName}님 안녕하세요!</span>
		    	<a href="/user/sign_out" class="ml-3 font-weight-bold">로그아웃</a>
		    </div>
    	</c:when>
    	<c:otherwise>
    		<a href="/user/sign_in_view" class="pr-3 font-weight-bold">로그인</a>
    	</c:otherwise>
    </c:choose>
</div>