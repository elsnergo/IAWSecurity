<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>

    
<!DOCTYPE html>
<html lang="es">
<%
String cc = "";
cc = request.getParameter("idCuenta") == null ? "0" : request.getParameter("idCuenta");

Vw_catalogo_tipo_cuentacontable vwCc = new Vw_catalogo_tipo_cuentacontable();
Dt_cuentaContable dtCc = new Dt_cuentaContable();
vwCc = dtCc.getCuentaContableById(Integer.parseInt(cc));


%>

<%
String CCD = "";
Vw_cuentacontable_cuentacontable_det vwCCD = new Vw_cuentacontable_cuentacontable_det();
Dt_cuentaContable_Det dtCCD = new Dt_cuentaContable_Det();

int idCCD = request.getParameter("idCuenta") != null ? Integer.parseInt(request.getParameter("idCuenta")): 0;
vwCCD = dtCCD.getCCDbyID(idCCD);
%>

<%
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
	response.sendRedirect("page_403.jsp");
	//response.sendRedirect("page_403.jsp");
	return;
}
%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<!-- <meta charset="utf-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Ver | Cuenta Contable</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">

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
							<h3>Mostrar Cuenta Contable</h3>
						</div>

						
					</div>
					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Mostrar Cuenta Contable
									</h2>

									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form class="" action="" method="post" novalidate>
										<span class="section">Datos de Cuenta Contable Maestro</span>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Número de Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="numeroCuenta" id="numeroCuenta" 
												value="<%= vwCc.getNumeroCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SC" id="SC"
												value="<%= vwCc.getsC() %>" />
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SsC" id="SsC" 
												value="<%= vwCc.getSsC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Sub-Sub-Sub-Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="SssC" id="SssC" 
												value="<%= vwCc.getSssC() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nombre Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="nombreCuenta" id="nombreCuenta" 
												value="<%= vwCc.getNombreCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Nivel</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="nivel" id="nivel" 
												value="<%= vwCc.getNivel() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Rubro</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="number" class="optional" name="rubro" id="rubro" 
												value="<%= vwCc.getRubro() %>"/>
											</div>
										</div>

										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">Tipo Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="tipoCuenta" id="tipoCuenta" 
												value="<%=vwCc.getTipoCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3 label-align">SubTipo Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="tipoCuenta" id="tipoCuenta" 
												value="<%=vwCc.getSubtipoCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Catálogo Cuenta</label>
											<div class="col-md-6 col-sm-6">
												<input readonly class="form-control" type="text" class="optional" name="catalogoCuenta" id="catalogoCuenta" 
												value="<%= vwCc.getCatalogoCuenta() %>"/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Inicial</label>
											<div class="col-md-6 col-sm-6">

												<input class="form-control" value="<%=vwCCD.getSaldoInicial()%>" name="saldoInicial" id="saldoInicial" readonly/>
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Debe</label>
											<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getDebe()%>" name="debe" id="debe" readonly/>
											</div>
										</div>	
																		
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Haber</label>
											<div class="col-md-6 col-sm-6">

												<input type="text" class="form-control" value="<%=vwCCD.getHaber()%>" name="haber" id="haber" readonly/>
											
											</div>
										</div>
										
										<div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Saldo Final</label>
											<div class="col-md-6 col-sm-6">

												<input class="form-control" value="<%=vwCCD.getSaldoFinal()%>" name="saldoFinal" id="saldoFinal" readonly/>

											</div>
										</div>
										
										<%-- <div class="field item form-group">
											<label class="col-form-label col-md-3 col-sm-3  label-align">Cuenta contable*</label>
										<div class="col-md-6 col-sm-6">
												<input class="form-control" value="<%=vwCCD.getNombreCuenta()%>" name="CuentaContable" id="CuentaContable" readonly/>
											</div>
										</div> --%>
										
										<div class="ln_solid">
										<p> </p>
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<p> </p>
													<a  href="tbl_cuentacontable.jsp">
														<button id="CancelarCCD" type="button" class="btn btn-primary">Regresar</button>
													</a>
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
		</div>
		</div>
			

			<!-- /page content -->
	
	<footer>
		<div class="pull-right">Sistema contable</div>
		<div class="clearfix"></div>
	</footer>

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
	<script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script src="../vendors/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

</body>
</html>