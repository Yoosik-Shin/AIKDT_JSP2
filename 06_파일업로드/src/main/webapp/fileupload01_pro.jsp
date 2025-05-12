<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload2.jakarta.*"%>
<%@page import="org.apache.commons.fileupload2.core.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 파일 업로드 폴더 지정
	String uploadPath = "C:/upload/";
	File uploadDir = new File(uploadPath);
	if(!uploadDir.exists()) {
		uploadDir.mkdirs();
	}
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	//파일 파라미터 확인
	File repository = new File(System.getProperty("java.io.tmpdir"));
	FileItemFactory factory = DiskFileItemFactory.builder().setFile(repository).get();
	JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
	JakartaServletRequestContext context = new JakartaServletRequestContext(request);
	
	try {
		List<FileItem> items = upload.parseRequest(context);
		for(FileItem item : items) {
			// 텍스트 데이터
			if(item.isFormField()) {
				out.println(item.getFieldName() + " : " + item.getString(StandardCharsets.UTF_8) + "<br>");
			}
			// 파일 데이터
			else {
				String fileName = System.currentTimeMillis() + "_" + item.getName();
				if(fileName != null && !fileName.isEmpty()) {
					File uploadedFile = new File(uploadDir, fileName);
					try(
						InputStream is = item.getInputStream();
							FileOutputStream fos = new FileOutputStream(uploadedFile);
						){
						is.transferTo(fos);
					} catch(Exception e){
						e.printStackTrace();
					}
				}
			}
		}
		} catch(Exception e) {
			out.println("파일 업로드 중 에러");	
			e.printStackTrace();
		}		
		
	
	
	
%>
	/* request.setCharacterEncoding("UTF-8");


	String uploadPath = "C:/upload/";
	File uploadDir = new File(uploadPath);
	if(!uploadDir.exists()) {
		uploadDir.mkdirs();
	}

	// 텍스트 파라미터 (name, title)
	out.println("<h3>텍스트 파라미터</h3>");
	/* String name = request.getParameter("name");
	String title = request.getParameter("title"); */
	
	for(Part part : request.getParts()) {
		
	Part namePart = request.getPart("name");
	Part titlePart = request.getPart("title");
	String name = part.getName();
	String value = request.getParameter(part.getName());
	out.println("<h5>" + name + " : " + value +  "</h5>");
	out.println("<h5>" + title + "</h5>");
		
	}
	
	
	// 파일 파라미터 (file1, file2)
	Part file1 = request.getPart("file1");
	Part file2 = request.getPart("file2");
	
	Collection<Part> parts = request.getParts();
	
	for (Part part : parts) {
		String fieldName = part.getName();
		String fileName = part.getSubmittedFileName();
		out.println("fieldName : " + fieldName);
		out.println("fileName : " + fileName);
		// 파일 파라미터 확인
		if(fileName != null && !fileName.isEmpty()) {
			// 업로드 파일명 지정 (밀리초시간_파일명)
			String uploadedName = System.currentTimeMillis()+ "_" + fileName;
			File file = new File (uploadPath, uploadedName);
			// 파일 데이터 입력 + 파일 데이터 출력 (파일 저장)
			try(
				InputStream is = part.getInputStream();
				FileOutputStream fos = new FileOutputStream(file)
				){
				is.transferTo(fos);
				}
			catch (Exception e){
				out.print("파일 저장 시, 에러 발생");
			}
			// 파일 정보
			out.println("=================================================");
			out.println("필드 이름 : " + fieldName + "<br>");
			out.println("원본 파일명 : " + fileName + "<br>");
			out.println("저장 파일명 : " + uploadedName + "<br>");
			out.println("타입 : " + part.getContentType() + "<br>");
			out.println("경로 : " + file.getAbsolutePath() + "<br>");
			out.println("크기 : " + file.length() + "<br>");
			}
	} */