package datos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import entidades.Tbl_user;

public class Dt_usuario {
	
	//Atributos
	poolConexion pc = poolConexion.getInstance(); 
	Connection c = null;
	private ResultSet rsUsuario = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	
	//Metodo para llenar el RusultSet //para insert, update and delete
	public void llenaRsUsuario(Connection c){
		try{
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR USUARIOS "+ e.getMessage());
			e.printStackTrace();
		}
	}
	
	//Metodo para visualizar usuarios registrados y activos
	public ArrayList<Tbl_user> listaUserActivos(){
		ArrayList<Tbl_user> listUser = new ArrayList<Tbl_user>();
		try{
			c = poolConexion.getConnection(); //obtenemos una conexion del pool
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user WHERE estado<>3;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = ps.executeQuery();
			while(rs.next()){
				Tbl_user user = new Tbl_user(); //instanciamos a usuario
				user.setId_user(rs.getInt("id_user"));
				user.setUser(rs.getString("user"));
				user.setPwd(rs.getString("pwd"));
				user.setNombres(rs.getString("nombres"));
				user.setApellidos(rs.getNString("apellidos"));
				user.setEmail(rs.getString("email"));
				/*user.setfCreacion(rs.getTimestamp("fcreacion"));*/
				user.setEstado(rs.getInt("estado"));
				listUser.add(user);
			}
		}
		catch (Exception e){
			System.out.println("DATOS: ERROR EN LISTAR USUARIOS "+ e.getMessage());
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
		return listUser;
	}
	
	//Metodo para almacenar nuevo usuario
	public int guardarUser(Tbl_user tus){
//		boolean guardado = false;
		int guardado = 0;
		try{
			c = poolConexion.getConnection();
			this.llenaRsUsuario(c);
			rsUsuario.moveToInsertRow();
			rsUsuario.updateString("user", tus.getUser());
			rsUsuario.updateString("nombres", tus.getNombres());
			rsUsuario.updateString("apellidos", tus.getApellidos());
			rsUsuario.updateString("email", tus.getEmail());
			rsUsuario.updateString("pwd", tus.getPwd());
			rsUsuario.updateTimestamp("fecha_creacion", tus.getFecha_creacion());
			rsUsuario.updateInt("usuario_creacion", tus.getUsuario_creacion());
			//GUARDAMOS EL CODIGO DE VERIFICACION //PARA VERIFICAR EL EMAIL
			rsUsuario.updateString("codVerificacion", tus.getCodVerificacion());
			rsUsuario.updateInt("estado", 0); //0 PORQUE EL USUARIO ES REGISTRADO PERO SU EMAIL AUN NO HA SIDO VERIFICADO
			rsUsuario.insertRow();
			rsUsuario.moveToCurrentRow();
			this.llenaRsUsuario(c);
			rsUsuario.last();
			guardado = rsUsuario.getInt("id_user");
//			guardado = true;
		}
		catch (Exception e) {
			System.err.println("ERROR AL GUARDAR Tbl_User "+e.getMessage());
			e.printStackTrace();
		}
		finally{
			try {
				if(rsUsuario != null){
					rsUsuario.close();
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
	
	
	public Tbl_user getUserbyID(int idUser) {
		Tbl_user tu = new Tbl_user();
		try {
			c = poolConexion.getConnection();
			ps = c.prepareStatement("SELECT * FROM seguridad.tbl_user where estado <> 3 and id_user=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idUser);
			rs = ps.executeQuery();
			if(rs.next()) {
				tu.setId_user(rs.getInt("id_user"));
				tu.setNombres(rs.getString("nombres"));
				tu.setApellidos(rs.getString("apellidos"));
				tu.setUser(rs.getString("user"));
				tu.setPwd(rs.getString("pwd"));
				tu.setEmail(rs.getString("email"));
				tu.setUrlFoto(rs.getString("urlFoto"));
				tu.setCodVerificacion(rs.getString("codVerificacion"));
				tu.setEstado(rs.getInt("estado"));
			}
		}catch (Exception e)
		{
			System.out.println("DATOS ERROR getUserbyID(): "+ e.getMessage());
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
		
		return tu;
	}
	
	
	// Metodo para modificar usuario
	public boolean modificarUser(Tbl_user tus)
	{
		boolean modificado=false;	
		try
		{
			c = poolConexion.getConnection();
			this.llenaRsUsuario(c);
			rsUsuario.beforeFirst();
			while (rsUsuario.next())
			{
				if(rsUsuario.getInt(1)==tus.getId_user())
				{
					rsUsuario.updateString("nombres", tus.getNombres());
					rsUsuario.updateString("apellidos", tus.getApellidos());
					rsUsuario.updateTimestamp("fecha_edicion", tus.getFecha_edicion());
					rsUsuario.updateInt("usuario_edicion", tus.getUsuario_edicion());
					rsUsuario.updateInt("estado", 2);
					rsUsuario.updateRow();
					modificado=true;
					break;
				}
			}
		}
		catch (Exception e)
		{
			System.err.println("ERROR AL modificarUser() "+e.getMessage());
			e.printStackTrace();
		}
		finally
		{
			try {
				if(rsUsuario != null){
					rsUsuario.close();
				}
				if(c != null){
					poolConexion.closeConnection(c);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return modificado;
	}
	
	
	// Metodo para eliminar usuario
	public boolean eliminarUser(Tbl_user tus)
	{
		boolean eliminado=false;	
		try
		{
			c = poolConexion.getConnection();
			this.llenaRsUsuario(c);
			rsUsuario.beforeFirst();
			while (rsUsuario.next()){
				if(rsUsuario.getInt(1)==tus.getId_user()){
					rsUsuario.updateTimestamp("fecha_eliminacion", tus.getFecha_eliminacion());
					rsUsuario.updateInt("usuario_eliminacion", tus.getUsuario_eliminacion());
					rsUsuario.updateInt("estado", 3);
					rsUsuario.updateRow();
					eliminado=true;
					break;
				}
			}
		}
		catch (Exception e){
			System.err.println("ERROR AL eliminarUser() "+e.getMessage());
			e.printStackTrace();
		}
		finally{
			try {
				if(rsUsuario != null){
					rsUsuario.close();
				}
				if(c != null){
					poolConexion.closeConnection(c);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return eliminado;
	}

	
	//METODO PARA GENERAR UN CODIGO DE VERIFICACION //
	public static String randomAlphaNumeric(int count) 
	{
		StringBuilder builder = new StringBuilder();
		while (count-- != 0) 
		{
			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		return builder.toString();
	}

}
