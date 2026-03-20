let todosUsuarios = []; // Carregado via API
let PATENTES = [];
const diasSemana = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"];

function popularFiltroPostos(select, patentes, todos=true) {
    select.innerHTML = todos ? '<option value="">Todos as Patentes</option>' : '';
    patentes.forEach(posto => {
        if (posto) { // Evita valores vazios
            const option = document.createElement('option');
            option.value = posto.nome;
            option.textContent = posto.nome;
            select.appendChild(option);
        }
    });
}