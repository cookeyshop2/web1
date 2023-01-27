<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String fileName = request.getParameter("file");
	
	String directory = application.getRealPath("/image");
	
	File file = new File(directory + "/" + fileName);
	
	String mimeType = getServletContext().getMimeType(file.toString());
	if(mimeType == null) {
		response.setContentType("application/octet-stream");
	}
	
	String downloadName = null;
	if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
		downloadName = new String(fileName.getBytes("UTF-8"), "8859_1");
	}else {
		downloadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
	}
	response.setHeader("Content-Disposition", "attachment;filename=\""+downloadName+"\";");
	
	FileInputStream fileInputStream = new FileInputStream(file);
	ServletOutputStream servletOutputStream = response.getOutputStream();
	
	byte b[] = new byte[1024];
	int data=0;
	while((data = (fileInputStream.read(b, 0, b.length))) != -1) {
		servletOutputStream.write(b, 0, data);
	}
	
	servletOutputStream.flush();
	servletOutputStream.close();
	fileInputStream.close();

%>