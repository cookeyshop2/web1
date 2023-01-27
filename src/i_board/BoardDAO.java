package i_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private DataSource ds;
	private ResultSet rs;
	
	private Connection getConnection() throws Exception{
		Connection con = null;
		
		Context init = new InitialContext();
		DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/jspdb");
		
		con = ds.getConnection();
		return con;
	}// DB Connection
	
	public void freeResource() {
		try {
			if(con!=null)con.close();
			if(pstmt!=null)pstmt.close();
			if(rs!=null)rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//freeResource() end
	
	public void insertBoard(BoardBean boardbean) {
		String sql ="";
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		int num=0;
		try {
			con=getConnection();
			sql = "select max(num) from i_board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}else {
				num=1;
			}
			
			sql="insert into i_board "
					+ "(num,name,passwd,subject,"
					+ "content, readcount, re_ref, re_lev, re_seq, date, FileName, FileRealName)"
					+ "values(?,?,?,?,?,?,?,?,?,now(),?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardbean.getName());
			pstmt.setString(3, boardbean.getPasswd());
			pstmt.setString(4, boardbean.getSubject());
			pstmt.setString(5, boardbean.getContent());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, num);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setString(10, boardbean.getFileName());
			pstmt.setString(11, boardbean.getFileRealName());
			
			pstmt.executeUpdate();
					
		} catch (Exception e) {
			System.out.println("insertBoard inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}//insertBoard end
	
	public int getBoardCount() {
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int count = 0;
		try {
			con=getConnection();
			sql = "select count(*) from i_board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getBoardCount inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	} // getBoardCount end
	
	public List<BoardBean> getBoardList(int startRow, int pageSize){
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		
		try {
			con = getConnection();
			sql = "select * from i_board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardBean boardbean = new BoardBean();
				boardbean.setContent(rs.getString("content"));
				boardbean.setDate(rs.getTimestamp("date"));
				boardbean.setName(rs.getString("name"));
				boardbean.setNum(rs.getInt("num"));
				boardbean.setPasswd(rs.getString("passwd"));
				boardbean.setRe_lev(rs.getInt("re_lev"));
				boardbean.setRe_ref(rs.getInt("re_ref"));
				boardbean.setRe_seq(rs.getInt("re_seq"));
				boardbean.setReadcount(rs.getInt("readcount"));
				boardbean.setSubject(rs.getString("subject"));
				boardbean.setFileName(rs.getString("fileName"));
				boardbean.setFileRealName(rs.getString("fileRealName"));
				boardList.add(boardbean);
				
			}
		} catch (Exception e) {
			System.out.println("getBoardList inner err :" +e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}
	
	public void updateReadCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql = "update i_board set readcount = readcount + 1 where num = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateReadCount inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
public BoardBean getBoardInfo(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		BoardBean boardbean = new BoardBean();
		try {
			
			con = getConnection();
		
			sql = "select * from i_board where num=?";
	
			pstmt=con.prepareStatement(sql);		
			
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
						
			if(rs.next()) {			
				boardbean.setContent(rs.getString("content"));
				boardbean.setDate(rs.getTimestamp("date"));
				boardbean.setName(rs.getString("name"));
				boardbean.setNum(rs.getInt("num"));
				boardbean.setPasswd(rs.getString("passwd"));
				boardbean.setRe_lev(rs.getInt("re_lev"));
				boardbean.setRe_ref(rs.getInt("re_ref"));
				boardbean.setRe_seq(rs.getInt("re_seq"));
				boardbean.setReadcount(rs.getInt("readcount"));
				boardbean.setSubject(rs.getString("subject"));
				boardbean.setFileName(rs.getString("fileName"));
				boardbean.setFileRealName(rs.getString("fileRealName"));
			}	
		}catch(Exception err) {
			System.out.println("getBoardInfo硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : "+ err);
		}finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		return boardbean; 		
	}

	public int updateBoard(BoardBean boardbean) {
		int check=0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql="select passwd from i_board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardbean.getNum());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(boardbean.getPasswd().equals(rs.getString("passwd"))) {
					check=1;
					sql = "update i_board set name=?, subject=?, content=? where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, boardbean.getName());
					pstmt.setString(2, boardbean.getSubject());
					pstmt.setString(3, boardbean.getContent());
					pstmt.setInt(4, boardbean.getNum());
					
					pstmt.executeUpdate();		
				}else {
					check=0;
				}
			}
		} catch (Exception e) {
			
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return check;
	}
	
	public void reInsertBoard(BoardBean boardbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int num = 0;
		try {
			con=getConnection();
			sql="select max(num) from i_board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			
			sql="update i_board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardbean.getRe_ref());
			pstmt.setInt(2, boardbean.getRe_seq());
			pstmt.executeUpdate();
			
			sql="insert into i_board(num,name,passwd,subject,content,re_ref,re_lev,re_seq,readcount,date,fileName,fileRealName) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardbean.getName());
			pstmt.setString(3, boardbean.getPasswd());
			pstmt.setString(4, boardbean.getSubject());
			pstmt.setString(5, boardbean.getContent());
			pstmt.setInt(6, boardbean.getRe_ref());
			pstmt.setInt(7, boardbean.getRe_lev()+1);
			pstmt.setInt(8, boardbean.getRe_seq()+1);
			pstmt.setInt(9, 0);
			pstmt.setTimestamp(10, boardbean.getDate());
			pstmt.setString(11, boardbean.getFileName());
			pstmt.setString(12, boardbean.getFileRealName());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("reInsertBoard inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public int getCount(String i_search) {
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int count=0;
		try {
			con=getConnection();
			sql = "select count(*) from i_board where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+i_search+"%");
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("getCount inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String i_search){
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql="select * from i_board where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+i_search+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardBean boardbean = new BoardBean();
				boardbean.setContent(rs.getString("content"));
				boardbean.setDate(rs.getTimestamp("date"));
				boardbean.setName(rs.getString("name"));
				boardbean.setNum(rs.getInt("num"));
				boardbean.setPasswd(rs.getString("passwd"));
				boardbean.setRe_lev(rs.getInt("re_lev"));
				boardbean.setRe_ref(rs.getInt("re_ref"));
				boardbean.setRe_seq(rs.getInt("re_seq"));
				boardbean.setReadcount(rs.getInt("readcount"));
				boardbean.setSubject(rs.getString("subject"));
				boardbean.setFileName(rs.getString("fileName"));
				boardbean.setFileRealName(rs.getString("fileRealName"));
				
				boardList.add(boardbean);
			}
		} catch (Exception e) {
			System.out.println("getBoardList inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}
	
	public void deleteBoard(int num) {
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		try {
			con=getConnection();
			sql="delete from i_board where num = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteBoard inner err :"+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//�뙎湲�異붽�
	public void insertComment(CommentBean cmtbean) {

		int commentcount =0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		try {
			con=getConnection();
			sql="insert into i_comment values(?,?,?,?,now())";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cmtbean.getCnum());
			pstmt.setInt(2, cmtbean.getNum());
			pstmt.setString(3, cmtbean.getId());
			pstmt.setString(4, cmtbean.getContent());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertComment inner err : "+e.getMessage());
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}//insertComment end
	
	public void deleteComment(int num, int cnum) {
		Connection con =null;
		PreparedStatement pstmt = null;
		String sql ="";
		try {
			con = getConnection();
			sql = "delete from i_comment where num = ? and cnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, cnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteComment inner err : " + e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
public ArrayList<CommentBean> getComment(int num){
		
		ArrayList<CommentBean> list = new ArrayList<>();
		CommentBean cmtbean = null;
		
		try {
			con=getConnection();
			String sql = "SELECT * FROM i_comment WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			
				cmtbean = new CommentBean();
				cmtbean.setId(rs.getString("id"));
				cmtbean.setNum(rs.getInt("num"));
				cmtbean.setCnum(rs.getInt("cnum"));
				cmtbean.setContent(rs.getString("content"));
				cmtbean.setDate(rs.getTimestamp("date"));
				list.add(cmtbean);
			}
			
		} catch (Exception e) {
			System.out.println("getCommnet inner err : "+e.getMessage());
			e.printStackTrace();
			
		}finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
}
