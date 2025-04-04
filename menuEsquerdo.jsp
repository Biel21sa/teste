<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tetrasoft.data.usuario.FuncionalidadeEntity"%>
<%@page import="com.tetrasoft.data.usuario.PerfilFuncionalidadeEntity"%>
<%@page import="com.tetrasoft.data.usuario.UsuarioEntity"%>
<%@page import="com.technique.engine.util.StringUtil"%>

<!-- AQUI COME�A O MENU ESQUERDO -->

<div class="leftpanel" id="leftPanel">

	<div class="leftmenu">
		<ul class="nav nav-tabs nav-stacked">
			<li class="nav-header"><%=p.get("NAVEGACAO") %></li>
				<li class="active" id="menuX"><a href="painel.jsp">
					<span class="iconfa-laptop"></span><%= p.get("PAINEL") %></a>
			</li>

			<li id="menuProdutos">
				<a href="produto.jsp">
					<span class="iconfa-book"></span> Produtos
				</a>
			</li>			
			
			<%
				String idPerfil = usuarioLogado.getIdPerfil().toString();
				PerfilFuncionalidadeEntity pf = new PerfilFuncionalidadeEntity();
				FuncionalidadeEntity func = new FuncionalidadeEntity();
				ArrayList a = pf.getArray( new String[]{"funcionalidade f"}, "f.idFuncionalidade = perfil_funcionalidade.idFuncionalidade AND idPerfilAcesso = " + idPerfil + " AND (incluir = 1 OR alterar = 1 OR excluir = 1 OR consultar = 1) ORDER BY grupo, f.nome" + idioma, 1, 999, conn_home);

				int grupo = 1;				
				for( int i = 0; i < a.size(); i++ ) {
					pf = (PerfilFuncionalidadeEntity)a.get(i);
					
					func.setIdFuncionalidade( pf.getIdFuncionalidade() );
					func.getThis(conn_home);
					if(func.getOculto() == 0 ){
						if( func.getGrupo() != grupo ) {
							grupo = func.getGrupo();
							out.print("<center><hr style='border-bottom: 1px solid #4C4C50; border-top: 0px'/></center>");
						}
						
						String n = func.getNome(idioma);
			%>

					<li class="<%= func.getLabel1() == null ? "" : "dropdown" %>" id="menu<%= i %>">
						<% 	if( func.getComando1().startsWith("http") || func.getComando1().contains("http") ) { %>
								<a href="<%= func.getComando1() %>" target="_blank" onclick="activateMenu(<%= i %>)">
									<span class="<%= func.getIcone() %>"></span><%= n %>
								</a>
						<% 	} else if( func.getComando1().startsWith("javascript") ) { %>
								<a href="<%= func.getLabel1() == null ? func.getComando1() : "" %>" onclick="activateMenu(<%= i %>)">
									<span class="<%= func.getIcone() %>"></span><%= n %>
								</a>
						<% 	} else { %>
								<a href="<%= func.getLabel1() == null ? "javascript:abre('miolo', '" + func.getComando1() + "')" : "" %>" class="<%= (func.getComando1() != null && func.getComando1().contains("fancy")) ? "grouped_elements" : "" %>" onclick="activateMenu(<%= i %>)">
									<span class="<%= func.getIcone() %>"></span><%= n %>
								</a>
						<% 	} %>
						
						
						<%	if( func.getLabel1() != null ) { %>
							<ul>
								<%	if( func.getComando1() != null && func.getComando1().contains("fancy") ) { %>
										<li><a href="<%= func.getComando1() %>" class="grouped_elements"><%= func.getLabel1() %></a></li>
								<%	} else { %>
										<li><a href="javascript:abre('miolo', '<%= func.getComando1() %>')" onclick="activateMenu(<%= i %>)"><%= func.getLabel1() %></a></li>
								<%	} %>
								
								<%	if( func.getComando2() != null && func.getComando2().contains("fancy") ) { %>
										<li><a href="<%= func.getComando2() %>" class="grouped_elements" onclick="activateMenu(<%= i %>)"><%= func.getLabel2() %></a></li>
								<%	} else { %>
										<li><a href="javascript:abre('miolo', '<%= func.getComando2() %>')" onclick="activateMenu(<%= i %>)"><%= func.getLabel2() %></a></li>
								<%	} %>

								<%	if( func.getComando3() != null && func.getComando3().contains("fancy") ) { %>
										<li><a href="<%= func.getComando3() %>" class="grouped_elements" onclick="activateMenu(<%= i %>)"><%= func.getLabel3() %></a></li>
								<%	} else { %>
										<li><a href="javascript:abre('miolo', '<%= func.getComando3() %>')" onclick="activateMenu(<%= i %>)"><%= func.getLabel3() %></a></li>
								<%	} %>
							</ul>
						<%	} %>
					</li>
			<%		}
				} %>

				<script>
					activateFancybox();
				</script>
		</ul>			
	</div>
	
	<!--leftmenu-->

</div>
<!-- leftpanel -->

<script>
	function activateMenu(id) {
		$("#menuX").removeClass('active');

		<%	for( int i = 0; i < a.size(); i++ ) { %>
				try {
					$("#menu<%= i %>").removeClass('active');
				} catch(e) {}
		<%	} %>
		
		$("#menu"+id).addClass('active');	
			
	}	
	
</script>
