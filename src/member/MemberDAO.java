package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {
	
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource ds;
	private ResultSet rs;
	
	private Connection getConnection() throws Exception{
		
		Context init = new InitialContext();
		
		DataSource ds =(DataSource)init.lookup("java:comp/env/jdbc/jspdb");
		
		Connection con = ds.getConnection();
	
		return con;
	}//getConnection() end
	
	
	public void freeResource() {
		try {
			if(con!=null)con.close();
			if(pstmt!=null)pstmt.close();
			if(rs!=null)rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//freeResource() end
	
	public int insertMember(MemberBean memberbean) {
		String sql="";
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			sql="insert into jspdb.member(id,passwd,name,email,mtel,zip,address1,address2) "+
					" values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);

			pstmt.setString(1, memberbean.getId());
			pstmt.setString(2, memberbean.getPasswd());
			pstmt.setString(3, memberbean.getName());
			pstmt.setString(4, memberbean.getEmail());
			pstmt.setString(5, memberbean.getMtel());
			pstmt.setString(6, memberbean.getZip());
			pstmt.setString(7, memberbean.getAddress1());
			pstmt.setString(8, memberbean.getAddress2());
//			pstmt.setTimestamp(9, memberbean.getReg_date());
			
//			System.out.println("여기 : " + memberbean.getReg_date());
			return pstmt.executeUpdate();		
		} catch (Exception e) {
			System.out.println("insertMember inner err : " + e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		return -1; // fail
	}//insertMember end
	
	public int idCheck(String id) {		
		Connection con = null;	
		PreparedStatement pstmt = null;	
		String sql = "";	
		ResultSet rs = null;		
		int check = 0; 	
		try {
			con=getConnection();		
			sql = "select id from jspdb.member where id =?";			
			pstmt=con.prepareStatement(sql);			
			pstmt.setString(1, id);		
			rs = pstmt.executeQuery();		
			if(rs.next()) {				
				check = 1; 
			}else {
				check = 0;
			}
		} catch (Exception e) {
			System.out.println("idCheck inner err : "+e.getMessage());
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // finally end
		
		return check;
		
	}//idCheck() end
	
	public String authNum() {
		StringBuffer authNum = new StringBuffer();

		for (int i = 0; i < 6; ++i) {
			int randNum = (int) (Math.random() * 10.0D);
			authNum.append(randNum);
		}

		return authNum.toString();
	} // authNum end
	
	public boolean sendEmail(String email, String authNum) {
		boolean result = false;
		// TODO : 수정 해야함
		String sender = "joinAdmin@gmail.com";
		String subject = "memberJoinAuthNumber.";
		String content = "This is your verification number. Please return to the member registration page and enter the verification code    [<b>" + authNum + "</b>] ";

		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			Authenticator auth = new Gmail();
			Session session = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(session);
			Address senderAd = new InternetAddress(sender);
			Address receiverAd = new InternetAddress(email);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(senderAd);
			message.addRecipient(RecipientType.TO, receiverAd);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			Transport.send(message);
			result = true;
		} catch (Exception var13) {
			result = false;
			System.out.println("Error in SendEmail()");
			var13.printStackTrace();
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	
	public boolean dupEmail(String email) {
		boolean result = true;

		try {
		this.con = this.getConnection();
		String sql = "select email from jspdb.member where email=?";
			this.pstmt = this.con.prepareStatement(sql);
			this.pstmt.setString(1, email);
			this.rs = this.pstmt.executeQuery();
			if (this.rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch (Exception var7) {
			System.out.println("Error in dupEmail()");
			var7.printStackTrace();
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	public int loginMember(String id, String passwd) {
		int check=0;
		String sql="";
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			con=getConnection();
			sql="select passwd from jspdb.member where id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("passwd").equals(passwd)) {
					check = 1;
				}else {
					check=0;
				}
			}else {
				check = -1;
			}
		} catch (Exception e) {
			System.out.println("loginMember inner err : " + e);
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
	
	public MemberBean getMember(String id) {
		String sql ="";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean memberbean = new MemberBean();
		try {
			con = getConnection();
			sql="select * from jspdb.member where id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs =pstmt.executeQuery();
			if(rs.next()) {
				memberbean.setId(rs.getString("id"));
				memberbean.setPasswd(rs.getString("passwd"));
				memberbean.setName(rs.getString("name"));
				memberbean.setEmail(rs.getString("email"));
				memberbean.setMtel(rs.getString("mtel"));
				memberbean.setZip(rs.getString("zip"));
				memberbean.setAddress1(rs.getString("address1"));
				memberbean.setAddress2(rs.getString("address2"));				
			}
		} catch (Exception e) {
			System.out.println("getMember inner err : "+ e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return memberbean;
	}
	
	public void updateMember(MemberBean memberbean) {
		String sql="";
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con=getConnection();
			sql="update member set passwd=?, mtel=?, zip=?, address1=?, address2=? where id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberbean.getPasswd());
			pstmt.setString(2, memberbean.getMtel());
			pstmt.setString(3, memberbean.getZip());
			pstmt.setString(4, memberbean.getAddress1());
			pstmt.setString(5, memberbean.getAddress2());
			pstmt.setString(6, memberbean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateMember inner err : " + e);
		}finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} // updateMember end
	
	public void deleteMember(String id) {
		Connection con=null;
		PreparedStatement pstmt = null;
		String sql="";
		try {
			con=getConnection();
			sql="delete from jspdb.member where id =?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("deleteMember inner err : "+e);
		} finally {
			try {
				if(con!=null)con.close();
				if(pstmt!=null)pstmt.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}//deleteMember end
}
