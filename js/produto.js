$(document).ready(function() {
    $('#tabelaProdutos').DataTable({
        "processing": true,
        "serverSide": true,
        "ajax": "table/produto.jsp",
        "columns": [
            { "title": "Descrição" },
            { "title": "Quantidade" },
            { "title": "Data de Entrada" },
            { "title": "Ações" }
        ]
    });
});

function editarProduto(id) {
    alert("Abrir tela de edição para ID: " + id);
}
