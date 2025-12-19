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
  


const usuarios = [
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
    const tbodyEsq = document.getElementById('tabela-dia-esq');
    const tbodyDir = document.getElementById('tabela-dia-dir');
  
    tbodyEsq.innerHTML = '';
    tbodyDir.innerHTML = '';
  
    const hoje = new Date();
    document.getElementById('data-atual').textContent =
      hoje.toLocaleDateString('pt-BR', {
        weekday: 'long',
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
      });
  
    usuarios.forEach((u, index) => {
      let refeicoes = { ...u.padrao };
  
      // 🔵 exceção sobrescreve
      if (u.excecao) {
        refeicoes = {
          cafe: false,
          almoco: false,
          janta: false,
          ...u.excecao
        };
      }
  
      const tr = document.createElement('tr');
  
      if (u.excecao) {
        tr.classList.add('simulacao-individual');
      }
  
      tr.innerHTML = `
        <td>${u.nome}</td>
        <td>${u.om}</td>
        <td>${refeicoes.cafe ? 'SIM' : '-'}</td>
        <td>${refeicoes.almoco ? 'SIM' : '-'}</td>
        <td>${refeicoes.janta ? 'SIM' : '-'}</td>
      `;
  
      // ✅ ORDEM INTERCALADA
      if (index % 2 === 0) {
        tbodyEsq.appendChild(tr);
      } else {
        tbodyDir.appendChild(tr);
      }
    });
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
  
  renderArranchamentoDia();
  renderResumoDia();
  
  