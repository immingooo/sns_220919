package com.sns.user;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@SpringBootTest
class UserRestControllerTest {
	
	@Autowired
	UserBO userBO;

	// src/main클래스 > new > JUnit Test Case > Finish => 테스트 파일 생성
	//@Test
	void test() {
		User user = userBO.getUserByLoginIdPassword("aaaa", "74b8733745420d4d33f80c4663dc5e5");
		assertNotNull(user); // user가 null이 아니면 올바르게 가져온것
	}

	@Transactional  // rollback: 실제로 된 건데 롤백으로 데이터는 원래 상태로 돌아가게 만든다. insert, update할 때 사용하기
	@Test
	void 유저추가테스트() {
		userBO.addUser("dddd1111", "dddd1111", "테스트", "test@test.com");
	}
}
