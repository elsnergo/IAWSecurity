package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entidades.Tbl_moneda;
import entidades.Tbl_rol;

public class Dt_tbl_moneda {
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Metodo para visualizar usuarios registrados y activos
	public ArrayList<Tbl_moneda> listMonedas(){
		ArrayList<Tbl_moneda> listaM = new ArrayList<Tbl_moneda>();
		try{
			c = poolConexion.getConnection(); //obtenemos una conexion del pool
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_moneda WHERE estado<>3;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = ps.executeQuery();
			while(rs.next()){
				Tbl_moneda tm = new Tbl_moneda();
				tm.setId_moneda(rs.getInt("id_moneda"));
				tm.setNombre(rs.getString("nombre"));
				tm.setSimbolo(rs.getString("simbolo"));
				tm.setEstado(rs.getInt("estado"));
				listaM.add(tm);
			}
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN listMonedas() "+ e.getMessage());
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
		return listaM;
	}
	
	

}
