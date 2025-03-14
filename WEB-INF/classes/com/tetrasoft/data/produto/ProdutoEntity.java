package com.tetrasoft.data.produto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProdutoEntity {
    private final int id;
    private String descricao;
    private int quantidade;
    private String dataEntrada;

    public ProdutoEntity() {}

    public ProdutoEntity(int id, String descricao, int quantidade, String dataEntrada) {
        this.id = id;
        this.descricao = descricao;
        this.quantidade = quantidade;
        this.dataEntrada = dataEntrada;
    }

    public int getId() { return id; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }

    public String getDataEntrada() { return dataEntrada; }
    public void setDataEntrada(String dataEntrada) { this.dataEntrada = dataEntrada; }

    // Método para obter conexão (pode ser modificado se houver um pool de conexões)
    public Connection retrieveConnection() throws Exception {
        return com.tetrasoft.db.ConnectionFactory.getConnection();
    }

    // Método para contar total de produtos
    public long getCount(String where, Connection conn) throws Exception {
        String sql = "SELECT COUNT(*) FROM produto WHERE " + where;
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        return rs.getLong(1);
    }

    // Método para obter lista de produtos
    public ArrayList<ProdutoEntity> getArray(String where, Connection conn) throws Exception {
        String sql = "SELECT * FROM produto WHERE " + where;
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        ArrayList<ProdutoEntity> lista = new ArrayList<>();
        while (rs.next()) {
            ProdutoEntity produto = new ProdutoEntity(
                rs.getInt("id"),
                rs.getString("descricao"),
                rs.getInt("quantidade"),
                rs.getString("data_entrada")
            );
            lista.add(produto);
        }
        return lista;
    }
}
