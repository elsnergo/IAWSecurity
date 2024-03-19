<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="datos.*, entidades.*, java.util.*"%>

<%

	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	PermisoTemporal tempPass = new PermisoTemporal();
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	int pass = 0; 
	
	if(request.getParameter("pass") != null){
		pass = Integer.parseInt(request.getParameter("pass"));
	}
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) session.getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());
		
		//RECUPERAMOS LA URL = MI OPCION ACTUAL
		int index = request.getRequestURL().lastIndexOf("/");
		String miPagina = request.getRequestURL().substring(index+1);
		
		//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
		if(tempPass.checkPermisson(Vw_empresa.empresaActual, Tbl_periodoContable.idPeriodoActual, Tbl_moneda.idMonedaActual) != true || PermisoTemporal.temporalFlag == true || pass > 0){
			for(Vw_rolopciones vrop : listOpc){
				if(vrop.getOpciones().trim().equals(miPagina.trim())){
					permiso = true; //ACCESO CONCEDIDO
					break;
				}
			}
		} else {
			response.sendRedirect("index.jsp");
			return; 
		}
	}
	else{
		response.sendRedirect("../login.jsp?msj=401");
		return;
	}
		
	if(!permiso){
		// response.sendRedirect("../login.jsp?msj=401");
		response.sendRedirect("../login.jsp?msj=404");
		return;
	}
	
%>

<%
ArrayList<Vw_empresa> listadoEmpresas = new ArrayList<>();
Dt_empresa datosEmpresas = new Dt_empresa();
listadoEmpresas = datosEmpresas.listarEmpresaLogin();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Sistema Contable | Empresa</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- bootstrap-daterangepicker -->
<link href="../vendors/bootstrap-daterangepicker/daterangepicker.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="x_panel">
							<div class="text-muted font-13 col-md-12"
								style="text-align: right;">
								<a href="addEmpresa.jsp"> 
									<i class="fa fa-plus-square"></i>
									Nuevo Empresa 
								</a>
								<br></br>
							</div>

							<div class="x_title">
								<p style="font-size: 30px">¡Buenos días, <%=vwur.getUsuario() %>!</p>
								<p>¿Qué empresa vamos a trabajar hoy?</p>
								<div class="clearfix"></div>
							</div>

							<div class="x_content row">
								<%
								if(pass == 0){
								for (Vw_empresa empresa : listadoEmpresas) {
									request.setAttribute("idE", empresa.getIdEmpresa());
								%>
								<div class="field item form-group col">
									<a href="indexPeriodoFiscal.jsp?idE=<%=empresa.getIdEmpresa()%>"> 
										<jsp:include page="fichaEmpresa.jsp">
											<jsp:param name="nombreEmp" value="<%=empresa.getNombreComercial()%>" />
											<jsp:param name="url_logo" value="<%=empresa.getLogo()%>" />
											<jsp:param name="altImg" value="<%=empresa.getNombreComercial()%>" />
											<jsp:param name="representanteEmp" value="<%=empresa.getRepresentante()%>" />
										</jsp:include>
									</a>
								</div>
								<%
								}
							}
								%>
								<%
								if(pass > 0){
									for (Vw_empresa empresa : listadoEmpresas) {
										request.setAttribute("idE", empresa.getIdEmpresa());
								%>	
								
								<div class="field item form-group col">
									<a href="indexPeriodoFiscal.jsp?idE=<%=empresa.getIdEmpresa()%>&status=ADMINPASS"> 
										<jsp:include page="fichaEmpresa.jsp">
											<jsp:param name="nombreEmp" value="<%=empresa.getNombreComercial()%>" />
											<jsp:param name="url_logo" value="<%=empresa.getLogo()%>" />
											<jsp:param name="altImg" value="<%=empresa.getNombreComercial()%>" />
											<jsp:param name="representanteEmp" value="<%=empresa.getRepresentante()%>" />
										</jsp:include>
									</a>
								</div>
								<%
									}
								}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">
					UCASH >> Sistema contable
				</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- Chart.js -->
	<script src="../vendors/Chart.js/dist/Chart.min.js"></script>
	<!-- jQuery Sparklines -->
	<script src="../vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
	<!-- Flot -->
	<script src="../vendors/Flot/jquery.flot.js"></script>
	<script src="../vendors/Flot/jquery.flot.pie.js"></script>
	<script src="../vendors/Flot/jquery.flot.time.js"></script>
	<script src="../vendors/Flot/jquery.flot.stack.js"></script>
	<script src="../vendors/Flot/jquery.flot.resize.js"></script>
	<!-- Flot plugins -->
	<script src="../vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
	<script src="../vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
	<script src="../vendors/flot.curvedlines/curvedLines.js"></script>
	<!-- DateJS -->
	<script src="../vendors/DateJS/build/date.js"></script>
	<!-- bootstrap-daterangepicker -->
	<script src="../vendors/moment/min/moment.min.js"></script>
	<script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
</body>
</html>