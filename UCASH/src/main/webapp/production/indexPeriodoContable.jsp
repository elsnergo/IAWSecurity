<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="datos.*, entidades.*, java.util.*"%>
    
<%
//JAlert flag
	String signal = ""; 
	if(request.getParameter("msj") != null){
		signal = request.getParameter("msj");
	}		

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
	String adminPass = ""; 
	
	if(request.getParameter("pass") != null){
		pass = Integer.parseInt(request.getParameter("pass"));
	}
	
	if(request.getParameter("status") != null){
		adminPass = request.getParameter("status"); 
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
		if(tempPass.checkPermisson(Vw_empresa.empresaActual, Tbl_periodoContable.idPeriodoActual, Tbl_moneda.idMonedaActual) != true 
		|| PermisoTemporal.temporalFlag == true || pass > 0 || adminPass.equals("ADMINPASS") || adminPass.equals("ADMINPASSPF") || adminPass.equals("ADMINPASSPC")){
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
		response.sendRedirect("page_403.jsp");
		return;
	}
	
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
<title>UCASH | Periodo Contable</title>

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
<link rel="stylesheet" href="../vendors/jAlert/dist/jAlert.css" />
<!-- Select2 -->
<link href="../vendors/select2/dist/css/select2.min.css"
	rel="stylesheet" />
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
								<a href="addPeriodoContable.jsp"> 
									<i class="fa fa-plus-square"></i>
									Nuevo Periodo Contable 
								</a>
								<br></br>
							</div>

							<div class="x_title">
								<p style="font-size: 30px">¡Buenos días, <%=vwur.getUsuario()%>!</p>
								<p>Seleccione el periodo contable con el que trabajara.</p>
								<div class="clearfix"></div>
							</div>

							<div class="x_content">
									<form class="" action="../Sl_periodoContable" method="post" novalidate>
									  <input type="hidden" value="4" name="opcion" id="opcion"/>
									  <input type="hidden" value="<%=adminPass%>" name="admin_pass" id="admin_pass"/>
									  <input type="hidden" value="<%=signal%>" id="JAlertInput"/>
										<span class="section">Periodo Contable</span><br>
										<!-- <a href="./addNuevoPeriodoContable.jsp">Agregar período contable</a> -->
			
										<div class="field item form-group">
                                            <label class="col-form-label col-md-3 col-sm-3  label-align">Periodo Contable<span class="required">:</span></label>
                                            <div class="col-md-6 col-sm-6">
<!--                                                 <input class="form-control" class='optional' name="occupation" data-validate-length-range="5,15" type="text" /></div> -->
												<%
							                      	ArrayList<Vw_periodoContable> listPeriodosContable = new ArrayList<Vw_periodoContable>();
							                      	Dt_periodoContable dtpc = new Dt_periodoContable();
							                      	listPeriodosContable = dtpc.listarperiodoContablePorIdFiscal(vwur.getIdPeriodoFiscal());
								                 %>
								                 <select class="form-control js-example-basic-single" name="combobox_periodoContable" id="combobox_periodoContable" required="required">
												  <option value="">Seleccione...</option>
												  <% 
												  	for(Vw_periodoContable pF : listPeriodosContable){
												  %>
												  <option value="<%=pF.getIdPeriodoContable()%>"><%="Fecha de inicio: " + pF.getFechaInicio() + " " + " Fecha de finalización: " + pF.getFechaFinal()%></option>
												  <%
												  	}
												  %>
								                
												</select>
											</div>
                                        </div>
										<div class="ln_solid">
											<div class="form-group">
												<div class="col-md-6 offset-md-3">
													<button type='submit' class="btn btn-primary">Aceptar</button>
													<%
														if(adminPass.equals("ADMINPASS")){
													%>
													<button onClick="window.location.href='indexPeriodoFiscal.jsp?status=<%=adminPass%>'" 
														type="button" class="btn btn-danger">Cancelar</button>
													<%
													} else if(adminPass.equals("ADMINPASSPF")) {
													%>
													<button onClick="window.location.href='indexPeriodoFiscal.jsp?status=<%=adminPass%>'" 
														type="button" class="btn btn-danger">Cancelar</button>
													<%
													} else if(adminPass.equals("ADMINPASSPC")) {
													%>
													<button onClick="window.location.href='index.jsp'" 
														type="button" class="btn btn-danger">Cancelar</button>
													<%
													} else {
													%>
													<button onClick="window.location.href='indexPeriodoFiscal.jsp'" 
														type="button" class="btn btn-danger">Cancelar</button>
													<%
													}
													%>
													
												</div>
											</div>
										</div>
									</form>
								</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			
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
	<!-- Select2 -->
	<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
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
	<!-- jAlert -->
    <script src="../vendors/jAlert/dist/jAlert.min.js"></script>
    <script src="../vendors/jAlert/dist/jAlert-functions.min.js"></script>
    
    <script>
    var mensaje = "";
	mensaje = document.getElementById("JAlertInput").value; 
	
	//Inicio select2
	$(document).ready(function() {
		$('.js-example-basic-single').select2();
	});
	//Cierre Select2
	
	$(document).ready(function() {

        if (mensaje == "1") {
        	errorAlert('Error', 'No eligio un periodo contable.')
        }

        $("#example1").DataTable({
            "responsive": true,
            "lengthChange": false,
            "autoWidth": false,
            "buttons": ["excel", "pdf"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

        /*$('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "responsive": true,
        });*/
    });
    </script>
    <script src="../vendors/select2/dist/js/select2.min.js"></script>
</body>
</html>