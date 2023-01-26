package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static final String FILE_UPLOAD_PATH = "D:\\minkyung\\6_spring_project\\sns\\workspace\\images/";
	
	public String saveFiles(String userLoginId, MultipartFile file) {
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	// 이미지 제거하는 로직
		public void deleteFile(String imagePath) { // imagePath: /images/aaaa_165482365/sun.png
			// 이미지 제거 -> 폴더 제거
			//      \\images/      imagePath에 있는 겹치는  /images/  구문 제거
			Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
			if (Files.exists(path)) {
				// 이미지 삭제
				try {
					Files.delete(path); // 여기서 예외처리(여기서 안하면 BO로 가는데 BO가 처리할 필요가 없음)
				} catch (IOException e) {
					logger.error("[이미지 삭제] 이미지 삭제 실패. imagePath:{}", imagePath);
				}
				
				// 디렉토리(폴더) 삭제
				path = path.getParent(); // 부모(폴더)로 이동
				if (Files.exists(path)) {
					try {
						Files.delete(path);
					} catch (IOException e) {
						logger.error("[이미지 삭제] 디렉토리(이미지 폴더) 삭제 실패. imagePath:{}", imagePath);
					}
				}
			}
		}
}
