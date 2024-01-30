package elms;
import java.sql.*;
import javax.servlet.*;
import java.util.*;
public class employee {
    
    Connection con;
    public employee(ServletContext application) throws Exception
    {
        String url,un,pass;
        url = application.getInitParameter("url");
        un = application.getInitParameter("username");
        pass = application.getInitParameter("password");
        String  driverClass = application.getInitParameter("driverClass");
        Class.forName(driverClass);
        con = DriverManager.getConnection(url,un,pass);
    }
    public int isEmail(String EmailAddress) throws SQLException
    {
        int eid = 0;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select e.*,d.* from employees e,departments d where e.emailId = '"+EmailAddress+"' and e.deptId = d.deptId");
        if(rs.next())
        {
            eid = (int)rs.getObject("eid");
        }
        rs.close();
        stmt.close();
        return eid;
    }
    public Hashtable read(int eid) throws SQLException
    {
        Hashtable h = new Hashtable();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select e.*,d.* from employees e,departments d where e.eid = '"+eid+"' and e.deptId = d.deptId");
        if(rs.next())
        {
            h.put("eid",rs.getObject("eid"));
            h.put("name",rs.getObject("name"));
            h.put("emailId", rs.getObject("emailId"));
            h.put("deptId", rs.getObject("deptId"));
            h.put("deptName",rs.getObject("deptName"));
            h.put("gender", rs.getObject("gender"));
            h.put("dob", rs.getObject("dob"));
            h.put("address", rs.getObject("address"));
            h.put("mobileNo",rs.getObject("mobileNo"));
            h.put("password",rs.getObject("password"));
            h.put("regDate",rs.getObject("regDate"));
            h.put("img",rs.getObject("img"));
            h.put("deptShortName", rs.getObject("deptShortName"));
        }
        rs.close();
        stmt.close();
        return h;
    }
     public Vector readAllId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from employees");
        while(rs.next())
        {
            v.add(rs.getObject("eid"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    public int add(String name,String emailId,int deptId,String gender,String dob,String address,String mobileNo,String password,String img) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("insert into employees(name,emailId,deptId,gender,dob,address,mobileNo,password,img) values(?,?,?,?,?,?,?,?,?)");
        pstmt.setObject(1,name);
        pstmt.setObject(2,emailId);
        pstmt.setObject(3,deptId);
        pstmt.setObject(4,gender);
        pstmt.setObject(5,dob);
        pstmt.setObject(6,address);
        pstmt.setObject(7,mobileNo);
        pstmt.setObject(8,password);
        pstmt.setObject(9,img);
        return pstmt.executeUpdate();
    }    

    public int update(int eid,String name,String emailId,int deptId,String gender,String dob,String address,String mobileNo,String password,String img) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update employees set name = ? , emailId = ? ,deptId = ?,gender = ?,dob = ?,address = ?,mobileNo = ?,password = ?,img = ? where eid = ?");
        pstmt.setObject(1,name);
        pstmt.setObject(2,emailId);
        pstmt.setObject(3,deptId);
        pstmt.setObject(4,gender);
        pstmt.setObject(5,dob);
        pstmt.setObject(6,address);
        pstmt.setObject(7,mobileNo);
        pstmt.setObject(8,password);
        pstmt.setObject(9,img);
        pstmt.setObject(10, eid);
        return pstmt.executeUpdate();
    }
    public int delete(int eid) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("delete from employees where eid = ?");
        pstmt.setObject(1, eid);
        return pstmt.executeUpdate();
    }
}
