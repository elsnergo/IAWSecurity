<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="entidades.Vw_usuariorol, entidades.Vw_empresa, entidades.Vw_rolopciones,entidades.Tbl_asientoContable,
	entidades.Vw_asientoContable, entidades.Tbl_periodoContable, 
	datos.Dt_rolOpciones, datos.Dt_asientoContable, datos.Dt_periodoContable, java.util.*;"%>

<%
//Placeholder para el mensaje
String codigoMensaje = "";

if (request.getParameter("msj") != null)
	codigoMensaje = request.getParameter("msj");

//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_rolOpciones dtro = new Dt_rolOpciones();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
boolean permiso = false; //VARIABLE DE CONTROL

//OBTENEMOS LA SESION
vwur = (Vw_usuariorol) session.getAttribute("acceso");
if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL
	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

	//RECUPERAMOS LA URL = MI OPCION ACTUAL
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index + 1);

	//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
	for (Vw_rolopciones vrop : listOpc) {
		if (vrop.getOpciones().trim().equals(miPagina.trim())) {
	permiso = true; //ACCESO CONCEDIDO
	break;
		}
	}
} else {
	response.sendRedirect("../login.jsp?msj=401");
	return;
}

if (!permiso) {
	// response.sendRedirect("../login.jsp?msj=401");
	response.sendRedirect("page_403.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Reportes | Asiento Contable</title>

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

<!--Jquery Toast Plugin -->
<link href="../vendors/jquery-toast-plugin/jquery.toast.min.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<input type="hidden" id="idMensaje" value="<%=codigoMensaje%>" />
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Asiento Contable - Generar resumen</h3>
						</div>

<!-- 						<div class="title_right"> -->
<!-- 							<div -->
<!-- 								class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search"> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>

					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-md-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>Reporte según fecha</h2>

									<div class="clearfix"></div>
								</div>

								<div class="x_content">
									<br />
									<form id="demo-form2" data-parsley-validate action="../Sl_resumenAsientoContable" method="post"
										class="form-horizontal form-label-left">
										
										<input
											type="hidden" value="<%=Vw_empresa.empresaActual%>"
											name="empresaActual" id="empresaActual" />

										<div class="item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">Fecha de inicio: <span class="required">*</span>
											</label>
											
											<div class="col-md-6 col-sm-6 ">
												<input id="fecha_inicio" name="fecha_inicio" class="date-picker form-control"
													placeholder="dd-mm-yyyy" type="text" required="required"
													type="text" onfocus="this.type='date'"
													onmouseover="this.type='date'" onclick="this.type='date'"
													onblur="this.type='text'"
													onmouseout="timeFunctionLong(this)">
												<script>
													function timeFunctionLong(
															input) {
														setTimeout(
																function() {
																	input.type = 'text';
																}, 60000);
													}
												</script>
											</div>
										</div>
										
										<div class="item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">Fecha final: <span class="required">*</span>
											</label>
											
											<div class="col-md-6 col-sm-6 ">
												<input id="fecha_final" name="fecha_final" class="date-picker form-control"
													placeholder="dd-mm-yyyy" type="text" required="required"
													type="text" onfocus="this.type='date'"
													onmouseover="this.type='date'" onclick="this.type='date'"
													onblur="this.type='text'"
													onmouseout="timeFunctionLong(this)">
												<script>
													function timeFunctionLong(
															input) {
														setTimeout(
																function() {
																	input.type = 'text';
																}, 60000);
													}
												</script>
											</div>
										</div>
										
										<div class="ln_solid"></div>
										<div class="item form-group">
											<div class="col-md-6 col-sm-6 offset-md-3">
												<a href="tbl_asientoContable.jsp" class="btn btn-primary" type="button">Regresar</a>
												<button type="submit" class="btn btn-success" formtarget="_blank">Imprimir resumen</button>
											</div>
										</div>

									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- footer content -->

	<!-- /footer content -->

	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- iCheck -->
	<script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- Datatables -->
	<script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="../vendors/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>
	<script src="../vendors/jquery-toast-plugin/jquery.toast.min.js"></script>

	<script>
		// Toasts y alertas
		$("document")
				.ready(
						function() {
							var codigoMensaje = $("#idMensaje").val();

							switch (codigoMensaje) {
							case "3":
								$
										.toast({
											text : "Asiento contable editado con éxito",
											heading : 'Éxito',
											icon : 'success',
											showHideTransition : 'slide',
											allowToastClose : false,
											hideAfter : 5000,
											stack : 5,
											position : 'top-center',
											textAlign : 'left',
											loader : true,
											loaderBg : '#9EC600',
										});
								break;

							case "4":
								$
										.toast({
											text : "No se actualizaron los detalles del asiento contable", // Text that is to be shown in the toast
											heading : 'Advertencia', // Optional heading to be shown on the toast
											icon : 'warning', // Type of toast icon
											showHideTransition : 'slide', // fade, slide or plain
											allowToastClose : false, // Boolean value true or false
											hideAfter : 5000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
											stack : 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
											position : 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values

											textAlign : 'left', // Text alignment i.e. left, right or center
											loader : true, // Whether to show loader or not. True by default
											loaderBg : '#9EC600', // Background color of the toast loader

										});
								break;

							case "5":
								$
										.toast({
											text : "No se pudo actualizar el asiento contable", // Text that is to be shown in the toast
											heading : 'Error', // Optional heading to be shown on the toast
											icon : 'error', // Type of toast icon
											showHideTransition : 'slide', // fade, slide or plain
											allowToastClose : false, // Boolean value true or false
											hideAfter : 5000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
											stack : 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
											position : 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values

											textAlign : 'left', // Text alignment i.e. left, right or center
											loader : true, // Whether to show loader or not. True by default
											loaderBg : '#9EC600', // Background color of the toast loader
										});
								break;

							case "7":
								$
										.toast({
											text : "Asiento contable borrado exitosamente", // Text that is to be shown in the toast
											heading : 'Éxito', // Optional heading to be shown on the toast
											icon : 'success', // Type of toast icon
											showHideTransition : 'slide', // fade, slide or plain
											allowToastClose : false, // Boolean value true or false
											hideAfter : 5000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
											stack : 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
											position : 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values

											textAlign : 'left', // Text alignment i.e. left, right or center
											loader : true, // Whether to show loader or not. True by default
											loaderBg : '#9EC600', // Background color of the toast loader
										});
								break;

							case "8":
								$
										.toast({
											text : "Ocurrió un error al borrar el asiento contable", // Text that is to be shown in the toast
											heading : 'Error', // Optional heading to be shown on the toast
											icon : 'error', // Type of toast icon
											showHideTransition : 'slide', // fade, slide or plain
											allowToastClose : false, // Boolean value true or false
											hideAfter : 5000, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
											stack : 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
											position : 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values

											textAlign : 'left', // Text alignment i.e. left, right or center
											loader : true, // Whether to show loader or not. True by default
											loaderBg : '#9EC600', // Background color of the toast loader
										});
								break;

							default:
								break;
							}
						});
	</script>

</body>
</html>