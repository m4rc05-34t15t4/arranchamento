document.addEventListener('DOMContentLoaded', function() {
  carregarArranchamento();
});


let relatorios = null;
let usuarios = null;


function extrairPatente(nomeCompleto) {
  const patentes = [
    'Cap',
    '1º Ten',
    '2º Ten',
    '1º Sgt',
    '2º Sgt',
    '3º Sgt',
    'Sd'
  ];

  for (const p of patentes) {
    if (nomeCompleto.startsWith(p)) {
      return p;
    }
  }

  return 'Não informado';
}

function limparNome(nomeCompleto, patente) {
  return nomeCompleto.replace(patente, '').trim();
}

usuarios = [
  {
    nomeCompleto: 'Cap BUARQUE',
    om: '3º CGEO',
    padrao: { cafe: true, almoco: true, janta: false }
  },
  {
    nomeCompleto: '1º Ten AZEVEDO',
    om: '3º CGEO',
    padrao: { cafe: true, almoco: true, janta: true }
  },
  {
    nomeCompleto: '2º Sgt MARCOS BATISTA',
    om: '3º CGEO',
    padrao: { cafe: true, almoco: true, janta: true },
    excecao: { almoco: true }
  },
  {
    nomeCompleto: 'Sd EV Plantão 1',
    om: '3º CGEO',
    padrao: { cafe: true, almoco: true, janta: true }
  },
  {
    nomeCompleto: 'Sd EV Cozinheiro',
    om: '3º CGEO',
    padrao: { cafe: true, almoco: true, janta: true },
    excecao: { cafe: true, almoco: true }
  },
  {
      nomeCompleto: 'Cap BUARQUE',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: false }
    },
    {
      nomeCompleto: '1º Ten AZEVEDO',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true }
    },
    {
      nomeCompleto: '2º Sgt MARCOS BATISTA',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true },
      excecao: { almoco: true }
    },
    {
      nomeCompleto: 'Sd EV Plantão 1',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true }
    },
    {
      nomeCompleto: 'Sd EV Cozinheiro',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true },
      excecao: { cafe: true, almoco: true }
    },
    {
      nomeCompleto: 'Cap BUARQUE',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: false }
    },
    {
      nomeCompleto: '1º Ten AZEVEDO',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true }
    },
    {
      nomeCompleto: '2º Sgt MARCOS BATISTA',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true },
      excecao: { almoco: true }
    },
    {
      nomeCompleto: 'Sd EV Plantão 1',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true }
    },
    {
      nomeCompleto: 'Sd EV Cozinheiro',
      om: '3º CGEO',
      padrao: { cafe: true, almoco: true, janta: true },
      excecao: { cafe: true, almoco: true }
    }
].map(u => {
  const patente = extrairPatente(u.nomeCompleto);

  return {
    ...u,
    patente,
    nome: limparNome(u.nomeCompleto, patente)
  };
});

console.log('dados simlados:', usuarios);
 
  
function renderArranchamentoDia() {
  const tbody = document.getElementById('tabela-dia-body');

  // Limpa tabela
  tbody.innerHTML = '';

  // Atualiza data atual
  const dataArranchamento = new Date();
  document.getElementById('data-atual').textContent =
    dataArranchamento.toLocaleDateString('pt-BR', {
      weekday: 'long',
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });

  // Converte string JSON em objeto
  const usuario_refeicoes = JSON.parse(relatorios["usuarios_refeicoes"]);

  // Percorre usuários em pares (esquerda/direita)
  for (let i = 0; i < usuarios.length; i += 2) {
    const uEsq = usuarios[i];
    const uDir = usuarios[i + 1];

    const tr = document.createElement('tr');

    tr.innerHTML = `
      <!-- Coluna esquerda -->
      <td>${uEsq ? `${uEsq.patente} ${uEsq.nome_guerra}` : ''}</td>
      <td>${uEsq && usuario_refeicoes[uEsq.id]?.includes('C') ? 'SIM' : '-'}</td>
      <td>${uEsq && usuario_refeicoes[uEsq.id]?.includes('A') ? 'SIM' : '-'}</td>
      <td>${uEsq && usuario_refeicoes[uEsq.id]?.includes('J') ? 'SIM' : '-'}</td>

      <!-- Espaço entre colunas -->
      <td style="width: 30px;"></td>

      <!-- Coluna direita -->
      <td>${uDir ? `${uDir.patente} ${uDir.nome_guerra}` : ''}</td>
      <td>${uDir && usuario_refeicoes[uDir.id]?.includes('C') ? 'SIM' : '-'}</td>
      <td>${uDir && usuario_refeicoes[uDir.id]?.includes('A') ? 'SIM' : '-'}</td>
      <td>${uDir && usuario_refeicoes[uDir.id]?.includes('J') ? 'SIM' : '-'}</td>
    `;

    tbody.appendChild(tr);
  }
}


  function renderResumoDia() {
    let totalCafe = 0;
    let totalAlmoco = 0;
    let totalJanta = 0;
  
    const resumoPatente = {};
  
    usuarios.forEach(u => {
      let refeicoes = { ...u.padrao };
  
      // exceção sobrescreve o padrão
      if (u.excecao) {
        refeicoes = {
          cafe: false,
          almoco: false,
          janta: false,
          ...u.excecao
        };
      }
  
      // totais gerais
      if (refeicoes.cafe) totalCafe++;
      if (refeicoes.almoco) totalAlmoco++;
      if (refeicoes.janta) totalJanta++;
  
      // 🔑 chave correta: patente
      const patente = u.patente;
  
      if (!resumoPatente[patente]) {
        resumoPatente[patente] = {
          cafe: 0,
          almoco: 0,
          janta: 0
        };
      }
  
      if (refeicoes.cafe) resumoPatente[patente].cafe++;
      if (refeicoes.almoco) resumoPatente[patente].almoco++;
      if (refeicoes.janta) resumoPatente[patente].janta++;
    });
  
    // preencher totais gerais
    document.getElementById('total-cafe').textContent = totalCafe;
    document.getElementById('total-almoco').textContent = totalAlmoco;
    document.getElementById('total-janta').textContent = totalJanta;
  
    // preencher tabela por patente
    const tbody = document.getElementById('resumo-por-posto');
    tbody.innerHTML = '';
  
    Object.entries(resumoPatente).forEach(([patente, t]) => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${patente}</td>
        <td>${t.cafe}</td>
        <td>${t.almoco}</td>
        <td>${t.janta}</td>
      `;
      tbody.appendChild(tr);
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
        renderResumoDia();

        /*
  
        spanNome.textContent = dados.nome;
        spanPatente.textContent = dados.patente;
        spanOM.textContent = dados.sigla_om;
  
        carregarPadraoSemanal(dados.padrao_semanal);
  
        excecoes["semanal"] = Array.isArray(dados.excecao_semanal) ? dados.excecao_semanal : [];
        excecoes["diaria"] = Array.isArray(dados.excecao_diaria) ? dados.excecao_diaria : [];
        excecoes["manual"] = dados.excecao_manual && !Array.isArray(dados.excecao_manual) ? dados.excecao_manual : {};
        
        arranchamento_relatorios.length = 0;
        dados.arranchamentos_relatorios.forEach(e => arranchamento_relatorios.push(e));
           
        renderExcecoes();
        renderSimulacao();*/
      })
      .catch(() => alert('Erro ao carregar dados arranchamento'));
  }
  
  