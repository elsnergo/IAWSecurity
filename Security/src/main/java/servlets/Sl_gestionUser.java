package servlets;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Tbl_user;
import entidades.Tbl_user2;
import datos.Encrypt;
import datos.Dt_usuario;
import datos.Dt_user2;

/**
 * Servlet implementation class Sl_gestionUser
 */
@WebServlet("/Sl_gestionUser")
public class Sl_gestionUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sl_gestionUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		
		//obtenemos el valor de opcion
		int opc = 0;
		opc = Integer.parseInt(request.getParameter("opcion"));
		// INSTANCIAMOS LOS OBJETOS
		Tbl_user tus = new Tbl_user();
		Tbl_user2 tus2 = new Tbl_user2();
		Dt_usuario dtus = new Dt_usuario();
		Dt_user2 dtus2 = new Dt_user2();
		Encrypt dtenc = new Encrypt();
		// CONSTRUIMOS EL OBJETO CON LOS VALORES DE LOS CONTROLES
		tus.setNombres(request.getParameter("txtnombres"));
		tus.setApellidos(request.getParameter("txtapellidos"));
		tus.setUser(request.getParameter("txtuser"));
		tus.setEmail(request.getParameter("txtemail"));
		// CONSTRUIMOS EL OBJETOS CON LOS CAMPOS DE CONTROL Y AUDITORIA
		//PARA GUARDAR LA FECHA Y HORA DE CREACION
        Date fechaSistema = new Date();
        tus.setFecha_creacion(new java.sql.Timestamp(fechaSistema.getTime()));
        System.out.println("tus.getFechaCreacion(): "+tus.getFecha_creacion());
        tus.setUsuario_creacion(1);//1 valor temporal mientras se programa la sesion
		
		//GENERAMOS EL CODIGO DE VERIFICACION Y LO ASIGNAMOS AL OBJETO
		tus.setCodVerificacion(dtus.randomAlphaNumeric(10)); // 10 PORQUE ES LA CANTIDAD DE CARACTERES QUE SOPORTA LA BD
		
		/////// ENCRIPTACION DE LA PWD //////////
		String key = "";
		String pwdEncrypt = "";
		key=dtenc.generarLLave();
		tus2.setToken(key);
		pwdEncrypt = dtenc.getAES(request.getParameter("txtclave").trim(),key);
		tus.setPwd(pwdEncrypt);
		/////////////////////////////////////////
		
				
				////////////////////////////////////////////////////////////////////
				
				switch(opc) {
				case 1:
					try {
						tus2.setId_user(dtus.guardarUser(tus));
						if(tus2.getId_user()>0) {
							if(dtus2.guardarUser(tus2)) {
								response.sendRedirect("production/tbl_usuarios.jsp?msj=1");
							}
						}else {
							response.sendRedirect("production/tbl_usuarios.jsp?msj=2");
						}
					}catch(Exception e) {
						System.out.println("Error Sl_gestionUser opc1: "+e.getMessage());
						e.printStackTrace();
					}
					break;
				case 2:
					//codigo
					break;
				default:
					//codigo
					break;
					
				}
	}

}
