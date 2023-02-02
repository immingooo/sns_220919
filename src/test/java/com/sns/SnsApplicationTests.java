package com.sns;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.ObjectUtils;

@SpringBootTest
class SnsApplicationTests {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	
	// 단축키: alt + shift + x    ,+ t
	//@Test
	void contextLoads() {
		logger.info("[########### logger test]");
	}
	
	//@Test
	void 더하기테스트() {
		logger.info("$$$$$$$$$$ 더하기 테스트 시작");
		int a = 10;
		int b = 30;
		
		assertEquals(30, a + b);
	}
	
	@Test
	void 널체크() { // 스트링, 리스트 널체크하기
		String a = null;
		if (ObjectUtils.isEmpty(a)) {
			logger.info("비어있다");
		} else {
			logger.info("비어있지 않다.");
		}
		
		List<String> list = null;
		logger.info(ObjectUtils.isEmpty(list) + "");
	}
	

}
