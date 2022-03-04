package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entidades.Vw_userrol;
import entidades.Tbl_userrol;

public class Dt_userrol {
	
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rsUserRol = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Metodo para llenar el RusultSet //para insert, update and delete
	public void llena_rsUserRol(Connection c){
		try{
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_userrol;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUserRol = ps.executeQuery();
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR tbl_userrol "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
		//Metodo para visualizar usuarios registrados y activos
		public ArrayList<Vw_userrol> listarUserRol(){
		ArrayList<Vw_userrol> listUserRol = new ArrayList<Vw_userrol>();
		try{
			c = poolConexion.getConnection(); //obtenemos una conexion del pool
			ps = c.prepareStatement("SELECT * FROM seguridad.vwuserrol;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = ps.executeQuery();
			while(rs.next()){
				Vw_userrol vwur = new Vw_userrol(); //instanciamos a Vw_userrol
				vwur.setId_user(rs.getInt("id_user"));
				vwur.setUser(rs.getString("user"));
				vwur.setNombres(rs.getString("nombres"));
				vwur.setApellidos(rs.getNString("apellidos"));
				vwur.setId_rol(rs.getInt("id_rol"));
				vwur.setRol(rs.getString("rol"));
				vwur.setEstado(rs.getInt("estado"));
				listUserRol.add(vwur);
			}
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR vwuserrol "+ e.getMessage());
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
		return listUserRol;
	}

}
