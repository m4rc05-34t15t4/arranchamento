<?php $ts = time(); ?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Sistema de Arranchamento</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/style.css?t=<?= $ts ?>">
</head>
<body>

  <?php include 'header.php'; ?>

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
        <div class="excecoes-header">
          <h2>Exceções</h2>
          <button class="primary" onclick="abrirDialog()">Nova Exceção</button>
        </div>

        <table style="margin-top:10px;">
          <thead>
            <tr>
              <th>Refeições</th>
              <th>Tipo</th>
              <th colspan="2">Período</th>
            </tr>
          </thead>
          <tbody id="lista-excecoes"></tbody>
        </table>
      </div>

      <dialog id="dialogExcecao">
        <h3>Nova Exceção</h3>
        <div class="dialog-div-input">Tipo
          <select id="tipoExcecao">
            <option value="Dispensa">Dispensa</option>
            <option value="Missão">Missão</option>
            <option value="Férias">Férias</option>
            <option value="Férias">Outros</option>
          </select>
        </div>
        <div class="dialog-div-input">Data início <input type="date" id="dataInicio" /></div>
        <div class="dialog-div-input">Data fim <input type="date" id="dataFim" /></div>
        <div>Observação<br>
          <input type="text" id="obsExcecao" style="width:95%; margin: 0 0 5px 0;" />
        </div>
        <div style="margin: 5px 0 5px 0;">
          <label>
            <input type="radio" name="modoExcecao" value="semanal" checked onclick="toggleModoExcecao()"> Padrão semanal
          </label>
          <label>
            <input type="radio" name="modoExcecao" value="individual" onclick="toggleModoExcecao()"> Dias individuais
          </label>
        </div>
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

      <!--<div class="card">
        <button class="primary" onclick="salvar()">Salvar Arranchamento</button>
      </div>-->

      </div>

      <div class="col-direita card">
        
        <div class="excecoes-header">
          <h2>Simulação do Arranchamento</h2>
          <div style="margin-bottom:10px">
            <button id="mes-anterior">◀</button>
            <strong id="titulo-mes"></strong>
            <button id="mes-proximo">▶</button>
          </div>
        </div>
        <table border="1" width="100%">
          <thead>
            <tr>
              <th width="40%" style="min-width: 160px">Data</th>
              <th width="20%">Café</th>
              <th width="20%">Almoço</th>
              <th width="20%">Janta</th>
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

  <script src="../js/app.js?t=<?= $ts ?>"></script>
</body>
</html>
