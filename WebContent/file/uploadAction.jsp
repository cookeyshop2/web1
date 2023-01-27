<%@page import="java.sql.Timestamp"%>
<%@page import="f_board.BoardDAO"%>
<%@page import="f_board.BoardBean"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String id =null;
		if(session.getAttribute("id")!=null){
			id = (String)session.getAttribute("id");
		}else{
			response.sendRedirect("../member/login.jsp");
		}
	%>
		<jsp:useBean id="boardbean" class="f_board.BoardBean"/>
		<jsp:setProperty property="*" name="boardbean"/>
	<%
// 		String directory = application.getRealPath("/upload");
		int maxSize = 1024 * 1024 * 200;
		String encoding = "utf-8";
		
		String path="/temp/";
		
		ServletContext context= request.getSession().getServletContext();
		
		String directory =context.getRealPath(path);
		
		System.out.println("여기 : " + directory);
		
		File Folder = new File(directory);
		
		if (!Folder.exists()) {
			try{
			    Folder.mkdir(); //폴더 생성합니다.
			    System.out.println("폴더가 생성되었습니다.");
		        } 
		        catch(Exception e){
			    e.getStackTrace();
			}        
	    }
		
		MultipartRequest multi
		 = new MultipartRequest(request, directory, maxSize, encoding,
				 new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String file1 = (String)files.nextElement();
			
			String fileName = multi.getOriginalFileName(file1);
			String fileRealName = multi.getFilesystemName(file1);
			
			boardbean.setName(multi.getParameter("name"));
			boardbean.setPasswd(multi.getParameter("passwd"));
			boardbean.setSubject(multi.getParameter("subject"));
			boardbean.setContent(multi.getParameter("content"));
			boardbean.setFileName(fileRealName);
			
			
				boardbean.setDate(new Timestamp(System.currentTimeMillis()));
				BoardDAO fdao = new BoardDAO();
				fdao.insertBoard(boardbean);
				response.sendRedirect("fileboard.jsp");
			
		
		

	%>
</body>
</html>