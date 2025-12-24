document.addEventListener('DOMContentLoaded', function() {

  carregarArranchamento();

  //EVENTOS

  document.querySelectorAll('.botao-menu').forEach(btn => {
    btn.addEventListener('click', () => {

      console.log('1aaa');
  
      const elData = document.getElementById('data-atual');
      const dataRef = elData?.dataset.ref; // YYYY-MM-DD
      if (!dataRef) return;
  
      const data = new Date(dataRef + 'T00:00:00');
  
      const delta = btn.id === 'btn-proximo' ? 1 : -1;
      data.setDate(data.getDate() + delta);
  
      const novaData =
        data.getFullYear() + '-' +
        String(data.getMonth() + 1).padStart(2, '0') + '-' +
        String(data.getDate()).padStart(2, '0');
  
      window.location.href = `?dia=${novaData}`;
    });
  });
  
  

});

let relatorios = null;
let usuarios = null;

function initPatente(patente, totais) {
  if (!totais.t_patente[patente]) {
    totais.t_patente[patente] = { t_c: 0, t_a: 0, t_j: 0 };
  }
}

function processaUsuario(usuario, usuario_refeicoes, totais, mapaPatenteRancho) {
  if (!usuario) return;

  const refeicoes = usuario_refeicoes[usuario.id] || '';
  const mapa = { C: 't_c', A: 't_a', J: 't_j' };

  // init patente
  totais.t_patente[usuario.patente] ??= { t_c: 0, t_a: 0, t_j: 0 };

  const rancho = mapaPatenteRancho[usuario.patente];

  for (const letra in mapa) {
    if (refeicoes.includes(letra)) {
      const key = mapa[letra];

      // total geral
      totais[key]++;

      // por patente
      totais.t_patente[usuario.patente][key]++;

      // por rancho
      if (rancho) {
        totais.t_rancho[rancho][key]++;
      }
    }
  }
}

function texto_table_dupla(uEsq, uEsq_r){
  return `<td class="t_dia_nome">${uEsq ? `${uEsq.patente} ${uEsq.nome_guerra}` : ''}</td>
      <td class="t_dia_refeicao">${uEsq_r[0] ? '✔️' : '-'}</td>
      <td class="t_dia_refeicao">${uEsq_r[1] ? '✔️' : '-'}</td>
      <td class="t_dia_refeicao">${uEsq_r[2] ? '✔️' : '-'}</td>`;
}

function nova_datahora(datahora){
   const [ano, mes, dia] = datahora.split('-');
   return new Date(ano, mes - 1, dia);
}
  
function renderArranchamentoDia() {

  const existe_arranchamento = relatorios && relatorios['data_relatorio'] && relatorios['usuarios_refeicoes'] ? true : false;
  
  // Atualiza data atual
  let dataArranchamento = new Date();
  let text_titulo = 'Previsão para';
  if(existe_arranchamento){
    text_titulo = 'Arranchamento de';
    dataArranchamento = nova_datahora(relatorios['data_relatorio']);
    document.getElementById('data-atualizacao').textContent = `Gerado em: ${
      new Date(relatorios['data_atualizacao'])
      .toLocaleDateString('pt-BR', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      })
    }`;
  } 

  const dt_atual = document.getElementById('data-atual');
  dt_atual.setAttribute('data-ref', dataArranchamento.toISOString().slice(0, 10));
  dt_atual.textContent = `${text_titulo} ${
    dataArranchamento.toLocaleDateString('pt-BR', {
      weekday: 'long',
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    })}`;

  // Converte string JSON em objeto
  let usuario_refeicoes = null;
  if(existe_arranchamento) usuario_refeicoes = JSON.parse(relatorios["usuarios_refeicoes"]);
  else{
    //ajustar previsão do dia
  }

  const totais = {
    t_c: 0,
    t_a: 0,
    t_j: 0,
    t_patente: {},
    t_rancho: {}
  };
  let ordem_patentes_arr = [];

  //rancho
  let ranchos = [
    {"nome" : "Oficiais", "patente" : ["CEL", "TEN-CEL", "MAJ", "CAP", "1º TEN", "2º TEN", "ASP", "ST"] },
    {"nome" : "Sargentos", "patente" : ["1º SGT", "2º SGT", "3º SGT", "SC"] },
    {"nome" : "Cbs / Sds", "patente" : ["CB", "SD EP", "SD EV"] }
  ];
  // cria mapa patente -> rancho
  const mapaPatenteRancho = {};
  ranchos.forEach(r => {
    totais.t_rancho[r.nome] = { t_c: 0, t_a: 0, t_j: 0 };

    r.patente.forEach(p => {
      mapaPatenteRancho[p] = r.nome;
    });
  });

  const tbody = document.getElementById('tabela-dia-body');
  tbody.innerHTML = '';

  // Percorre usuários em pares (esquerda/direita)
  for (let i = 0; i < usuarios.length; i += 2) {
    const uEsq = usuarios[i];
    const uDir = usuarios[i + 1];
    const uEsq_r = [uEsq && usuario_refeicoes[uEsq.id]?.includes('C'), uEsq && usuario_refeicoes[uEsq.id]?.includes('A'), uEsq && usuario_refeicoes[uEsq.id]?.includes('J')];
    const uDir_r = [uDir && usuario_refeicoes[uDir.id]?.includes('C'), uDir && usuario_refeicoes[uDir.id]?.includes('A'), uDir && usuario_refeicoes[uDir.id]?.includes('J')];

    if (uEsq && !ordem_patentes_arr.includes(uEsq.patente)) ordem_patentes_arr.push(uEsq.patente);
    if (uDir && !ordem_patentes_arr.includes(uDir.patente)) ordem_patentes_arr.push(uDir.patente);

    processaUsuario(uEsq, usuario_refeicoes, totais, mapaPatenteRancho);
    processaUsuario(uDir, usuario_refeicoes, totais, mapaPatenteRancho);
    
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

  // preencher tabela por rancho
  // preencher tabela por rancho
  const tbody_rancho = document.getElementById('resumo-por-rancho');
  tbody_rancho.innerHTML = '';

  ranchos.forEach(r => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${r.nome}</td>
      <td>${totais.t_rancho[r.nome].t_c}</td>
      <td>${totais.t_rancho[r.nome].t_a}</td>
      <td>${totais.t_rancho[r.nome].t_j}</td>
    `;
    tbody_rancho.appendChild(tr);
  });
}

function carregarArranchamento() {

  const hoje = new Date();
  const dataAtualStr = [
    hoje.getFullYear(),
    String(hoje.getMonth() + 1).padStart(2, '0'),
    String(hoje.getDate()).padStart(2, '0')
  ].join('-');

  const params = new URLSearchParams(window.location.search);
  const dia = params.get('dia') || dataAtualStr;

  $om_id = 1;
  fetch(`../api/get_arranchamento.php?dia=${dia}&om=${$om_id}`)
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
  
  