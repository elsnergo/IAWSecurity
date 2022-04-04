package negocio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import datos.poolConexion;

public class Ng_usuario {
	
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	public boolean existeUser(String userName) {
		boolean existe = false;
		try {
			c = poolConexion.getConnection();
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user where user=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			if(rs.next()) {
				existe = true;
			}
		}catch (Exception e){
			System.out.println("DATOS ERROR existeUser(): "+ e.getMessage());
			e.printStackTrace();
		}
		finally {
			try {
				if(rs != null){
					rs.close();
				}
				if(ps != null){
					ps.close();
				}
				if(c != null){
					poolConexion.closeConnection(c);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return existe;
	}
	
	public boolean existeEmail(String userEmail) {
		boolean existe = false;
		try {
			c = poolConexion.getConnection();
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user where email=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			if(rs.next()) {
				existe = true;
			}
		}catch (Exception e){
			System.out.println("DATOS ERROR existeEmail(): "+ e.getMessage());
			e.printStackTrace();
		}
		finally {
			try {
				if(rs != null){
					rs.close();
				}
				if(ps != null){
					ps.close();
				}
				if(c != null){
					poolConexion.closeConnection(c);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return existe;
	}

}
