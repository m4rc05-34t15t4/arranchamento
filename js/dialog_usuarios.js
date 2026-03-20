// Função para renderizar a lista no modal
function renderizarUsuarios(lista) {
    popularFiltroPostos(document.getElementById('filtroPosto'), PATENTES);
    const corpo = document.getElementById('lista-usuarios-adm');
    corpo.innerHTML = lista.map(u => `
        <tr data-id="${u.id}">
            <td>${u.patente}</td>
            <td>${u.nome_guerra}</td>
            <td><label class="switch-header"><input type="checkbox" class="chk-nao" ${excecaoRelatorio[u.id] == '' ? 'checked' : ''}><span class="slider"></span></label></td>
            <td><input type="checkbox" class="chk-cafe" ${excecaoRelatorio[u.id]?.includes('C') ? 'checked' : ''}></td>
            <td><input type="checkbox" class="chk-almoco" ${excecaoRelatorio[u.id]?.includes('A') ? 'checked' : ''}></td>
            <td><input type="checkbox" class="chk-janta" ${excecaoRelatorio[u.id]?.includes('J') ? 'checked' : ''}></td>
        </tr>
    `).join('');

    document.getElementById('lista-usuarios-adm').addEventListener('change', function(e) {
        // Verifica se o clique foi em um checkbox "Não arranchar"
        if (e.target.classList.contains('chk-nao')) {
            const tr = e.target.closest('tr'); // Acha a linha correspondente
            const estaMarcado = e.target.checked;
            if (estaMarcado) {
                // Desmarca os irmãos se "Não arranchar" for marcado
                tr.querySelector('.chk-cafe').checked = false;
                tr.querySelector('.chk-almoco').checked = false;
                tr.querySelector('.chk-janta').checked = false;
            }
        }
        // Lógica Inversa: Se clicar em qualquer refeição, desmarca o "Não arranchar"
        if (['chk-cafe', 'chk-almoco', 'chk-janta'].some(cls => e.target.classList.contains(cls))) {
            if (e.target.checked) {
                const tr = e.target.closest('tr');
                tr.querySelector('.chk-nao').checked = false;
            }
        }
    });

}

function aplicarFiltroVisual(idsFiltrados) {
    const linhas = document.querySelectorAll('#lista-usuarios-adm tr');
    linhas.forEach(tr => {
        const idDaLinha = tr.getAttribute('data-id');
        const temCheck = tr.querySelector('.chk-nao').checked || tr.querySelector('.chk-cafe').checked || tr.querySelector('.chk-almoco').checked || tr.querySelector('.chk-janta').checked;
        if (idsFiltrados.includes(idDaLinha) || temCheck) tr.style.display = "";
        else tr.style.display = "none";
    });
}

// Lógica de Filtro
function filtrarUsuarios() {
    // Converte o objeto em Array caso ele ainda não seja
    const listaParaFiltrar = Array.isArray(usuariosSistema) ? usuariosSistema : Object.values(usuariosSistema);
    const nome = document.getElementById('filtroNome').value.toLowerCase();
    const posto = document.getElementById('filtroPosto').value;
    const idsFiltrados = listaParaFiltrar.filter(u => {
        const nomeBate = u.nome_guerra?.toLowerCase().includes(nome);
        const postoBate = (posto === "" || u.patente === posto);
        return nomeBate && postoBate;
    }).map(u => u.id);
    aplicarFiltroVisual(idsFiltrados);
    //renderizarUsuarios(filtrados);
}

// Lógica de Salvar (Aplicando a mesclagem que você pediu)
function salvarExcecaoAdm() {
    const linhas = document.querySelectorAll('#lista-usuarios-adm tr');
    let atualizacoes = {};
    linhas.forEach(tr => {
        if(tr.querySelector('.chk-nao').checked || tr.querySelector('.chk-cafe').checked || tr.querySelector('.chk-almoco').checked || tr.querySelector('.chk-janta').checked){
            const id = tr.getAttribute('data-id');
            atualizacoes[id] = "";
            atualizacoes[id] += tr.querySelector('.chk-cafe').checked ? "C" : "";
            atualizacoes[id] += tr.querySelector('.chk-almoco').checked ? "A" : "";
            atualizacoes[id] += tr.querySelector('.chk-janta').checked ? "J" : "";
        }
    });
    excecaoRelatorio = {...atualizacoes};
    //fecharDialogAdm();
    salvarArranchamento();
}

function toggleColuna(classeAlvo, marcado) {
    // Seleciona apenas as linhas que estão visíveis no momento (filtros aplicados)
    const linhasVisiveis = document.querySelectorAll(`#lista-usuarios-adm tr:not([style*="display: none"])`);

    linhasVisiveis.forEach(tr => {
        const checkbox = tr.querySelector(`.${classeAlvo}`);
        if (checkbox) {
            checkbox.checked = marcado;
            
            // Dispara manualmente o evento 'change' para acionar a lógica de 
            // desmarcar irmãos que fizemos anteriormente
            checkbox.dispatchEvent(new Event('change', { bubbles: true }));
        }
    });
}


// Funções de abrir/fechar
function abrirDialogAdm() { document.getElementById('dialogAdm').showModal(); }
function fecharDialogAdm() { document.getElementById('dialogAdm').close(); }
