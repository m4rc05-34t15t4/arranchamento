/* ================== CONFIGURAÇÃO BÁSICA ================== */

const dias = ['Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'];
const diasSemanaJS = ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'];

const tabelaSemanal = document.getElementById('tabela-semanal');
const tabelaExcecao = document.getElementById('tabela-excecao');
const tabelaIndividual = document.getElementById('tabela-individual');
const listaExcecoes = document.getElementById('lista-excecoes');
const dialog = document.getElementById('dialogExcecao');

const excecoes = [];

/* ================== PADRÃO SEMANAL ================== */

dias.forEach((dia, i) => {
  const tr = document.createElement('tr');
  tr.innerHTML = `
    <td>${dia}</td>
    <td><input type="checkbox" id="cafe-${i}"></td>
    <td><input type="checkbox" id="almoco-${i}"></td>
    <td><input type="checkbox" id="janta-${i}"></td>
  `;
  tabelaSemanal.appendChild(tr);
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
  dialog.showModal();
}

function fecharDialog() {
  dialog.close();
}

/* ================== MODO DA EXCEÇÃO ================== */

function toggleModoExcecao() {
  const modo = document.querySelector('input[name=\"modoExcecao\"]:checked').value;

  document.getElementById('modo-semanal').style.display =
    modo === 'semanal' ? 'block' : 'none';

  document.getElementById('modo-individual').style.display =
    modo === 'individual' ? 'block' : 'none';

  if (modo === 'individual') {
    gerarDiasIndividuais();
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
      <td>${dataISO} (${diaSemana})</td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="cafe"></td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="almoco"></td>
      <td><input type="checkbox" data-data="${dataISO}" data-ref="janta"></td>
    `;
    tabelaIndividual.appendChild(tr);

    dataAtual.setDate(dataAtual.getDate() + 1);
  }
}

/* ================== SALVAR EXCEÇÃO ================== */

function salvarExcecao() {
  const tipo = document.getElementById('tipoExcecao').value;
  const obs = document.getElementById('obsExcecao').value;
  const inicio = document.getElementById('dataInicio').value;
  const fim = document.getElementById('dataFim').value;
  const modo = document.querySelector('input[name=\"modoExcecao\"]:checked').value;

  if (!inicio || !fim) {
    alert('Informe data de início e fim');
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

  excecoes.push({
    tipo,
    obs,
    inicio,
    fim,
    modo,
    configuracao
  });

  fecharDialog();
  renderExcecoes();
}

/* ================== RENDERIZAR EXCEÇÕES ================== */

function removerExcecao(index) {
  excecoes.splice(index, 1);
  renderExcecoes();
}

function renderExcecoes() {
  listaExcecoes.innerHTML = '';

  excecoes.forEach((e, i) => {
    let resumo = '';

    if (e.modo === 'semanal') {
      resumo = e.configuracao
        .filter(d => d.cafe || d.almoco || d.janta)
        .map(d => `${d.dia}: ${d.cafe?'C ':''}${d.almoco?'A ':''}${d.janta?'J':''}`)
        .join('<br>');
    } else {
      resumo = e.configuracao
        .filter(d => d.ativo)
        .map(d => `${d.data}: ${d.refeicao}`)
        .join('<br>');
    }

    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${e.tipo}</td>
      <td>${e.inicio} a ${e.fim}</td>
      <td style=\"text-align:left\">${resumo || '-'}</td>
      <td>${e.obs || '-'}</td>
      <td>
        <button class=\"danger\" onclick=\"removerExcecao(${i})\">Excluir</button>
      </td>
    `;
    listaExcecoes.appendChild(tr);
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

  const dados = {
    padraoSemanal,
    excecoes
  };

  console.log('ARRANCHAMENTO FINAL:', dados);
  alert('Arranchamento salvo (ver console)');
}

/* ================== LIMPAR DIALOG ================== */

function limparDialog() {
  document.getElementById('obsExcecao').value = '';
  document.getElementById('dataInicio').value = '';
  document.getElementById('dataFim').value = '';

  document.querySelector('input[value=\"semanal\"]').checked = true;

  document
    .querySelectorAll('#dialogExcecao input[type=checkbox]')
    .forEach(cb => cb.checked = false);

  toggleModoExcecao();
}
