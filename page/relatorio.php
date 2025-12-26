<?php $ts = time(); ?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Arranchamento Diário</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/style.css?t=<?= $ts ?>">
</head>
<body>

<div class="watermark"><span>Previsão</span></div>

<?php include 'header.php'; ?>

<main class="pagina-dia">

  <div class="tabelas-div">

    <div id="titulo-arranchamento">
      <button id="btn-anterior" class="botao-menu">◀</button>
      <div class="titulo-centro">
        <h2 id="data-atual"></h2>
        <h5 id="data-atualizacao"></h5>
        <div class="acoes-arranchamento">
          <button id="btnBloquearDia" class="btn-cadeado aberto" title="Dia aberto">🔓</button>
          <div id="checkbox-exibir-mudancas" class="toggle-switch">
            <input type="checkbox" id="chk-diferencas">
            <label for="chk-diferencas" class="slider"></label>
            <label for="chk-diferencas" class="label-text">
              Exibir mudanças<br>no arranchamento
            </label>
          </div>
          <button id="btnGerarArranchamento" class="btn-gerar" data-acao="atualizar">
            <span id="acao_salvar_arranchamento">Atualizar</span> Arranchamento
          </button>
          <button id="btnImprimirArranchamento" class="btn-imprimir">Imprimir</button>
        </div>
      </div>
      <button id="btn-proximo"  class="botao-menu">▶</button>
    </div>

    <div class="tabelas-duplas resumo-card">

    <table class="tabela-dia">
      <thead>
        <tr>
          <th class="t_dia_nome">Nome</th>
          <th class="t_dia_refeicao">Café</th>
          <th class="t_dia_refeicao">Almoço</th>
          <th class="t_dia_refeicao">Janta</th>
          <th></th>
          <th class="t_dia_nome">Nome</th>
          <th class="t_dia_refeicao">Café</th>
          <th class="t_dia_refeicao">Almoço</th>
          <th class="t_dia_refeicao">Janta</th>
        </tr>
      </thead>
      <tbody id="tabela-dia-body"></tbody>
    </table>

    </div>

    <div class="resumo-arranchamento">

      <div class="resumo-blocos">

        <!-- Totais gerais -->
        <div class="resumo-card">
          <h4>Total Geral</h4>
          <table>
            <thead>
              <tr>
                <th>Café</th>
                <th>Almoço</th>
                <th>Janta</th>
                <th>Serviço</th>
              </tr>
            </thead>
            <tbody id="resumo-por-refeicao">
              <tr>
                <td id="total-cafe"></td>
                <td id="total-almoco"></td>
                <td id="total-janta"></td>
                <td id="total-servico"></td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Totais por rancho -->
        <div class="resumo-card">
          <h4>Rancho</h4>
          <table>
            <thead>
              <tr>
                <th>Rancho</th>
                <th>Café</th>
                <th>Almoço</th>
                <th>Janta</th>
                <th>Serviço</th>
              </tr>
            </thead>
            <tbody id="resumo-por-rancho"></tbody>
          </table>
        </div>

        <!-- Totais por posto -->
        <div class="resumo-card">
          <h4>Por Posto / Graduação</h4>
          <table>
            <thead>
              <tr>
                <th>Posto</th>
                <th>Café</th>
                <th>Almoço</th>
                <th>Janta</th>
              </tr>
            </thead>
            <tbody id="resumo-por-posto"></tbody>
          </table>
        </div>

      </div>

    </div>

  </div>

</main>

<script src="../js/relatorio.js?t=<?= $ts ?>"></script>
</body>
</html>
