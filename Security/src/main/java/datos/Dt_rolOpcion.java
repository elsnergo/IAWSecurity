package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import entidades.Vw_rolopcion;

public class Dt_rolOpcion {
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
//		private ResultSet rsRol = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Metodo para visualizar las opciones de un rol
	public ArrayList<Vw_rolopcion> listaRolOpc(int idRol){
		ArrayList<Vw_rolopcion> listropc = new ArrayList<Vw_rolopcion>();
		try{
			c = poolConexion.getConnection();
			ps = c.prepareStatement("SELECT * FROM seguridad.vwrolopcion WHERE id_rol=?;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idRol);
			rs = ps.executeQuery();
			while(rs.next()){
				Vw_rolopcion vwrop = new Vw_rolopcion();
				vwrop.setId_rol(rs.getInt("id_rol"));
				vwrop.setRol(rs.getString("rol"));
				vwrop.setId_opcion(rs.getInt("id_opcion"));
				vwrop.setOpcion(rs.getString("opcion"));
				listropc.add(vwrop);
			}
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN listaRolOpc() "+ e.getMessage());
			e.printStackTrace();
		}
		finally{
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
		return listropc;
	}

}
