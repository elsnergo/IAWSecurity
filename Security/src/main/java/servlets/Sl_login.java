package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import datos.Dt_usuario;
import entidades.Vw_userrol;

/**
 * Servlet implementation class Sl_login
 */
@WebServlet("/Sl_login")
public class Sl_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sl_login() {
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
		// doGet(request, response);
		
		Dt_usuario dtu = new Dt_usuario();
		Vw_userrol vwur = new Vw_userrol();
		String usuario = "";
		String clave = "";
		String codigoV = "";
		int rolId = 0;
		int opc = 0;
		
		opc = Integer.parseInt(request.getParameter("opcion"));
		usuario = request.getParameter("usuario");
		clave = request.getParameter("pwd");
		rolId = Integer.parseInt(request.getParameter("rol"));
		codigoV= request.getParameter("codVerificacion");
		
		
		switch(opc) {
		case 1:
			try{
				if(dtu.dtverificarLogin(usuario, clave, rolId)){
					vwur = dtu.dtGetVwUR(usuario);
					HttpSession hts = request.getSession(true);
					hts.setAttribute("acceso", vwur);
					response.sendRedirect("production/index.jsp");
				}
				else{
					response.sendRedirect("login.jsp?msj=403");
				}	
			}
			catch(Exception e){
				System.out.println("Servlet: El error es: "+e.getMessage());
				e.printStackTrace();
			}
			break;
			
		case 2:
			try{
				if(dtu.dtverificarLogin2(usuario, clave, rolId, codigoV)){
					vwur = dtu.dtGetVwUR(usuario);
					HttpSession hts = request.getSession(true);
					hts.setAttribute("acceso", vwur);
					response.sendRedirect("production/index.jsp");
				}
				else{
					response.sendRedirect("login.jsp?msj=403");
				}	
			}
			catch(Exception e){
				System.out.println("Servlet: El error es: "+e.getMessage());
				e.printStackTrace();
			}
			break;
			
		default:
			break;
				
		}
		
		
		
		
		
		
		
	}

}
