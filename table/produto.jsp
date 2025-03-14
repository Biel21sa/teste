<%@page import="com.tetrasoft.data.produto.ProdutoEntity"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%@ include file="../logadoForce.jsp" %>
<%@ include file="../idioma.jsp" %>

<%
    String[] fields = { "descricao", "quantidade", "data_entrada" };
    String filtroDescricao = request.getParameter("filtroDescricao");
    String filtroQuantidade = request.getParameter("filtroQuantidade");

    int ultimoIndex = Integer.parseInt(request.getParameter("iDisplayStart"));
    int qntPorPagina = Integer.parseInt(request.getParameter("iDisplayLength"));
    int filtro = Integer.parseInt(request.getParameter("iSortCol_0"));
    String orderBy = request.getParameter("sSortDir_0") == null ? "asc" : request.getParameter("sSortDir_0");

    Connection conn = null;
    try {
        ProdutoEntity entity = new ProdutoEntity();
        conn = entity.retrieveConnection();

        String where = "1=1";
        if (filtroDescricao != null && !filtroDescricao.isEmpty()) {
            where += " AND descricao LIKE '%" + filtroDescricao + "%'";
        }
        if (filtroQuantidade != null && !filtroQuantidade.isEmpty()) {
            where += " AND quantidade = " + filtroQuantidade;
        }

        long totalEntradas = entity.getCount("1=1", conn);
        long totalEntradasFiltradas = entity.getCount(where, conn);

        where += " ORDER BY " + fields[filtro] + " " + orderBy + " LIMIT " + ultimoIndex + ", " + qntPorPagina;
        ArrayList<ProdutoEntity> produtos = entity.getArray(where, conn);

        JSONObject json = new JSONObject();
        json.put("sEcho", request.getParameter("sEcho"));
        json.put("iTotalRecords", totalEntradas);
        json.put("iTotalDisplayRecords", totalEntradasFiltradas);

        JSONArray data = new JSONArray();
        for (ProdutoEntity produto : produtos) {
            JSONArray row = new JSONArray();
            row.put(produto.getDescricao());
            row.put(produto.getQuantidade());
            row.put(produto.getDataEntrada());
            row.put("<a href='#' onclick='editarProduto(" + produto.getId() + ")'>Editar</a>");
            data.put(row);
        }

        json.put("aaData", data);
        out.print(json);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>
