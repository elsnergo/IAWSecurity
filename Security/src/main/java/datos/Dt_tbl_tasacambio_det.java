package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entidades.Tbl_tasacambio_det;

public class Dt_tbl_tasacambio_det {
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rsTscd = null;
	private PreparedStatement ps = null;
	
	//Metodo para llenar el RusultSet //para insert, update and delete
	public void llenarsTscd(Connection c){
		try{
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_tasacambio_det;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTscd = ps.executeQuery();
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR USUARIOS "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	//Metodo para almacenar nueva tbl_tasacambio_det
	public boolean guardarTasacd(Tbl_tasacambio_det tscd){
	boolean guardado = false;
	try{
		c = poolConexion.getConnection();
		this.llenarsTscd(c);
		rsTscd.moveToInsertRow();
		rsTscd.updateInt("id_tasaCambio", tscd.getId_tasacambio());
		rsTscd.updateDate("fecha",  new java.sql.Date(tscd.getFecha().getTime()));
		rsTscd.updateDouble("tipoCambio", tscd.getTipoCambio());
//		rsTscd.updateInt("estado", 1);
		rsTscd.insertRow();
		rsTscd.moveToCurrentRow();
		guardado = true;
	}
	catch (Exception e) {
		System.err.println("ERROR AL guardarTasacd() "+e.getMessage());
		e.printStackTrace();
	}
	finally{
		try {
			if(rsTscd != null){
				rsTscd.close();
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
