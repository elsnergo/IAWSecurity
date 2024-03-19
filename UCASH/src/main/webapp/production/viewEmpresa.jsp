<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="entidades.Tbl_empresa, entidades.Vw_empresa,entidades.Vw_usuariorol, entidades.Vw_rolopciones, entidades.Vw_representanteLegal, 
	entidades.Tbl_periodoFiscal, entidades.Tbl_departamento, entidades.Vw_municipio,
	datos.Dt_empresa, datos.Dt_representanteLegal, datos.Dt_municipio, datos.Dt_periodoFiscal, datos.Dt_departamento, datos.Dt_rolOpciones , 
	 
	 java.util.ArrayList;"%>
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
		response.sendRedirect("page_403.jsp");
		//response.sendRedirect("page_403.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html lang="es">
<%
String empresa = "";
empresa = request.getParameter("idEmpresa") == null ? "0" : request.getParameter("idEmpresa");
Vw_empresa vwEmpresa = new Vw_empresa();
Dt_empresa dtEmpresa = new Dt_empresa();
vwEmpresa = dtEmpresa.getEmpresaByID(Integer.parseInt(empresa));
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Ver | Empresa</title>

<!-- Bootstrap -->
<link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
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
<link
	href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- top navigation -->
			
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Mostrar empresa</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div class="col-md-5 col-sm-5 form-group pull-right top_search"> -->
<!-- 								<div class="input-group"> -->
<!-- 									<input type="text" class="form-control" -->
<!-- 										placeholder=" Buscar por..."> <span -->
<!-- 										class="input-group-btn"> -->
<!-- 										<button class="btn btn-default" type="button">Go!</button> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Formulario <small>Mostrar empresa</small>
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="" method="post" novalidate>
										<span class="section">Datos de empresa</span>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">RUC<span>*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" data-validate-length-range="6"
													data-validate-words="2" name="ruc" id="ruc" readonly />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Razón
												social<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional'
													name="razonSocial" id="razonSocial"
													data-validate-length-range="5,15" type="text" readonly />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre
												Comercial <span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" class='optional'
													name="nombreComercial" id="nombreComercial"
													data-validate-length-range="5,15" type="text" readonly />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Correo<span>*</span></label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" name="correo" id="correo"
													class='email' readonly type="email" />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Teléfono<span>*</span></label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="tel" class='tel'
													name="telefono" id="telefono" required='required'
													data-validate-length-range="8,20" />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Dirección<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" class='optional'
													name="direccion" id="direccion"
													data-validate-length-range="5,100" type="text" readonly />
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Representante
												legal<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="email"
													class='email' name="representanteLegal"
													id="representanteLegal" data-validate-linked='email'
													required='required' />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Periodo
												fiscal<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="email"
													class='email' name="periodoFiscal" id="periodoFiscal"
													data-validate-linked='email' required='required' />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Departamento<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="email"
													class='email' name="departamento" id="departamento"
													data-validate-linked='email' required='required' />
											</div>
										</div>
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Municipio<span>*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="email"
													class='email' name="municipio" id="municipio"
													class="municipio" data-validate-linked='email'
													required='required' />
											</div>
										</div>
											<div class="ln_solid">
											<div class="form-group" align="center">
												<button type="button" onClick="window.location.href='editEmpresa.jsp?idEmpresa=<%=vwEmpresa.getIdEmpresa()%>'"
													class="btn btn-primary">Editar</button>
												
												<button type='button' onClick="window.location.href='tbl_empresa.jsp'"
													class="btn btn-danger">Cancelar</button>

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
    function setForm(){
    	document.getElementById("ruc").value = "<%=vwEmpresa.getRuc()%>";
    	document.getElementById("razonSocial").value = "<%=vwEmpresa.getRazonSocial()%>";
    	document.getElementById("nombreComercial").value = "<%=vwEmpresa.getNombreComercial()%>";
    	document.getElementById("telefono").value = "<%=vwEmpresa.getTelefono()%>";
    	document.getElementById("correo").value = "<%=vwEmpresa.getCorreo()%>";
    	document.getElementById("direccion").value = "<%=vwEmpresa.getDireccion()%>";
    	document.getElementById("representanteLegal").value = "<%=vwEmpresa.getRepresentante()%>";
    	document.getElementById("departamento").value = "<%=vwEmpresa.getDepartamentoNombre()%>";
    	document.getElementById("municipio").value = "<%=vwEmpresa.getMunicipioNombre()%>";
    	
    	var date = "<%=vwEmpresa.getPeriodoFiscal()%>"; 
    	
    	if(date != null) {
    	document.getElementById("periodoFiscal").value = "<%=vwEmpresa.getPeriodoFiscal()%>";
		} else {
			document.getElementById("periodoFiscal").value = "No se ha asignado un periodo fiscal";
		}
    }
		window.onload = setForm;
	</script>
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