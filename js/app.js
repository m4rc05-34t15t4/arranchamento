document.addEventListener('DOMContentLoaded', () => {
  carregarUsuario();

  //EVENTOS

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
    

});

/* ================== CONFIGURAÇÃO BÁSICA ================== */

const dias = ['Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'];
const diasSemanaJS = ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'];

const tabelaSemanal = document.getElementById('tabela-semanal');
const tabelaExcecao = document.getElementById('tabela-excecao');
const tabelaIndividual = document.getElementById('tabela-individual');
const listaExcecoes = document.getElementById('lista-excecoes');
const dialog = document.getElementById('dialogExcecao');

const hoje = new Date();
const mesMinimo = new Date(hoje.getFullYear(), hoje.getMonth(), 1);

const excecoes = [];

// ⚠️ ID do usuário logado (ideal vir da sessão)
const ID_USUARIO = 2;

const spanNome = document.getElementById('nome-usuario');
const spanPatente = document.getElementById('patente-usuario');
const spanOM = document.getElementById('om-usuario');

let indiceEdicao = null;
let mesAtual = new Date();

let indiceExclusao = null;
const dialogConfirmacao = document.getElementById('dialogConfirmacao');


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

/* ================== DIALOG ================== */

function abrirDialog() {
  limparDialog();
  
  //definir data calendario
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);
  const fim = new Date(hoje);
  fim.setDate(fim.getDate() + 7);
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

function abrirConfirmacaoExclusao(index) {
  indiceExclusao = index;
  dialogConfirmacao.showModal();
}

function fecharConfirmacaoExclusao() {
  indiceExclusao = null;
  dialogConfirmacao.close();
}

function confirmarExclusao() {
  if (indiceExclusao !== null) {
    removerExcecao(indiceExclusao);
  }
  fecharConfirmacaoExclusao();
}


/* ================== MODO DA EXCEÇÃO ================== */

function toggleModoExcecao() {
  const modo = document.querySelector('input[name="modoExcecao"]:checked').value;

  document.getElementById('modo-semanal').style.display =
    modo === 'semanal' ? 'block' : 'none';

  document.getElementById('modo-individual').style.display =
    modo === 'individual' ? 'block' : 'none';

  if (modo === 'individual') {
    gerarDiasIndividuais();
  } else {
    atualizarDiasSemanaExcecao();
  }
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

  dias.forEach((dia, i) => {
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

  let configuracao = [];

  if (modo === 'semanal') {
    configuracao = dias.map((dia, i) => ({
      dia,
      cafe: document.getElementById(`ex-cafe-${i}`).checked,
      almoco: document.getElementById(`ex-almoco-${i}`).checked,
      janta: document.getElementById(`ex-janta-${i}`).checked,
    }));
  } else {
    document
      .querySelectorAll('#tabela-individual input[type=checkbox]')
      .forEach(cb => {
        configuracao.push({
          data: cb.dataset.data,
          refeicao: cb.dataset.ref,
          ativo: cb.checked
        });
      });
  }

  const excecaoFinal = { tipo, obs, inicio, fim, modo, configuracao };

  if (indiceEdicao !== null) {
    excecoes[indiceEdicao] = excecaoFinal;
    indiceEdicao = null;
  } else {
    excecoes.push(excecaoFinal);
  }

  fecharDialog();
  renderExcecoes();
  renderSimulacao();
  salvar();
}


/* ================== EXCLUIR / EDITAR ================== */

function removerExcecao(index) {
  excecoes.splice(index, 1);
  renderExcecoes();
  renderSimulacao();
}

function editarExcecao(index) {
  indiceEdicao = index;
  const e = excecoes[index];

  abrirDialog();

  document.getElementById('tipoExcecao').value = e.tipo;
  document.getElementById('obsExcecao').value = e.obs || '';
  document.getElementById('dataInicio').value = e.inicio;
  document.getElementById('dataFim').value = e.fim;

  atualizarDiasSemanaExcecao();

  document.querySelector(`input[value="${e.modo}"]`).checked = true;
  toggleModoExcecao();

  if (e.modo === 'semanal') {
    e.configuracao.forEach((d, i) => {
      document.getElementById(`ex-cafe-${i}`).checked = d.cafe;
      document.getElementById(`ex-almoco-${i}`).checked = d.almoco;
      document.getElementById(`ex-janta-${i}`).checked = d.janta;
    });
  } else {
    gerarDiasIndividuais();

    setTimeout(() => {
      e.configuracao.forEach(d => {
        const cb = document.querySelector(
          `input[data-data="${d.data}"][data-ref="${d.refeicao}"]`
        );
        if (cb) cb.checked = d.ativo;
      });
    }, 50);
  }
}

/* ================== RENDER ================== */

function renderExcecoes() {
  listaExcecoes.innerHTML = '';

  const hoje = new Date().toISOString().slice(0, 10);

  excecoes.forEach((e, index) => {

    // ⛔ não renderiza exceções encerradas no passado
    if (e.fim < hoje) return;

    let resumo = '';

    /* ===== RESUMO DAS REFEIÇÕES ===== */
    if (e.modo === 'semanal') {
      resumo = e.configuracao
        .filter(d => d.cafe || d.almoco || d.janta)
        .map(d =>
          `${d.dia.toUpperCase().slice(0, 3)}: ` +
          `${d.cafe ? 'C ' : ''}${d.almoco ? 'A ' : ''}${d.janta ? 'J' : ''}`.trim()
        )
        .join('<br>');
    } else {
      // 🔵 individual agrupado por data
      const mapa = {};

      e.configuracao
        .filter(d => d.ativo)
        .forEach(d => {
          if (!mapa[d.data]) {
            mapa[d.data] = { cafe: false, almoco: false, janta: false };
          }
          mapa[d.data][d.refeicao] = true;
        });

      resumo = Object.entries(mapa)
        .map(([data, r]) =>
          `${data}: ${r.cafe ? 'C ' : ''}${r.almoco ? 'A ' : ''}${r.janta ? 'J' : ''}`.trim()
        )
        .join('<br>');
    }

    const temObs = e.obs && e.obs.trim() !== '';

    /* ===== CLASSE DE COR ===== */
    const classeLinha =
      e.modo === 'individual'
        ? 'simulacao-individual'
        : 'simulacao-semanal';

    /* ===== LINHA PRINCIPAL ===== */
    const trMain = document.createElement('tr');
    trMain.classList.add(classeLinha);

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

    const btnEditar = document.createElement('button');
    btnEditar.textContent = 'Editar';
    btnEditar.className = 'primary';
    btnEditar.onclick = () => editarExcecao(index);

    const btnExcluir = document.createElement('button');
    btnExcluir.textContent = 'Excluir';
    btnExcluir.className = 'danger';
    btnExcluir.onclick = () => removerExcecao(index);

    tdAcoes.appendChild(btnEditar);
    tdAcoes.appendChild(btnExcluir);

    listaExcecoes.appendChild(trMain);

    /* ===== LINHA DE OBSERVAÇÃO ===== */
    if (temObs) {
      const trObs = document.createElement('tr');
      trObs.className = `linha-obs ${classeLinha}`;
      trObs.innerHTML = `
        <td colspan="3" class="lista-excessoes-td-observacao">
          ${e.obs}
        </td>
      `;
      listaExcecoes.appendChild(trObs);
    }
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
  fetch(`api/get_usuario.php?id=${ID_USUARIO}`)
    .then(r => r.json())
    .then(dados => {

      console.log(dados);

      spanNome.textContent = dados.nome;
      spanPatente.textContent = dados.patente;
      spanOM.textContent = dados.sigla_om;

      carregarPadraoSemanal(dados.padrao_semanal);

      excecoes.length = 0;
      dados.excecoes.forEach(e => excecoes.push(e));
      renderExcecoes();
      renderSimulacao();
    })
    .catch(() => alert('Erro ao carregar usuário'));
}

function carregarPadraoSemanal(padrao) {
  padrao.forEach((dia, i) => {
    document.getElementById(`cafe-${i}`).checked = dia.cafe;
    document.getElementById(`almoco-${i}`).checked = dia.almoco;
    document.getElementById(`janta-${i}`).checked = dia.janta;
  });
}


/* ================== SALVAR ARRANCHAMENTO ================== */

function salvar() {
  const padraoSemanal = dias.map((dia, i) => ({
    dia,
    cafe: document.getElementById(`cafe-${i}`).checked,
    almoco: document.getElementById(`almoco-${i}`).checked,
    janta: document.getElementById(`janta-${i}`).checked,
  }));

  const payload = {
    id_usuario: ID_USUARIO,
    padrao_semanal: padraoSemanal,
    excecoes: excecoes
  };

  fetch('api/salvar_arranchamento.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  })
  .then(r => r.json())
  .then(res => {
    if (res.status === 'ok') {
      console.log(new Date().toLocaleString('pt-BR'), 'Arranchamento salvo com sucesso!');
      //alert('Arranchamento salvo com sucesso!');
    } else {
      alert(res.erro || 'Erro ao salvar');
    }
  })
  .catch(err => {
    console.error(err);
    alert('Erro de comunicação com o servidor');
  });
}

/* ========= calendario simulação ============ */

function toISODate(date) {
  return date.toISOString().split('T')[0];
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

function renderSimulacao() {
  const tbody = document.getElementById('tabela-simulacao');
  const tituloMes = document.getElementById('titulo-mes');

  tbody.innerHTML = '';

  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);

  // 🔒 não permitir mês passado
  if (mesAtual < new Date(hoje.getFullYear(), hoje.getMonth(), 1)) {
    mesAtual = new Date(hoje.getFullYear(), hoje.getMonth(), 1);
  }

  const ano = mesAtual.getFullYear();
  const mes = mesAtual.getMonth();

  tituloMes.textContent = mesAtual.toLocaleDateString('pt-BR', {
    month: 'long',
    year: 'numeric'
  });

  const inicioMes = new Date(ano, mes, 1);
  const fimMes = new Date(ano, mes + 1, 0);

  const inicio =
    ano === hoje.getFullYear() && mes === hoje.getMonth()
      ? new Date(hoje)
      : new Date(inicioMes);

  for (let d = new Date(inicio); d <= fimMes; d.setDate(d.getDate() + 1)) {

    // 🔁 base NOVA por dia (clonada)
    const padrao = getPadraoDia(d);
    if (!padrao) continue;

    let base = { ...padrao };

    let temSemanal = false;
    let temIndividual = false;

    const dataISO = d.toISOString().split('T')[0];
    const diaSemana = diasSemanaJS[d.getDay()];

    // 🟠 exceção semanal
    excecoes.forEach(e => {
      if (e.modo !== 'semanal') return;
      if (dataISO < e.inicio || dataISO > e.fim) return;

      const conf = e.configuracao.find(c => c.dia === diaSemana);
      if (conf) {
        base = {
          cafe: conf.cafe,
          almoco: conf.almoco,
          janta: conf.janta
        };
        temSemanal = true;
      }
    });

    // 🔵 exceção individual (prioridade máxima)
    excecoes.forEach(e => {
      if (e.modo !== 'individual') return;
      if (dataISO < e.inicio || dataISO > e.fim) return;

      const registros = e.configuracao.filter(r => r.data === dataISO);
      if (registros.length) {
        base = { cafe: false, almoco: false, janta: false };

        registros.forEach(r => {
          if (r.ativo) base[r.refeicao] = true;
        });

        temIndividual = true;
      }
    });
    const tr = document.createElement('tr');
    if (temIndividual) {
      tr.classList.add('simulacao-individual');
    } else if (temSemanal) {
      tr.classList.add('simulacao-semanal');
    }
    tr.innerHTML = `
      <td>${dataISO} ${diaSemana}</td>
      <td>${base.cafe ? '✔️' : '-'}</td>
      <td>${base.almoco ? '✔️' : '-'}</td>
      <td>${base.janta ? '✔️' : '-'}</td>
    `;
    tbody.appendChild(tr);
  }

  atualizarBotoesMes();
}

function atualizarBotoesMes() {
  const btnAnterior = document.getElementById('mes-anterior');
  btnAnterior.disabled = mesAtual <= mesMinimo;
}


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

