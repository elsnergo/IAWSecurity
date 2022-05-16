package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entidades.Tbl_tasacambio;

public class Dt_tbl_tasacambio {
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rsTsc = null;
	private PreparedStatement ps = null;
	
	//Metodo para llenar el RusultSet //para insert, update and delete
	public void llenarsTsc(Connection c){
		try{
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_tasacambio;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsTsc = ps.executeQuery();
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR USUARIOS "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	//Metodo para almacenar nueva tbl_tasacambio
	public int guardarTasac(Tbl_tasacambio tsc){
		int guardado = 0;
		try{
			c = poolConexion.getConnection();
			this.llenarsTsc(c);
			rsTsc.moveToInsertRow();
			rsTsc.updateString("mes", tsc.getMes());
			rsTsc.updateInt("anio", tsc.getAnio());
			rsTsc.updateInt("id_monedaO", tsc.getId_monedaO());
			rsTsc.updateInt("id_monedaC", tsc.getId_monedaC());
			rsTsc.updateInt("estado", 1);
			rsTsc.insertRow();
			rsTsc.moveToCurrentRow();
			this.llenarsTsc(c);
			rsTsc.last();
			guardado = rsTsc.getInt("id_tasaCambio");
		}
		catch (Exception e) {
			System.err.println("ERROR AL GUARDAR guardarTasaC() "+e.getMessage());
			e.printStackTrace();
		}
		finally{
			try {
				if(rsTsc != null){
					rsTsc.close();
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
