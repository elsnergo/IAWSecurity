package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entidades.Tbl_userrol;
import datos.Dt_userrol;

/**
 * Servlet implementation class Sl_gestionUserRol
 */
@WebServlet("/Sl_gestionUserRol")
public class Sl_gestionUserRol extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sl_gestionUserRol() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//	doGet(request, response);
		
		//obtenemos el valor de opcion
		int opc = 0;
		opc = Integer.parseInt(request.getParameter("opcion"));
		// INSTANCIAMOS LOS OBJETOS
		Tbl_userrol tur = new Tbl_userrol();
		Dt_userrol dtur = new Dt_userrol();
		// CONSTRUIMOS EL OBJETO CON LOS VALORES DE LOS CONTROLES
		tur.setId_user(Integer.parseInt(request.getParameter("cbxUser")));
		tur.setId_rol(Integer.parseInt(request.getParameter("cbxRol")));
		
		////////////////////////////////////////////////////////////////////
		
		switch(opc) {
		case 1:
			try {
				if(dtur.asignaRol(tur)) {
					response.sendRedirect("production/tbl_UserRol.jsp?msj=1");
				}else {
					response.sendRedirect("production/tbl_UserRol.jsp?msj=2");
				}
			}catch(Exception e) {
				System.out.println("Error Sl_gestionUserRol opc1: "+e.getMessage());
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
