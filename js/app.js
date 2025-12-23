document.addEventListener('DOMContentLoaded', () => {
  carregarUsuario();

  //EVENTOS

  document.getElementById('mes-anterior').addEventListener('click', () => {
    const teste = new Date(mesAtual.getFullYear(), mesAtual.getMonth() - 1, 1);

    if (teste < mesMinimo) return; // ⛔ bloqueia passado

    mesAtual = teste;
    renderSimulacao();
  });

  document.getElementById('mes-proximo').addEventListener('click', () => {
    mesAtual = new Date(mesAtual.getFullYear(), mesAtual.getMonth() + 1, 1);
    renderSimulacao();
  });

  document.getElementById('btnCancelarExclusao')
  .addEventListener('click', fecharConfirmacaoExclusao);

  document.getElementById('btnConfirmarExclusao')
    .addEventListener('click', confirmarExclusao);


  document.getElementById('dataInicio')
    .addEventListener('change', atualizarDiasSemanaExcecao);
  
  document.getElementById('dataFim')
    .addEventListener('change', atualizarDiasSemanaExcecao);

    document.getElementById('dataInicio').addEventListener('change', () => {
      const inicio = document.getElementById('dataInicio');
      const fim = document.getElementById('dataFim');
      if (!inicio.value) return;
      // fim nunca pode ser antes do início
      fim.min = inicio.value;
      if (fim.value && fim.value < inicio.value) {
        fim.value = inicio.value;
      }
      gerarDiasIndividuais(); // se estiver no modo individual
    });

    document.getElementById('dataFim').addEventListener('change', () => {
      const inicio = document.getElementById('dataInicio');
      const fim = document.getElementById('dataFim');
      if (!fim.value) return;
      const hoje = new Date().toISOString().slice(0, 10);
      // ❌ não permitir data fim antes de hoje
      if (fim.value < hoje) {
        fim.value = hoje;
      }
      // ❌ não permitir fim antes do início
      if (inicio.value && fim.value < inicio.value) {
        inicio.value = fim.value;
      }
      gerarDiasIndividuais();
    });

    //edicao manual excessao direto na simulação
    document.addEventListener('click', function (e) {
      const td = e.target;
      if (td.matches('tr:not(.simulacao-travada) td.refeicao')) {
        // alterna o ícone
        td.textContent = td.textContent.includes(check_icone) ? '-' : check_icone;
        const tr = td.closest('tr');
        const cajAtual = obterCAJDaLinha(tr);
        aplicarExcecaoManualDaLinha(tr, cajAtual);
      }
    });

    document.addEventListener('click', function (e) {
      //if (e.target.classList.contains('lista-excessoes-td-refeicao')) console.log(e.target.textContent);
      const el = e.target.closest('.lista-excessoes-td-refeicao');
      if (!el) return;
      const tr = el.closest('tr');
      if (!tr) return;
      const dataInicial = tr.getAttribute('data_inicial');
      const anoMes_ref = dataInicial.slice(0, 7);
      const primeiraTr = document.querySelector('#tabela-simulacao tr');
      if (primeiraTr) {
        const data = primeiraTr.getAttribute('data');
        const anoMes_simulacao = data.slice(0, 7);
        if(anoMes_simulacao != anoMes_ref){
          renderSimulacao(new Date(dataInicial));
        }
      }
      scrollParaData(dataInicial);
    });

});

/* ================== CONFIGURAÇÃO BÁSICA ================== */

const check_icone = '✔️';

const dias = ['Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'];
const diasSemanaJS = ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'];

const tabelaSemanal = document.getElementById('tabela-semanal');
const tabelaExcecao = document.getElementById('tabela-excecao');
const tabelaIndividual = document.getElementById('tabela-individual');
const listaExcecoes = document.getElementById('lista-excecoes');
const dialog = document.getElementById('dialogExcecao');

const hoje = new Date();
const mesMinimo = new Date(hoje.getFullYear(), hoje.getMonth() - 1, 1);

let excecoes = {"semanal" : [], "diaria" : [], "manual" : {}};
const arranchamento_relatorios = [];

// ⚠️ ID do usuário logado (ideal vir da sessão)
const ID_USUARIO = 2;

const spanNome = document.getElementById('nome-usuario');
const spanPatente = document.getElementById('patente-usuario');
const spanOM = document.getElementById('om-usuario');

let indiceEdicao = null;
let excecaoEmEdicao = null;
let indiceExclusao = null;
let mesAtual = new Date();

const dialogConfirmacao = document.getElementById('dialogConfirmacao');
const btnConfirmarExclusao = document.getElementById('btnConfirmarExclusao');
const btnCancelarExclusao = document.getElementById('btnCancelarExclusao');


/* ================== PADRÃO SEMANAL ================== */

dias.forEach((dia, i) => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>${dia}</td>
    <td><input class="check-padrao-semanal" type="checkbox" id="cafe-${i}"></td>
    <td><input class="check-padrao-semanal" type="checkbox" id="almoco-${i}"></td>
    <td><input class="check-padrao-semanal" type="checkbox" id="janta-${i}"></td>
  `;
  tabelaSemanal.appendChild(tr);
});
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.check-padrao-semanal').forEach(checkbox => {
      checkbox.addEventListener('change', function () {
          salvar();
      });
  });
});

/* ================== PADRÃO SEMANAL DA EXCEÇÃO ================== */

dias.forEach((dia, i) => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>${dia}</td>
    <td><input type="checkbox" id="ex-cafe-${i}"></td>
    <td><input type="checkbox" id="ex-almoco-${i}"></td>
    <td><input type="checkbox" id="ex-janta-${i}"></td>
  `;
  tabelaExcecao.appendChild(tr);
});

function aplicarExcecaoManualDaLinha(tr, cajAtual) {
  const dataISO = tr.getAttribute('data');
  if (!dataISO) return;

  const cajBase = obterCAJBaseDoDia(dataISO);
  const cajManualAtual = excecoes['manual'][dataISO] ?? null;

  // 🟢 Igual ao base (inclusive '' === '') → remove manual
  if (cajAtual === cajBase) {
    if (cajManualAtual !== null) {
      delete excecoes['manual'][dataISO];
    }
  }
  // 🔴 Diferente do base → cria ou edita manual
  else {
    excecoes['manual'][dataISO] = cajAtual;
  }

  renderSimulacao();
  renderExcecoes();
  salvar();
}

// loading

let loadingTimeout = null;

function iniciarLoading(delay = 2000, texto = 'Salvando...') {
  const overlay = document.getElementById('loading-overlay');
  overlay.querySelector('p').textContent = texto;

  // sempre limpa antes
  clearTimeout(loadingTimeout);

  // agenda o fade-in
  loadingTimeout = setTimeout(() => {
    overlay.classList.add('visivel');
  }, delay);
}

function finalizarLoading() {
  const overlay = document.getElementById('loading-overlay');

  clearTimeout(loadingTimeout);
  overlay.classList.remove('visivel');
}

function scrollParaData(data) {
  const tr = document.querySelector(`#tabela-simulacao tr[data="${data}"]`);
  if (!tr) return;
  tr.scrollIntoView({
    behavior: 'smooth',
    block: 'center'
  });

  // força reinício da animação se clicar várias vezes
  tr.classList.remove('tr-highlight');
  void tr.offsetWidth; // reflow
  tr.classList.add('tr-highlight');
  // remove a classe no final (opcional)
  setTimeout(() => {
    tr.classList.remove('tr-highlight');
  }, 1500);
}

function getPadraoDia(data) {
  const diaSemana = diasSemanaJS[data.getDay()];
  return dias.findIndex(d => d === diaSemana) !== -1
    ? dias.map((d, i) => ({
        dia: d,
        cafe: document.getElementById(`cafe-${i}`).checked,
        almoco: document.getElementById(`almoco-${i}`).checked,
        janta: document.getElementById(`janta-${i}`).checked,
      }))[dias.findIndex(d => d === diaSemana)]
    : null;
}

function obterCAJBaseDoDia(dataISO) {
  const data = new Date(dataISO + 'T00:00:00');
  const diaSemana = diasSemanaJS[data.getDay()];

  // 1️⃣ PADRÃO SEMANAL
  let basePadrao = getPadraoDia(data);
  if (!basePadrao) return null;

  let base = {
    cafe: basePadrao.cafe,
    almoco: basePadrao.almoco,
    janta: basePadrao.janta
  };

  // 2️⃣ EXCEÇÃO SEMANAL
  excecoes['semanal'].forEach(e => {
    if (dataISO < e.inicio || dataISO > e.fim) return;
    const valor = e.configuracao[diaSemana];
    if (valor !== undefined) {
      base = {
        cafe: valor.includes('C'),
        almoco: valor.includes('A'),
        janta: valor.includes('J')
      };
    }
  });

  // 3️⃣ EXCEÇÃO DIÁRIA
  excecoes['diaria'].forEach(e => {
    if (dataISO < e.inicio || dataISO > e.fim) return;
    const valor = e.configuracao[dataISO];
    if (valor !== undefined) {
      base = {
        cafe: valor.includes('C'),
        almoco: valor.includes('A'),
        janta: valor.includes('J')
      };
    }
  });

  // transforma em string CAJ
  let caj = '';
  if (base.cafe) caj += 'C';
  if (base.almoco) caj += 'A';
  if (base.janta) caj += 'J';

  return caj || '';
}

/* ================== DIALOG ================== */

function abrirDialog() {
  limparDialog();
  
  //definir data calendario
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);
  const fim = new Date(hoje);
  fim.setDate(fim.getDate() + 6);
  document.getElementById('dataInicio').value =
    hoje.toISOString().split('T')[0];
  document.getElementById('dataFim').value =
    fim.toISOString().split('T')[0];
  toggleModoExcecao();
  dialog.showModal();
}

function fecharDialog() {
  dialog.close();
}

function abrirConfirmacaoExclusao(tipo, index) {
  indiceExclusao = index;
  excecaoEmEdicao = { tipo, dados: excecoes[tipo][index] };
  dialogConfirmacao.showModal();
}

function fecharConfirmacaoExclusao() {
  indiceExclusao = null;
  excecaoEmEdicao = null;
  dialogConfirmacao.close();
}

function confirmarExclusao() {
  if (indiceExclusao !== null && excecaoEmEdicao != null) {
    const { tipo: t, dados: e } = excecaoEmEdicao;
    removerExcecao(t, indiceExclusao);
  }
  fecharConfirmacaoExclusao();
}


/* ================== MODO DA EXCEÇÃO ================== */

function toggleModoExcecao() {
  const modo = document.querySelector('input[name="modoExcecao"]:checked').value;
  document.getElementById('modo-semanal').style.display = modo === 'semanal' ? 'block' : 'none';
  document.getElementById('modo-individual').style.display = modo === 'individual' ? 'block' : 'none';
  if (modo === 'individual') gerarDiasIndividuais();
  else atualizarDiasSemanaExcecao();
}

/* ================== GERAR DIAS INDIVIDUAIS ================== */

function gerarDiasIndividuais() {
  const inicio = document.getElementById('dataInicio').value;
  const fim = document.getElementById('dataFim').value;

  if (!inicio || !fim) return;

  tabelaIndividual.innerHTML = '';

  let dataAtual = new Date(inicio + 'T00:00:00');
  const dataFinal = new Date(fim + 'T00:00:00');

  while (dataAtual <= dataFinal) {
    const dataISO = dataAtual.toISOString().split('T')[0];
    const diaSemana = diasSemanaJS[dataAtual.getDay()];

    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${dataISO} ${diaSemana.toUpperCase().slice(0, 3)}</td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="cafe"></td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="almoco"></td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="janta"></td>
    `;
    tabelaIndividual.appendChild(tr);

    dataAtual.setDate(dataAtual.getDate() + 1);
  }
}

function diasSemanaNoIntervalo(inicio, fim) {
  const diasValidos = new Set();

  let d = new Date(inicio + 'T00:00:00');
  const fimDate = new Date(fim + 'T00:00:00');

  while (d <= fimDate) {
    diasValidos.add(diasSemanaJS[d.getDay()]);
    d.setDate(d.getDate() + 1);
  }

  return diasValidos;
}

function atualizarDiasSemanaExcecao() {
  const inicio = document.getElementById('dataInicio').value;
  const fim = document.getElementById('dataFim').value;
  const modo = document.querySelector('input[name="modoExcecao"]:checked').value;

  // Só aplica no modo semanal
  if (modo !== 'semanal' || !inicio || !fim) return;

  const diasValidos = diasSemanaNoIntervalo(inicio, fim);

  diasSemanaJS.forEach((dia, i) => {
    const habilitado = diasValidos.has(dia);

    ['cafe', 'almoco', 'janta'].forEach(ref => {
      const cb = document.getElementById(`ex-${ref}-${i}`);
      cb.disabled = !habilitado;

      // Se desabilitar, desmarca
      if (!habilitado) cb.checked = false;
    });
  });
}


/* ================== SALVAR EXCEÇÃO ================== */

function salvarExcecao() {
  const tipo = document.getElementById('tipoExcecao').value;
  const obs = document.getElementById('obsExcecao').value;
  const inicio = document.getElementById('dataInicio').value;
  const fim = document.getElementById('dataFim').value;
  const modo = document.querySelector('input[name="modoExcecao"]:checked').value;

  if (!inicio || !fim) {
    alert('Informe data de início e fim');
    return;
  }

  const hoje = new Date().toISOString().slice(0, 10);

  // ❌ não permitir exceção terminando no passado
  if (fim < hoje) {
    alert('A data de fim não pode ser anterior à data de hoje');
    return;
  }

  let configuracao = {};
  if (modo === 'semanal') {
    dias.forEach((dia, i) => {
      let valor = '';
      if (document.getElementById(`ex-cafe-${i}`).checked)   valor += 'C';
      if (document.getElementById(`ex-almoco-${i}`).checked) valor += 'A';
      if (document.getElementById(`ex-janta-${i}`).checked)  valor += 'J';
      configuracao[dia] = valor;
    });
  } else {
    document.querySelectorAll('#tabela-individual input[type=checkbox]').forEach(cb => {
      const data = cb.dataset.data;
      const ref  = cb.dataset.ref;
      if (!configuracao[data]) configuracao[data] = '';
      if (cb.checked) {
        if (ref === 'cafe')   configuracao[data] += 'C';
        if (ref === 'almoco') configuracao[data] += 'A';
        if (ref === 'janta')  configuracao[data] += 'J';
      }
    });
  }

  const excecaoFinal = { tipo, obs, inicio, fim, configuracao };

  if (indiceEdicao !== null) {
    // tipo original da exceção
    const { tipo: t, dados: e } = excecaoEmEdicao;
    const tipoOriginal = t;
    const tipoNovo = modo == 'semanal' ? 'semanal' : 'diaria';

    if (tipoOriginal === tipoNovo) {
      // ✔️ mesmo tipo → só substitui
      excecoes[tipoNovo][indiceEdicao] = excecaoFinal;
    } else {
      // 🔁 mudou o tipo → remove do antigo e adiciona no novo
      excecoes[tipoOriginal].splice(indiceEdicao, 1);
      excecoes[tipoNovo].push(excecaoFinal);
    }
    indiceEdicao = null;
    excecaoEmEdicao = null;
  } else {
    const t = modo == "semanal" ? modo : 'diaria';
    excecoes[t].push(excecaoFinal);
  }

  fecharDialog();
  renderExcecoes();
  renderSimulacao();
  salvar();
}


/* ================== EXCLUIR / EDITAR ================== */

function removerExcecao(tipo, index) {
  if (tipo == 'manual') delete excecoes['manual'][index];
  else excecoes[tipo].splice(index, 1);
  salvar();
  renderExcecoes();
  renderSimulacao();
}

function editarExcecao(tipo, index) {
  indiceEdicao = index;
  const e = excecoes[tipo][index];
  excecaoEmEdicao = { tipo, dados: e };

  abrirDialog();

  document.getElementById('tipoExcecao').value = e.tipo;
  document.getElementById('obsExcecao').value = e.obs || '';
  document.getElementById('dataInicio').value = e.inicio;
  document.getElementById('dataFim').value = e.fim;

  atualizarDiasSemanaExcecao();

  const t = tipo != 'semanal' ? 'individual' : tipo;
  document.querySelector(`input[value="${t}"]`).checked = true;
  toggleModoExcecao();

  if (tipo === 'semanal') {
    diasSemanaJS.forEach((dia, i) => {
      const valor = e.configuracao[dia] || '';
      document.getElementById(`ex-cafe-${i}`).checked   = valor.includes('C');
      document.getElementById(`ex-almoco-${i}`).checked = valor.includes('A');
      document.getElementById(`ex-janta-${i}`).checked  = valor.includes('J');
    });
  } else {
    gerarDiasIndividuais();
    setTimeout(() => {
      Object.entries(e.configuracao).forEach(([data, valor]) => {
        if (!valor) return;
        const refs = [
          { letra: 'C', ref: 'cafe' },
          { letra: 'A', ref: 'almoco' },
          { letra: 'J', ref: 'janta' }
        ];
        refs.forEach(r => {
          if (!valor.includes(r.letra)) return;
          const cb = document.querySelector(`input[data-data="${data}"][data-ref="${r.ref}"]`);
          if (cb) cb.checked = true;
        });
      });
    }, 50);
  }
}

/* ================== RENDER ================== */

function renderExcecoes() {

  listaExcecoes.innerHTML = '';

  const hoje = new Date().toISOString().slice(0, 10);

  /* ==================================================
     🟡 1. EXCEÇÕES SEMANAIS
  ================================================== */
  excecoes['semanal'].forEach((e, index) => {
    if (e.fim < hoje) return;
    const temObs = e.obs && e.obs.trim() !== '';
    /* ===== RESUMO DAS REFEIÇÕES ===== */
    const resumo = Object.entries(e.configuracao).map(([dia, valor]) => `${dia.toUpperCase().slice(0, 3)}: ${valor}` ).join('<br>');
    /* ===== LINHA PRINCIPAL ===== */
    const trMain = document.createElement('tr');
    trMain.className = 'simulacao-semanal';
    // ⬇️ atributo customizado
    trMain.setAttribute('excecao', JSON.stringify(e));
    trMain.setAttribute('data_inicial', e.inicio);
    trMain.innerHTML = `
      <td class="lista-excessoes-td-refeicao" rowspan="${temObs ? 2 : 1}">
        ${resumo || '-'}
      </td>
      <td class="lista-excessoes-td-tipo">${e.tipo}</td>
      <td class="lista-excessoes-td-periodo">
        ${e.inicio}<br>${e.fim}
      </td>
      <td class="lista-excessoes-td-acao"></td>
    `;
    /* ===== AÇÕES ===== */
    const tdAcoes = trMain.querySelector('.lista-excessoes-td-acao');
    const actions = document.createElement('div');
    actions.className = 'acoes-excecao';

    const btnEditar = document.createElement('button');
    btnEditar.innerHTML = '✏️';
    btnEditar.className = 'btn-icon editar';
    btnEditar.title = 'Editar exceção';
    btnEditar.onclick = () => editarExcecao('semanal', index);

    const btnExcluir = document.createElement('button');
    btnExcluir.innerHTML = '🗑️';
    btnExcluir.className = 'btn-icon excluir';
    btnExcluir.title = 'Excluir exceção';
    btnExcluir.onclick = () => abrirConfirmacaoExclusao('semanal', index);

    actions.appendChild(btnEditar);
    actions.appendChild(btnExcluir);
    tdAcoes.appendChild(actions);
    listaExcecoes.appendChild(trMain);
    /* ===== LINHA DE OBSERVAÇÃO ===== */
    if (temObs) {
      const trObs = document.createElement('tr');
      trObs.className = 'linha-obs simulacao-semanal';
      trObs.innerHTML = `
        <td colspan="3" class="lista-excessoes-td-observacao">
          ${e.obs}
        </td>
      `;
      listaExcecoes.appendChild(trObs);
    }
  });

  /* ==================================================
     🟠 2. EXCEÇÕES DIÁRIAS
  ================================================== */
  excecoes['diaria'].forEach((e, index) => {
  if (e.fim < hoje) return;
    const temObs = e.obs && e.obs.trim() !== '';
    /* ===== RESUMO DAS REFEIÇÕES (DIÁRIA) ===== */
    const resumo = Object.entries(e.configuracao)
      .map(([data, valor]) => {
        const [ano, mes, dia] = data.split('-');
        return `${dia}/${mes}/${ano}: ${valor}`;
      })
      .join('<br>');
    /* ===== LINHA PRINCIPAL ===== */
    const trMain = document.createElement('tr');
    trMain.className = 'simulacao-individual';
    // ⬇️ atributo customizado
    trMain.setAttribute('excecao', JSON.stringify(e));
    trMain.setAttribute('data_inicial', e.inicio);
    trMain.innerHTML = `
      <td class="lista-excessoes-td-refeicao" rowspan="${temObs ? 2 : 1}">
        ${resumo || '-'}
      </td>
      <td class="lista-excessoes-td-tipo">${e.tipo}</td>
      <td class="lista-excessoes-td-periodo">
        ${e.inicio}<br>${e.fim}
      </td>
      <td class="lista-excessoes-td-acao"></td>
    `;
    /* ===== AÇÕES ===== */
    const tdAcoes = trMain.querySelector('.lista-excessoes-td-acao');

    const actions = document.createElement('div');
    actions.className = 'acoes-excecao';

    const btnEditar = document.createElement('button');
    btnEditar.innerHTML = '✏️';
    btnEditar.className = 'btn-icon editar';
    btnEditar.title = 'Editar exceção';
    btnEditar.onclick = () => editarExcecao('diaria', index);

    const btnExcluir = document.createElement('button');
    btnExcluir.innerHTML = '🗑️';
    btnExcluir.className = 'btn-icon excluir';
    btnExcluir.title = 'Excluir exceção';
    btnExcluir.onclick = () => abrirConfirmacaoExclusao('diaria', index);

    actions.appendChild(btnEditar);
    actions.appendChild(btnExcluir);
    tdAcoes.appendChild(actions);
    listaExcecoes.appendChild(trMain);
    /* ===== LINHA DE OBSERVAÇÃO ===== */
    if (temObs) {
      const trObs = document.createElement('tr');
      trObs.className = 'linha-obs simulacao-individual';
      trObs.innerHTML = `
        <td colspan="3" class="lista-excessoes-td-observacao">
          ${e.obs}
        </td>
      `;
      listaExcecoes.appendChild(trObs);
    }
  });

  /* ==================================================
     🔴 3. EXCEÇÕES MANUAIS — POR ÚLTIMO
  ================================================== */
  Object.entries(excecoes['manual']).forEach(([data, valor]) => {
  if (data < hoje) return;
    const tr = document.createElement('tr');
    tr.className = 'simulacao-manual';
    // ⬇️ atributo customizado, sem mudar estrutura
    tr.setAttribute('excecao', `{"${data}" : "${valor}"}`);
    tr.setAttribute('data_inicial', data);
    tr.innerHTML = `
      <td class="lista-excessoes-td-refeicao">${data} : ${valor}</td>
      <td class="lista-excessoes-td-tipo">Manual</td>
      <td class="lista-excessoes-td-periodo">${data}</td>
      <td class="lista-excessoes-td-acao">
        <button class="btn-icon excluir">🗑️</button>
      </td>
    `;

    tr.querySelector('.excluir').onclick = () => abrirConfirmacaoExclusao('manual', data);
    listaExcecoes.appendChild(tr);
  });

}

/* ================== LIMPAR DIALOG ================== */
function limparDialog() {
  document.getElementById('obsExcecao').value = '';
  document.getElementById('dataInicio').value = '';
  document.getElementById('dataFim').value = '';

  document.querySelector('input[value="semanal"]').checked = true;

  document
    .querySelectorAll('#dialogExcecao input[type=checkbox]')
    .forEach(cb => cb.checked = false);

  toggleModoExcecao();
}

/* ================== USUÁRIO ================== */

function carregarUsuario() {
  fetch(`../api/get_usuario.php?id=${ID_USUARIO}`)
    .then(r => r.json())
    .then(dados => {

      console.log(dados);

      spanNome.textContent = dados.nome;
      spanPatente.textContent = dados.patente;
      spanOM.textContent = dados.sigla_om;

      carregarPadraoSemanal(dados.padrao_semanal);

      excecoes["semanal"] = Array.isArray(dados.excecao_semanal) ? dados.excecao_semanal : [];
      excecoes["diaria"] = Array.isArray(dados.excecao_diaria) ? dados.excecao_diaria : [];
      excecoes["manual"] = dados.excecao_manual && !Array.isArray(dados.excecao_manual) ? dados.excecao_manual : {};

      console.log('sss', dados.arranchamentos_relatorios);
      
      //arranchamento_relatorios.length = 0;
      //JSON.parse(dados.arranchamentos_relatorios).forEach(e => arranchamento_relatorios.push(e));
         
      renderExcecoes();
      renderSimulacao();
    })
    .catch(() => alert('Erro ao carregar usuário'));
}

function carregarPadraoSemanal(padrao) {
  dias.forEach((dia, i) => {
    const valor = padrao[dia] || '';
    document.getElementById(`cafe-${i}`).checked   = valor.includes('C');
    document.getElementById(`almoco-${i}`).checked = valor.includes('A');
    document.getElementById(`janta-${i}`).checked  = valor.includes('J');
  });
}


/* ================== SALVAR ARRANCHAMENTO ================== */

function salvar() {

  // agenda o loading para daqui 2s
  iniciarLoading(2000, 'Salvando arranchamento...');

  const padraoSemanal = dias.reduce((acc, dia, i) => {
    let valor = '';

    if (document.getElementById(`cafe-${i}`).checked) valor += 'C';
    if (document.getElementById(`almoco-${i}`).checked) valor += 'A';
    if (document.getElementById(`janta-${i}`).checked) valor += 'J';

    acc[dia] = valor; // pode ser '' se nenhum marcado
    return acc;
  }, {});

  const payload = {
    id_usuario: ID_USUARIO,
    padrao_semanal: padraoSemanal,
    excecoes: excecoes
  };

  fetch('../api/salvar_arranchamento.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  })
  //.then(res => new Promise(resolve => { setTimeout(() => resolve(res), 2000); }))
  .then(r => r.json())
  .then(res => {
    //console.log('res', res);
    if (res.status === 'ok') {
      //console.log(new Date().toLocaleString('pt-BR'), 'Arranchamento salvo com sucesso!');
      //alert('Arranchamento salvo com sucesso!');
    } else alert(res.erro || 'Erro ao salvar');
  })
  .catch(err => {
    console.error(err);
    alert('Erro de comunicação com o servidor');
  })
  .finally(() => {
    finalizarLoading();
  });
}

/* ========= calendario simulação ============ */

function toISODate(date) {
  return date.toISOString().split('T')[0];
}

function aplicarExcecaoSemanal(data, base) {
  const dataISO = toISODate(data);
  const diaSemana = diasSemanaJS[data.getDay()];
  let aplicada = false;

  excecoes
    .filter(e =>
      e.modo === 'semanal' &&
      e.inicio <= dataISO &&
      e.fim >= dataISO
    )
    .forEach(e => {
      const regra = e.configuracao.find(d => d.dia === diaSemana);
      if (regra) {
        base.cafe = regra.cafe;
        base.almoco = regra.almoco;
        base.janta = regra.janta;
        aplicada = true;
      }
    });

  return { base, aplicada };
}

function aplicarExcecaoDiaria(data, base) {
  const dataISO = toISODate(data);
  const excecaoDia = excecoes.find(e =>
    e.modo === 'individual' &&
    e.inicio <= dataISO &&
    e.fim >= dataISO &&
    e.configuracao.some(d => d.data === dataISO)
  );

  if (!excecaoDia) return { base, aplicada: false };

  base.cafe = false;
  base.almoco = false;
  base.janta = false;

  excecaoDia.configuracao
    .filter(d => d.data === dataISO && d.ativo)
    .forEach(d => {
      base[d.refeicao] = true;
    });

  return { base, aplicada: true };
}

function refeicoesFromString(str) {
  return {
    cafe: str.includes('C'),
    almoco: str.includes('A'),
    janta: str.includes('J')
  };
}

function getRelatorioDia(dataISO) {
  return arranchamento_relatorios.find(r => r.data_relatorio === dataISO);
}

function getDiaSemanaPtBr(dataISO) {
  const diasSemana = [
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado'
  ];

  const [ano, mes, dia] = dataISO.split('-');
  const data = new Date(ano, mes - 1, dia); // evita bug de timezone

  return diasSemana[data.getDay()];
}

function obterCAJDaLinha(tr) {
  const letras = ['C', 'A', 'J'];
  let resultado = '';

  tr.querySelectorAll('td.refeicao').forEach((td, i) => {
    if (td.textContent.trim() === '✔️') {
      resultado += letras[i];
    }
  });

  return resultado || '';
}

function renderSimulacao(data_ref="") {
  const tbody = document.getElementById('tabela-simulacao');
  const tituloMes = document.getElementById('titulo-mes');

  tbody.innerHTML = '';

  if(data_ref == "") data_ref = mesAtual;

  const ano = data_ref.getFullYear();
  const mes = data_ref.getMonth();

  tituloMes.textContent = data_ref.toLocaleDateString('pt-BR', {
    month: 'long',
    year: 'numeric'
  });

  const inicioMes = new Date(ano, mes, 1);
  const fimMes = new Date(ano, mes + 1, 0);
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);

  for (let d = new Date(inicioMes); d <= fimMes; d.setDate(d.getDate() + 1)) {

    const dataISO = d.toISOString().split('T')[0];
    const diaSemana = diasSemanaJS[d.getDay()];
    const dataLinha = new Date(dataISO);
    dataLinha.setHours(0, 0, 0, 0);

    let base;
    let temSemanal = false;
    let temIndividual = false;
    let temManual = false;
    let temRelatorio = false;

    /* ================================
       🔒 PRIORIDADE 1 — RELATÓRIO
    ================================= */
    const relatorio = getRelatorioDia(dataISO);
    if (relatorio) {
      base = refeicoesFromString(relatorio.usuarios_refeicoes);
      temRelatorio = true;
    } else {

      /* ================================
         ⚪ PADRÃO
      ================================= */
      const padrao = getPadraoDia(d);
      if (!padrao) continue;
      base = { ...padrao };

      /* ================================
         🟡 EXCEÇÃO SEMANAL
      ================================= */
      excecoes['semanal'].forEach(e => {
        if (dataISO < e.inicio || dataISO > e.fim) return;
        const diaSemanaAtual = getDiaSemanaPtBr(dataISO);
        const valor = e.configuracao[diaSemanaAtual];
        base = { cafe: false, almoco: false, janta: false };
        if (valor !== undefined) {
          base = {
            cafe: valor.includes('C'),
            almoco: valor.includes('A'),
            janta: valor.includes('J')
          };
        }
        temSemanal = true;
      });

      /* ================================
         🟠 EXCEÇÃO DIÁRIA
      ================================= */
      excecoes['diaria'].forEach(e => {
        if (dataISO < e.inicio || dataISO > e.fim) return;
        const valor = e.configuracao[dataISO];
        base = { cafe: false, almoco: false, janta: false };
        if (valor !== undefined) {
          base = {
            cafe: valor.includes('C'),
            almoco: valor.includes('A'),
            janta: valor.includes('J')
          };
        }
        temIndividual = true;
      });

      /* ================================
         🔴 EXCEÇÃO MANUAL — POR ÚLTIMO
      ================================= */
      if (excecoes['manual'][dataISO] || excecoes['manual'][dataISO] == '') {
        base = refeicoesFromString(excecoes['manual'][dataISO]);
        temManual = true;
      }
    }

    /* ================================
       🎨 CLASSE DA LINHA
    ================================= */
    const tr = document.createElement('tr');

    if (temRelatorio || dataLinha < hoje) tr.classList.add('simulacao-travada');
    else if (temManual) tr.classList.add('simulacao-manual');
    else if (temIndividual) tr.classList.add('simulacao-individual');
    else if (temSemanal) tr.classList.add('simulacao-semanal');
    else tr.classList.add('simulacao-padrao');

    tr.innerHTML = `
      <td>
        ${dataISO} ${diaSemana}
        ${temRelatorio ? '<span class="lock">🔒</span>' : ''}
      </td>
      <td class="refeicao">${base.cafe ? '✔️' : '-'}</td>
      <td class="refeicao">${base.almoco ? '✔️' : '-'}</td>
      <td class="refeicao">${base.janta ? '✔️' : '-'}</td>
    `;

    const caj = (base.cafe   ? 'C' : '') + (base.almoco ? 'A' : '') + (base.janta  ? 'J' : '');
    tr.setAttribute('refeicao', caj);
    tr.setAttribute('dia', diaSemana);
    tr.setAttribute('data', dataISO);

    tbody.appendChild(tr);
  }

  atualizarBotoesMes();
}

function atualizarBotoesMes() {
  const btnAnterior = document.getElementById('mes-anterior');

  const hoje = new Date();
  hoje.setDate(1); // primeiro dia do mês atual

  const mesAnterior = new Date(hoje);
  mesAnterior.setMonth(hoje.getMonth() - 1);

  // 🔒 bloqueia apenas se tentar ir antes do mês anterior
  btnAnterior.disabled = mesAtual < mesAnterior;
}

