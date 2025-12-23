document.addEventListener('DOMContentLoaded', function() {

  carregarArranchamento();

});

let relatorios = null;
let usuarios = null;

function initPatente(patente, totais) {
  if (!totais.t_patente[patente]) {
    totais.t_patente[patente] = { t_c: 0, t_a: 0, t_j: 0 };
  }
}

function processaUsuario(usuario, usuario_refeicoes, totais) {
  if (!usuario) return;

  const refeicoes = usuario_refeicoes[usuario.id] || '';
  const mapa = { C: 't_c', A: 't_a', J: 't_j' };

  initPatente(usuario.patente, totais);

  for (const letra in mapa) {
    if (refeicoes.includes(letra)) {
      const key = mapa[letra];
      totais[key]++;
      totais.t_patente[usuario.patente][key]++;
    }
  }
}

function texto_table_dupla(uEsq, uEsq_r){
  return `<td>${uEsq ? `${uEsq.patente} ${uEsq.nome_guerra}` : ''}</td>
      <td>${uEsq_r[0] ? '✔️' : '-'}</td>
      <td>${uEsq_r[1] ? '✔️' : '-'}</td>
      <td>${uEsq_r[2] ? '✔️' : '-'}</td>`;
}
  
function renderArranchamentoDia() {
  const tbody = document.getElementById('tabela-dia-body');

  // Limpa tabela
  tbody.innerHTML = '';

  // Atualiza data atual
  let dataArranchamento = new Date();
  if(relatorios['data_relatorio']){
    dataArranchamento = new Date(relatorios['data_relatorio']);
    document.getElementById('data-atualizacao').textContent = `Atualizado em: ${new Date(relatorios['data_atualizacao']).toLocaleDateString('pt-BR')}`;
  }  
  document.getElementById('data-atual').textContent =
    dataArranchamento.toLocaleDateString('pt-BR', {
      weekday: 'long',
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });

  // Converte string JSON em objeto
  const usuario_refeicoes = JSON.parse(relatorios["usuarios_refeicoes"]);
  const totais = {
    t_c: 0,
    t_a: 0,
    t_j: 0,
    t_patente: {}
  };
  let ordem_patentes_arr = [];

  // Percorre usuários em pares (esquerda/direita)
  for (let i = 0; i < usuarios.length; i += 2) {
    const uEsq = usuarios[i];
    const uDir = usuarios[i + 1];
    const uEsq_r = [uEsq && usuario_refeicoes[uEsq.id]?.includes('C'), uEsq && usuario_refeicoes[uEsq.id]?.includes('A'), uEsq && usuario_refeicoes[uEsq.id]?.includes('J')];
    const uDir_r = [uDir && usuario_refeicoes[uDir.id]?.includes('C'), uDir && usuario_refeicoes[uDir.id]?.includes('A'), uDir && usuario_refeicoes[uDir.id]?.includes('J')];

    if (uEsq && !ordem_patentes_arr.includes(uEsq.patente)) ordem_patentes_arr.push(uEsq.patente);
    if (uDir && !ordem_patentes_arr.includes(uDir.patente)) ordem_patentes_arr.push(uDir.patente);

    processaUsuario(uEsq, usuario_refeicoes, totais);
    processaUsuario(uDir, usuario_refeicoes, totais);
    
    const tr = document.createElement('tr');
    tr.innerHTML = `${texto_table_dupla(uEsq, uEsq_r)}<td></td>${texto_table_dupla(uDir, uDir_r)}`;
    tbody.appendChild(tr);
  }

  //totais
  console.log('totais', totais);

  // preencher totais gerais
  document.getElementById('total-cafe').textContent = totais['t_c'];
  document.getElementById('total-almoco').textContent = totais['t_a'];
  document.getElementById('total-janta').textContent = totais['t_j'];

  // preencher tabela por patente
  const tbody_rt = document.getElementById('resumo-por-posto');
  tbody_rt.innerHTML = '';

  ordem_patentes_arr.forEach((patente) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${patente}</td>
      <td>${totais['t_patente'][patente]['t_c']}</td>
      <td>${totais['t_patente'][patente]['t_a']}</td>
      <td>${totais['t_patente'][patente]['t_j']}</td>
    `;
    tbody_rt.appendChild(tr);
  });

}

function carregarArranchamento() {
  $om_id = 1;
  $dia = '2025-12-04';
  fetch(`../api/get_arranchamento.php?dia=${$dia}&om=${$om_id}`)
    .then(r => r.json())
    .then(dados => {

      console.log(dados);
      relatorios = dados.relatorios;
      usuarios = dados.usuarios;

      renderArranchamentoDia();

      /*
      spanNome.textContent = dados.nome;
      spanPatente.textContent = dados.patente;
      spanOM.textContent = dados.sigla_om;
      */
    }
  ).catch(() => alert('Erro ao carregar dados arranchamento'));
}
  
  