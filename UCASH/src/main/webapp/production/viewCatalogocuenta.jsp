<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*"%>
    
   <%
	//INVALIDA LA CACHE DEL NAVEGADOR //
	response.setHeader( "Pragma", "no-cache" );
	response.setHeader( "Cache-Control", "no-store" );
	response.setDateHeader( "Expires", 0 );
	response.setDateHeader( "Expires", -1 );
	
	//DECLARACIONES
	Vw_usuariorol vwur = new Vw_usuariorol();
	Dt_rolOpciones dtro = new Dt_rolOpciones();
	ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
	boolean permiso = false; //VARIABLE DE CONTROL
	
	//OBTENEMOS LA SESION
	vwur = (Vw_usuariorol) session.getAttribute("acceso");
	if(vwur!=null){
		//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
		
		listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());
		
		
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
		// response.sendRedirect("../login.jsp?msj=401");
		response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
    
<!DOCTYPE html>

<%
String catalogo = "";
catalogo = request.getParameter("IdCatalogo") == null ? "0" : request.getParameter("IdCatalogo");

Tbl_catalogocuenta tCatalogo = new Tbl_catalogocuenta();
Dt_catalogocuenta dtCatalogo = new Dt_catalogocuenta();
tCatalogo = dtCatalogo.getTableCatalogocuentaByID(Integer.parseInt(catalogo));

Tbl_empresa tEmpresa = new Tbl_empresa();
Dt_empresa dtEmpresa = new Dt_empresa();
tEmpresa = dtEmpresa.getTableEmpresaByID(tCatalogo.getIdEmpresa());
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Visualizar | Catálogo de Cuentas</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
<!-- Datatables -->

<link
	href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
<link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
<link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
<link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">


<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			
			<jsp:include page="navegacion.jsp"></jsp:include>			
			
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Datos individuales del catálogo de cuentas seleccionado</h3>
						</div>

						<!-- <div class="title_right">
							<div class="col-md-5 col-sm-5 form-group pull-right top_search">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Buscar..."> <span
										class="input-group-btn">
										<button class="btn btn-default" type="button">Ir</button>
									</span>
								</div>
							</div>
						</div> -->
						
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									
									<div class="clearfix"></div>
								</div>
								
								<div class="x_content">
									<form class="" action="" method="post" novalidate>
										<span class="section">Datos del catálogo de cuentas seleccionado</span>
			
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">ID del catálogo de cuentas<span></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="IdCatalogo" type="text" value="<%=tCatalogo.getIdCatalogo()%>" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Título<span></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="titulo" type="text" value="<%=tCatalogo.getTitulo()%>" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Descripción<span></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="descripcion" type="text" value="<%=tCatalogo.getDescripcion()%>" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Empresa<span></span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional' name="idEmpresa" type="text" value="<%=tEmpresa.getNombreComercial()%>" readonly/>
											</div>
										</div>
										
										
									<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
												<button type='button'
													onClick="window.location.href='tbl_catalogocuenta.jsp'"
													class="btn btn-primary">Regresar</button>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->
			<!-- footer content -->
			<footer>
				<div class="pull-right">Sistema contable by UCASH</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

	<!-- Javascript functions	-->
	<script>
		function hideshow() {
			var password = document.getElementById("password1");
			var slash = document.getElementById("slash");
			var eye = document.getElementById("eye");

			if (password.type === 'password') {
				password.type = "text";
				slash.style.display = "block";
				eye.style.display = "none";
			} else {
				password.type = "password";
				slash.style.display = "none";
				eye.style.display = "block";
			}

		}
	</script>

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- validator -->
	<!-- <script src="../vendors/validator/validator.js"></script> -->

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

</body>
</html>