<?php $ts = time(); ?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Sistema de Arranchamento</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="style.css?t=<?= $ts ?>">
</head>
<body>
<header class="topbar">
  <div class="left">
    <img src="avatar.png" alt="Logo" class="logo">
    <div class="user-info">
      <strong id="nome-usuario">Cb Marcos Batista</strong><br>
      <span id="patente-usuario">Cabo</span>
    </div>
  </div>
  <div class="center">
    <h1>Arranchamento</h1>
  </div>
  <div class="right">
    <strong id="om-usuario" class="quartel">3º CGEO</strong>
  </div>
</header>

<div class="layout-arranchamento">

  <div class="col-esquerda">

    <div class="card">
      <h2>Padrão Semanal</h2>
      <table>
        <thead>
          <tr>
            <th>Dia</th>
            <th>Café</th>
            <th>Almoço</th>
            <th>Janta</th>
          </tr>
        </thead>
        <tbody id="tabela-semanal"></tbody>
      </table>
    </div>

    <div class="card">
      <h2>Exceções</h2>
      <button class="primary" onclick="abrirDialog()">Nova Exceção</button>

      <table style="margin-top:10px;">
        <thead>
          <tr>
            <th>Tipo</th>
            <th>Período</th>
            <th>Refeições</th>
            <th>Ação</th>
          </tr>
        </thead>
        <tbody id="lista-excecoes"></tbody>
      </table>
    </div>

    <dialog id="dialogExcecao">
      <h3>Nova Exceção</h3>

      <label>Tipo
        <select id="tipoExcecao">
          <option value="Férias">Férias</option>
          <option value="Dispensa">Dispensa</option>
          <option value="Missão">Missão</option>
        </select>
      </label><br><br>

      <label>Observação<br>
        <input type="text" id="obsExcecao" style="width:100%;" />
      </label><br><br>

      <label>Data início <input type="date" id="dataInicio" /></label>
      <label>Data fim <input type="date" id="dataFim" /></label>

      <h4>Configuração da exceção</h4>

    <label>
      <input type="radio" name="modoExcecao" value="semanal" checked onclick="toggleModoExcecao()"> Padrão semanal
    </label>
    <label>
      <input type="radio" name="modoExcecao" value="individual" onclick="toggleModoExcecao()"> Dias individuais
    </label>

    <div id="modo-semanal">
      <table>
        <thead>
          <tr>
            <th>Dia</th>
            <th>Café</th>
            <th>Almoço</th>
            <th>Janta</th>
          </tr>
        </thead>
        <tbody id="tabela-excecao"></tbody>
      </table>
    </div>

    <div id="modo-individual" style="display:none;">
      <p>Selecione as refeições para cada dia do período:</p>
      <table>
        <thead>
          <tr>
            <th>Data</th>
            <th>Café</th>
            <th>Almoço</th>
            <th>Janta</th>
          </tr>
        </thead>
        <tbody id="tabela-individual"></tbody>
      </table>
    </div>

      <br>
      <button class="primary" onclick="salvarExcecao()">Salvar</button>
      <button onclick="fecharDialog()">Cancelar</button>
    </dialog>

    <div class="card">
      <button class="primary" onclick="salvar()">Salvar Arranchamento</button>
    </div>

    </div>

    <div class="col-direita">

      <h3>Simulação do Arranchamento</h3>

      <div style="margin-bottom:10px">
        <button id="mes-anterior">◀</button>
        <strong id="titulo-mes"></strong>
        <button id="mes-proximo">▶</button>
      </div>

      <table border="1" width="100%">
        <thead>
          <tr>
            <th>Data</th>
            <th>Café</th>
            <th>Almoço</th>
            <th>Janta</th>
          </tr>
        </thead>
        <tbody id="tabela-simulacao"></tbody>
      </table>

    </div>

    <dialog id="dialogConfirmacao">
      <h3>Confirmar exclusão</h3>
      <p>Deseja realmente excluir esta exceção?</p>

      <div style="text-align:right; margin-top:15px">
        <button id="btnCancelarExclusao">Cancelar</button>
        <button id="btnConfirmarExclusao" class="danger">Excluir</button>
      </div>
    </dialog>

  </div>

</div>


<script src="app.js?t=<?= $ts ?>"></script>
</body>
</html>
