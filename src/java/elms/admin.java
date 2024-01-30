package elms;
import java.sql.*;
import javax.servlet.*;
import java.util.*;

public class admin {

    Connection con;
    public admin(ServletContext application) throws Exception
    {
        String url,un,pass;
        url = application.getInitParameter("url");
        un = application.getInitParameter("username");
        pass = application.getInitParameter("password");
        String  driverClass = application.getInitParameter("driverClass");
        Class.forName(driverClass);
        con = DriverManager.getConnection(url,un,pass);
    }
    public Hashtable read(int adminId) throws SQLException
    {
        Hashtable h = new Hashtable();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from admins where id = '"+adminId+"'");
        if(rs.next())
        {
            h.put("id",rs.getObject("id"));
            h.put("name",rs.getObject("name"));
            h.put("emailId",rs.getObject("emailId"));
            h.put("pass",rs.getObject("pass"));
            h.put("createdAt",rs.getObject("createdAt"));
        }
        rs.close();
        stmt.close();
        return h;
    }
    public int add(String name,String emailId,String pass) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("insert into admins(name,emailId,pass) values(?,?,?)");
        pstmt.setObject(1,name);
        pstmt.setObject(2,emailId);
        pstmt.setObject(3, pass);
        return pstmt.executeUpdate();
    }    

    public int update(int adminId,String name,String emailId,String pass) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update admins set name = ?,emailId = ?,pass = ? where id = ?");
        pstmt.setObject(1,name);
        pstmt.setObject(2,emailId);
        pstmt.setObject(3,pass);
        pstmt.setObject(4,adminId);
        
        return pstmt.executeUpdate();
    }
    public int delete(int adminId) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("delete from admins where id = ?");
        pstmt.setObject(1, adminId);
        return pstmt.executeUpdate();
    }    
    public Vector readAllId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from admins");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }
     public int isEmail(String EmailAddress) throws SQLException
    {
        int aid = 0;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from admins where emailId = '"+EmailAddress+"'");
        if(rs.next())
        {
            aid = (int)rs.getObject("id");
        }
        rs.close();
        stmt.close();
        return aid;
    }
}
