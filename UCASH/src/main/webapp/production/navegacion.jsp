<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="datos.*, entidades.*, java.util.*, 
	org.apache.commons.text.StringEscapeUtils;"%>

<%
	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	Tbl_moneda moneda = new Tbl_moneda();
	Tbl_periodoFiscal pfiscal = new Tbl_periodoFiscal();
	Tbl_periodoContable pContable = new Tbl_periodoContable();
	Dt_moneda dtMoneda = new Dt_moneda();
	Dt_periodoFiscal periodoFiscal = new Dt_periodoFiscal();
	Dt_periodoContable periodoContable  = new Dt_periodoContable();
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) request.getSession(true).getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

		pfiscal = periodoFiscal.obtenerPFiscalPorId(vwur.getIdPeriodoFiscal());
		
		pContable = periodoContable.obtenerPContablePorId(vwur.getIdPeriodoContable());
		
		moneda = dtMoneda.getMonedaByID(vwur.getIdMoneda());
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		for(Vw_rolopciones vrop : listOpc){
			if(vrop.getOpciones().trim().equals(miPagina.trim())){
				permiso = true; //ACCESO CONCEDIDO
				break;
			}
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		response.sendRedirect("page_403.jsp");
		//response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
	

<%
String nombreEmpresa = "";
if (vwur.getIdEmpresa() != 0) {
	Dt_empresa datosEmpresa = new Dt_empresa();
	int idEmpresa = vwur.getIdEmpresa();
	nombreEmpresa = datosEmpresa.getNombreEmpresaPorId(idEmpresa);
}
%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="ISO-8859-1"> -->
</head>
<body>
	<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.jsp" class="site_title" 
							title="Retorno a la pantalla de Inicio"
							style="font-weight: bolder;">
							<!-- <i class="fa fa-money"></i> -->
							<!-- <i class="fa fa-home"></i> -->
							<img alt="UCASH" src="images/logo_ucash(2).jpg" 
	                  		style="width: 40px; height: 40px;">&nbsp;
							<span>UCASH</span>
						</a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix">
						<div class="profile_pic">
							<img src="../<%=vwur.getUrlFoto() == null ? "fotos_usuarios/img.jpg" : vwur.getUrlFoto()%>" alt="..." class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Bienvenido,</span>
							<h2><%=StringEscapeUtils.escapeHtml4(vwur.getNombre())+" "+StringEscapeUtils.escapeHtml4(vwur.getApellido())%></h2>
						</div>
					</div>
					<!-- /menu profile quick info -->
					
					<div class="clearfix">
						<div>
							<h2 style="font-size: 14px; font-family: serif; color:white;">
								Trabajando: 
							</h2>
							<h3 style="font-size: 12px; font-family: serif; color:white; padding-left:10px;">
								<%=nombreEmpresa %>
							</h3>
						</div>
						<h2 style="font-size: 14px; font-family: serif; color:white;">
							Moneda:
						</h2>
						<h3 style="font-size: 12px; font-family: serif; color:white; padding-left:10px;">
							<%=moneda.getNombre() %>
						</h3>						
						<h2 style="font-size: 14px; font-family: serif; color:white;">
							Periodo fiscal:
						</h2>
						<h3 style="font-size: 12px; font-family: serif; color:white; padding-left:10px;">
							Inicio: <%=pfiscal.getFechaInicio() %><br>Final: <%=pfiscal.getFechaFinal() %>
						</h3>
							
						<h2 style="font-size: 14px; font-family: serif; color:white;">
							Periodo contable:
						</h2>
						<h3 style="font-size: 12px; font-family: serif; color:white; padding-left:10px;">
							Inicio: <%=pContable.getFechaInicio() %><br>Final: <%=pContable.getFechaFinal() %>
						</h3>
					</div>
					<br>

					<!-- sidebar menu -->
					<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
<!-- 						<div class="menu_section"> -->
<!-- 							<ul class="nav side-menu"> -->
<!-- 								<li> -->
<!-- 									<a href="index.jsp"> -->
<!-- 										<i class="fa fa-home"></i> -->
<!-- 										Inicio -->
<!-- 									</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->

						<div class="menu_section">
							<h3>UCASH: Módulo Contable</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-building"></i>Datos Empresa<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_empresa.jsp">Listar Empresas</a></li>
										<li><a href="listadoRepresentanteLegal.jsp">Listar Rep. Legal</a></li>
										<li><a href="tbl_TipoIdentificacion.jsp">Listar Tipo Identificacion</a></li>
										<li><a href="tbl_departamento.jsp">Listar Departamentos</a></li>
										<li><a href="tbl_municipio.jsp">Listar Municipios</a></li>
									</ul>
								</li>
								
								<li><a><i class="fa fa-dollar"></i>Gestionar Monedas<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_moneda.jsp">Listar Moneda</a></li>
										<li><a href="tbl_tasaCambio.jsp">Listar Tasas de Cambio</a></li>
									</ul>
								</li>

								<li><a><i class="fa fa-file"></i>Maestro Ctas Contables<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_catalogocuenta.jsp">Listar Catálogos Ctas</a></li>
										<li><a href="tbl_tipocuenta.jsp">Listar Tipos de Cuentas</a></li>
										<li><a href="tbl_cuentacontable.jsp">Listar Cuentas Contables</a></li>
									</ul>
								</li>

								<li><a><i class="fa fa-book"></i>Asientos Contables<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="tbl_asientoContable.jsp">Listar Asientos Contables</a></li>
										<li><a href="tbl_periodoContable.jsp">Listar Periodos Contables</a></li>
										<li><a href="tbl_periodoFiscal.jsp">Listar Periodos Fiscales</a></li>
										<li><a href="tbl_tipoDocumento.jsp">Listar Tipos Documentos</a></li>
									</ul>
								</li>
									
									<li>
										<a>
											<i class="fa fa-shield"></i> 
												Módulo Seguridad 
											<span class="fa fa-chevron-down"></span>
										</a>
										<ul class="nav child_menu">
											<li><a href="tbl_usuario.jsp">Gestionar Usuarios</a></li>
											<li><a href="tbl_usuarioRol.jsp">Asignar rol >> Usuario</a></li>
											<li><a href="tbl_rol.jsp">Gestionar Roles</a></li>										
											<li><a href="tbl_rolOpciones.jsp">Asignar opciones >> Rol</a></li>
											<li><a href="tbl_opciones.jsp">Opciones del Sistema</a></li>	
										</ul>
									</li>
									
									<%
// 										if(vwur.getId_rol() == 12){										
									%>
									
									<li>
										<a>
											<i class="fa fa-cog"></i>
											Opciones del Entorno
											<span class="fa fa-chevron-down"></span>
										</a>
										<ul class="nav child_menu">
											<li><a href="indexMultiempresa.jsp?pass=200">Cambiar empresa</a></li>
											<li><a href="indexPeriodoFiscal.jsp?status=ADMINPASSPF">Cambiar período fiscal</a></li>
											<li><a href="indexPeriodoContable.jsp?status=ADMINPASSPC">Cambiar período contable</a></li>
											<li><a href="indexMoneda.jsp?pass=200">Cambiar moneda</a></li>
										</ul>
									</li>
									<%
// 										}										
									%>
							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->
					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>
					<nav class="nav navbar-nav">
						<ul class=" navbar-right">
							<li class="nav-item dropdown open" style="padding-left: 15px;">
								<a href="javascript:;" class="user-profile dropdown-toggle"
								aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown"
								aria-expanded="false"> <img src="../<%=vwur.getUrlFoto() == null ? "fotos_usuarios/img.jpg" : vwur.getUrlFoto()%>" alt=""><%=vwur.getNombre()+" "+vwur.getApellido() %>

							</a>
								<div class="dropdown-menu dropdown-usermenu pull-right"
									aria-labelledby="navbarDropdown">
									<a class="dropdown-item" href="../login.jsp"><i class="fa fa-sign-out pull-right"></i> Sesión</a>
								</div>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->

</body>
</html>