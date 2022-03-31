package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import entidades.Tbl_user2;

public class Dt_user2 {
	
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rsUser2 = null;
	private PreparedStatement ps = null;
	
	//Metodo para llenar el RusultSet //para insert, update and delete
	public void llenaRsUser2(Connection c){
		try{
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user2;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUser2 = ps.executeQuery();
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR Tbl_user2 "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	//Metodo para almacenar nuevo usuario
	public boolean guardarUser(Tbl_user2 tus2){
	boolean guardado = false;
	try{
		c = poolConexion.getConnection();
		this.llenaRsUser2(c);
		rsUser2.moveToInsertRow();
		rsUser2.updateInt("id_user", tus2.getId_user());
		rsUser2.updateString("token", tus2.getToken());
		rsUser2.insertRow();
		rsUser2.moveToCurrentRow();
		guardado = true;
	}
	catch (Exception e) {
		System.err.println("ERROR AL GUARDAR Tbl_user2 "+e.getMessage());
		e.printStackTrace();
	}
	finally{
		try {
			if(rsUser2 != null){
				rsUser2.close();
			}
			if(c != null){
				poolConexion.closeConnection(c);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	return guardado;
}
	
	
	

}
