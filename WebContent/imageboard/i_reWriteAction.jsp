<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="i_board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project</title>
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
		<jsp:useBean id="boardbean" class="i_board.BoardBean"/>
		<jsp:setProperty property="*" name="boardbean"/>
	<%
// 		String directory = application.getRealPath("/image/");
		int maxSize = 1024 * 1024 * 100;
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
			System.out.println( "파일 : " + multi.getOriginalFileName(file1));
			String fileName = multi.getOriginalFileName(file1);
			String fileRealName = multi.getFilesystemName(file1);
			
			if(multi.getOriginalFileName(file1) != null) {
				ParameterBlock pb = new ParameterBlock();
				pb.add(directory + fileRealName);
				RenderedOp rOp = JAI.create("fileload", pb);
				
				BufferedImage bi = rOp.getAsBufferedImage(); //원본
				BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_RGB);
				
				Graphics2D g = thumb.createGraphics();
				g.drawImage(bi, 0, 0, 100, 100, null);
				
				File thumbnailFile = new File(directory, "sm_"+fileRealName);
				ImageIO.write(thumb, "jpg", thumbnailFile);
				
				boardbean.setName(multi.getParameter("name"));
				boardbean.setPasswd(multi.getParameter("passwd"));
				boardbean.setSubject(multi.getParameter("subject"));
				boardbean.setContent(multi.getParameter("content"));
				boardbean.setFileName(fileRealName);
				
				boardbean.setDate(new Timestamp(System.currentTimeMillis()));
				BoardDAO idao = new BoardDAO();
				idao.reInsertBoard(boardbean);
				response.sendRedirect("imageboard.jsp");
			} else {
				boardbean.setName(multi.getParameter("name"));
				boardbean.setPasswd(multi.getParameter("passwd"));
				boardbean.setSubject(multi.getParameter("subject"));
				boardbean.setContent(multi.getParameter("content"));
				
				boardbean.setDate(new Timestamp(System.currentTimeMillis()));
				BoardDAO idao = new BoardDAO();
				idao.reInsertBoard(boardbean);
				response.sendRedirect("imageboard.jsp");
			}
			

			
%>
</body>
</html>