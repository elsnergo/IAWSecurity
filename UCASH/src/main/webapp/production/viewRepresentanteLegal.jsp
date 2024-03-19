<%@ page language="java" contentType="text/html;  charset=UTF-8"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>
	
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
String Representante = "";
Representante = request.getParameter("idRepresentanteLegal") == null ? "0" : request.getParameter("idRepresentanteLegal");

Vw_representanteLegal vRL = new Vw_representanteLegal();
Tbl_representanteLegal tRL = new Tbl_representanteLegal();

Dt_representanteLegal dtRl = new Dt_representanteLegal();

vRL = dtRl.getViewRepresentanteLegalbyID(Integer.parseInt(Representante));
tRL = dtRl.getRepresentanteLegalbyID(Integer.parseInt(Representante));

Tbl_tipoIdentificacion tipI = new Tbl_tipoIdentificacion();
Dt_tipoIdentificacion dtTId = new Dt_tipoIdentificacion();
tipI = dtTId.getTipoIdentificacionbyID(tRL.getIdTipoIdentifiacion());


%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Ver | Representante Legal</title>

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
		
			<!-- sidebar menu -->
				 <jsp:include page="navegacion.jsp"></jsp:include>	
					<!-- /sidebar menu -->
					
			<!-- top navigation -->
			
			<!-- /top navigation -->
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Mostrar Representante Legal</h3>
						</div>

						
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Formulario <small>Mostrar Representante Legal</small>
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="" method="post" novalidate>
										<span class="section">Datos de Representante Legal</span>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre
												Completo<span >*</span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input value="<%= vRL.getNombreCompleto() %>" class="form-control" class='optional'
													name="nombre completo" data-validate-length-range="5,15"
													type="text" readonly />
											</div>
										</div>
										
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Tipo<span></span>
											</label>
											<div class="col-md-6 col-sm-6">
												<input  class="form-control" type="text"
													class='optional' name="tipo" value="<%=vRL.getTipo()%>" readonly />
													 
											</div>
										</div>
										
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Correo<span
												>*</span></label>
											<div class="col-md-6 col-sm-6">
												<input value="<%= vRL.getCorreo() %>"  class="form-control" name="correo" class='email'
													required="required" type="email" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Teléfono<span
												>*</span></label>
											<div class="col-md-6 col-sm-6">
												<input value="<%= vRL.getTelefono() %>" class="form-control" type="tel" class='tel'
													name="telefono" required='required'
													data-validate-length-range="8,20" readonly/>
											</div>
										</div>
										

										
										
										
										<div class="ln_solid">
<div class="form-group" align="center">

<button type='button' onClick="window.location.href='listadoRepresentanteLegal.jsp'" class="btn btn-info">Regresar</button>

<button type="button" onClick="window.location.href='editRepresentanteLegal.jsp?idRepresentanteLegal=<%=vRL.getIdRepresentante()%>'" class="btn btn-primary">Editar</button>


<button type="button" onClick="window.location.href='deleteRepresentanteLegal.jsp?idRepresentanteLegal=<%=vRL.getIdRepresentante()%>'" class="btn btn-danger">Eliminar</button>

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
