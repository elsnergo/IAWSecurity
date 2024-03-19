<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="entidades.*, 
    datos.Dt_usuario,datos.Dt_rolOpciones,
    java.util.ArrayList;"
%>

  
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
	
	int idEmpresa = 0; 
	
	if(request.getParameter("idE") != null){
		idEmpresa = Integer.parseInt(request.getParameter("idE"));
		Vw_empresa.empresaActual = idEmpresa; 
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
<html>
<head>

<!-- <meta charset="ISO-8859-1"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Sistema Contable | Inicio </title>


    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

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
					<div class="x_title">
						<a><i class="fa fa-building" style="font-size:24px"> Empresa</i></a>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="field item form-group colspan-3">
							<a href="tbl_empresa.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-table" style="padding-right:10px;"></i>Empresa</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="listadoRepresentanteLegal.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-user" style="padding-right:10px;"></i>Representante Legal</a>
							<a href="tbl_TipoIdentificacion.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-credit-card" style="padding-right:10px;"></i>Tipo de identificación</a>
							<a href="tbl_departamento.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-location-arrow" style="padding-right:10px;"></i>Departamento</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_municipio.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-location-arrow" style="padding-right:10px;"></i>Municipio</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
						</div>
					</div>
				</div>
				
				<div class="x_panel">
					<div class="x_title">
						<a><i class="fa fa-bitcoin" style="font-size:24px"> Moneda</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-group colspan-3">				
							<a href="tbl_moneda.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-dollar" style="padding-right:10px;"></i>Monedas</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tasaCambio.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-percent" style="padding-right:10px;"></i>Tasas de Cambio</a>
						</div>
					</div>
				</div>
				
				<div class="x_panel">
					<div class="x_title">
						<a><i class="fa fa-suitcase" style="font-size:24px"> Maestro de Cuenta Contables</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-institution colspan-3">
							<a href="tbl_catalogocuenta.jsp?idE=<%=request.getParameter("idE") %>" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-book" style="padding-right:10px;"></i>Catálogo de Cuentas</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tipocuenta.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-tasks" style="padding-right:10px;"></i>Tipos de Cuentas</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_cuentacontable.jsp?idE=<%=request.getParameter("idE") %>" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-archive" style="padding-right:10px;"></i>Cuentas Contables</a>
						</div>
					</div>
				</div>
				
				<div class="x_panel">
					<div class="x_title">
						<a><i class="fa fa-balance-scale" style="font-size:24px"> Asientos Contables</i></a>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="field item form-group colspan-3">
							<a href="tbl_asientoContable.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-dollar" style="padding-right:10px;"></i>Asientos Contables</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_periodoContable.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-calendar" style="padding-right:10px;"></i>Periodo Contable</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_periodoFiscal.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-legal" style="padding-right:10px;"></i>Periodo Fiscal</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_tipoDocumento.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-file-text" style="padding-right:10px;"></i>Tipos de Documentos</a>
						</div>
					</div>
				</div>
				
				<div class="x_panel">
					
					<div class="x_title">
						<a><i class="fa fa-shield" style="font-size:24px"> Seguridad</i></a>
						<div class="clearfix"></div>
					</div>
					
					<div class="x_content">
						<div class="field item form-institution colspan-3">
							<a href="tbl_usuario.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-user" style="padding-right:10px;"></i>Gestionar Usuarios</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_usuarioRol.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-puzzle-piece" style="padding-right:10px;"></i>Asignar rol >> Usuario</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_rol.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-unlock" style="padding-right:10px;"></i>Gestionar Roles</a>
							<a style="padding-left:20px; padding-right:20px;"> </a>
							<a href="tbl_rolOpciones.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-cogs" style="padding-right:10px;"></i>Asignar opciones >> Rol</a>
							<a href="tbl_opciones.jsp" style="font-size:18px; padding-left:15px;"><i class="fa fa-lg fa-cog" style="padding-right:10px;"></i>Opciones del Sistema</a>
						</div>
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