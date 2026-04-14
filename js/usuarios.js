let direcaoOrdenacao = 1;
let colunaAnterior = '';

function ordenar(coluna) {
    if (colunaAnterior === coluna) {
        direcaoOrdenacao *= -1;
    } else {
        direcaoOrdenacao = 1;
        colunaAnterior = coluna;
    }

    const listaParaOrdenar = Array.isArray(todosUsuarios) ? todosUsuarios : Object.values(todosUsuarios);

    listaParaOrdenar.sort((a, b) => {
        let valA = a[coluna];
        let valB = b[coluna];

        // Lógica Especial para Hierarquia Militar
        if (coluna === 'p_g' || coluna === 'patente') {
            // Busca o objeto da patente no array global PATENTES pelo NOME que está no usuário
            const pA = PATENTES.find(p => p.nome === (a.patente));
            const pB = PATENTES.find(p => p.nome === (b.patente));

            // Usa o atributo 'ordem' para comparar. Se não achar, usa um valor alto (99)
            valA = pA ? parseInt(pA.ordem) : 99;
            valB = pB ? parseInt(pB.ordem) : 99;

            // Na hierarquia, menor 'ordem' (ex: 1) é maior precedência (Cel)
            // Invertemos o sinal para que o primeiro clique mostre do maior para o menor posto
            return (valA - valB) * direcaoOrdenacao;
        }

        // Ordenação padrão para Texto (Nome, CPF, etc)
        if (typeof valA === 'string') {
            return valA.localeCompare(valB || "", 'pt-BR') * direcaoOrdenacao;
        }
        
        // Ordenação para Números (ID)
        return (valA - valB) * direcaoOrdenacao;
    });

    todosUsuarios = listaParaOrdenar;
    renderizarTabela(todosUsuarios);
    
    // IMPORTANTE: Reaplica o filtro visual (display: none) após reordenar
    filtrarTabela(); 
}

    
// 1. Carregar dados da API
function carregarUsuarios() {
    fetch(`../api/get_arranchamento.php?om=${$om_id}`)
        .then(r => r.json())
        .then(dados => {
            console.log('dados', dados);
            todosUsuarios = dados.usuarios;
            PATENTES = dados.patentes;
            renderizarTabela(todosUsuarios);
            popularFiltroPostos(document.getElementById('filtroPatente'), PATENTES);
            popularFiltroPostos(document.getElementById('editPatente'), PATENTES, false);
        });
}

function formatarCPF(cpf) {
    if (!cpf) return "";
    // Remove qualquer caractere que não seja número
    const puro = cpf.toString().replace(/\D/g, "");
    // Aplica a máscara 000.000.000-00
    return puro.replace(/(\={0,11})(\d{3})(\d{3})(\d{3})(\d{2})/, "$2.$3.$4-$5");
}

function formatarPadraoSemanal(padrao) {
    if (!padrao) return "---";
    const dados = typeof padrao === 'string' ? JSON.parse(padrao) : padrao;
    const diasOrdem = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
    // Mapeia e gera o HTML
    return diasOrdem.map(dia => {
        const valor = dados[dia] || ""; // Pega o valor (ex: "CA")
        if (!valor) return `<span class="dia-vazio" title="${dia}"><strong>${dia.substring(0, 1)}</strong></span>`;
        return `<span class="dia-com-valor" title="${dia}: ${valor}">
                    <strong>${dia.substring(0, 1)}:</strong> ${valor}
                </span>`;
    }).join(' ');
}

// 2. Renderizar Tabela
function renderizarTabela(lista) {
    const corpo = document.getElementById('lista-geral-usuarios');
    const statusFiltro = document.getElementById('filtroStatus').value;
    corpo.innerHTML = lista
        //.filter(u => statusFiltro === 'todos' || u.ativo == statusFiltro)
        .map(u => `
            <tr data-id="${u.id}">
                <td>${u.p_g || u.patente}</td> <!-- Ajustado para sua estrutura -->
                <td>${u.nome_guerra}</td>
                <td>${u.nome_completo}</td>
                <td>${formatarCPF(u.cpf)}</td>
                <td class="td_padrao_semanal">${formatarPadraoSemanal(u.padrao_semanal)}</td>
                <td class="${u.ativo == "t" ? 'status-ativo' : 'status-inativo'}">${u.ativo == "t" ? 'Ativo' : 'Inativo'}
                <td><button onclick="editarUsuario(${u.id})">✏️</button></td>
            </tr>
        `).join('');
}


// 3. Filtragem Dinâmica
function filtrarTabela() {
    const busca = document.getElementById('buscaNome').value.toLowerCase();
    const patente = document.getElementById('filtroPatente').value;
    const status = document.getElementById('filtroStatus').value; // Pegando o status também
    const linhas = document.querySelectorAll('#lista-geral-usuarios tr');
    linhas.forEach(tr => {
        const usuario = todosUsuarios.find(u => u.id == tr.dataset.id);
        if (!usuario) return;
        const nomeBate = usuario.nome_guerra?.toLowerCase().includes(busca);
        const nomeCompletoBate = usuario.nome_completo?.toLowerCase().includes(busca);
        const patenteBate = !patente || (usuario.p_g || usuario.patente) === patente;
        const cpfBate = usuario.cpf?.toLowerCase().includes(busca);
        const idt_milBate = usuario.idt_mil?.toLowerCase().includes(busca);
        const emailBate = usuario.email?.toLowerCase().includes(busca);
        const statusBate = status === 'todos' || (status === '1' && usuario.ativo === 't') || (status === '0' && usuario.ativo === 'f');
        if ( (nomeBate || nomeCompletoBate || cpfBate || idt_milBate || emailBate) && patenteBate && statusBate) tr.style.display = "";
        else tr.style.display = "none";
    });
}

function editarUsuario(id = null) {
    const modal = document.getElementById('modalEditarUsuario');
    const tbody = document.getElementById('tabela-padrao-edit');
    const titulo = document.getElementById('tituloModal'); // Certifique-se de ter esse ID no <h2> do modal

    if (id) {
        // MODO EDIÇÃO
        const u = todosUsuarios.find(user => user.id == id);
        if (!u) return;

        titulo.innerText = "Editar Usuário";
        document.getElementById('editId').value = u.id;
        document.getElementById('editPatente').value = u.patente; // Aqui deve ser o ID ou Nome conforme seu select
        document.getElementById('editNomeGuerra').value = u.nome_guerra;
        document.getElementById('editNomeCompleto').value = u.nome_completo;
        document.getElementById('editCPF').value = formatarCPF(u.cpf);
        document.getElementById('editAtivo').checked = (u.ativo === 't');

        // Preenche padrão semanal existente
        const padrao = typeof u.padrao_semanal === 'string' ? JSON.parse(u.padrao_semanal) : (u.padrao_semanal || {});
        renderTabelaPadrao(padrao);
    } else {
        // MODO INSERÇÃO (NOVO)
        titulo.innerText = "Novo Usuário";
        document.getElementById('formEditarUsuario').reset(); // Limpa todos os inputs
        document.getElementById('editId').value = ""; // Garante que o ID oculto esteja vazio
        document.getElementById('editAtivo').checked = true; // Padrão ativo para novos
        
        // Preenche tabela com tudo desmarcado
        renderTabelaPadrao({});
    }

    modal.showModal();

    // Função interna para evitar repetição de código da tabela
    function renderTabelaPadrao(padrao) {
        tbody.innerHTML = diasSemana.map(dia => {
            const valores = padrao[dia] || "";
            return `
                <tr data-dia="${dia}">
                    <td style="text-align:left"><strong>${dia}</strong></td>
                    <td><input type="checkbox" class="edit-c" ${valores.includes('C') ? 'checked' : ''}></td>
                    <td><input type="checkbox" class="edit-a" ${valores.includes('A') ? 'checked' : ''}></td>
                    <td><input type="checkbox" class="edit-j" ${valores.includes('J') ? 'checked' : ''}></td>
                </tr>
            `;
        }).join('');
    }
}


function salvarAlteracoesUsuario() {
    const id = document.getElementById('editId').value;
    
    // Coleta o Padrão Semanal
    const novoPadrao = {};
    document.querySelectorAll('#tabela-padrao-edit tr').forEach(tr => {
        const dia = tr.dataset.dia;
        let sigla = "";
        if (tr.querySelector('.edit-c').checked) sigla += "C";
        if (tr.querySelector('.edit-a').checked) sigla += "A";
        if (tr.querySelector('.edit-j').checked) sigla += "J";
        novoPadrao[dia] = sigla;
    });

    // Busca o ID da Patente (com trava de erro caso não encontre)
    const nomePatente = document.getElementById('editPatente').value;
    const patenteObj = PATENTES.find(p => p.nome === nomePatente);
    const idPatente = patenteObj ? patenteObj.id : null;

    // Monta o Payload
    const payload = {
        // Se id for string vazia ou null, o PHP entenderá como INSERT
        id: id || null, 
        patente: idPatente,
        nome_guerra: document.getElementById('editNomeGuerra').value,
        nome_completo: document.getElementById('editNomeCompleto').value,
        cpf: document.getElementById('editCPF').value.replace(/\D/g, ''),
        ativo: document.getElementById('editAtivo').checked ? 't' : 'f',
        padrao_semanal: JSON.stringify(novoPadrao)
    };

    // Log visual para debug
    console.log(id ? `Atualizando ID ${id}:` : "Inserindo Novo Usuário:", payload);

    fetch('../api/salvar_usuario.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    //.then(r => r.text()).then(res => { console.log(res) })
    .then(r => r.json())
    .then(res => {
        if (res.status === 'ok') {
            // Opcional: alert(res.mensagem); 
            location.reload();
        } else {
            alert(res.erro || 'Erro ao processar requisição');
        }
    })
    .catch(err => {
        console.error("Erro no Fetch:", err);
        alert('Erro de comunicação com o servidor');
    });
}

function fecharModal() { document.getElementById('modalEditarUsuario').close(); }

//EXECUÇÃO

document.addEventListener('DOMContentLoaded', function() {

    carregarUsuarios();

});
