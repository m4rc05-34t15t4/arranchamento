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

<?php include 'header.php'; ?>

<main class="pagina-dia">

  <div class="tabelas-div">

    <div id="titulo-arranchamento">
      <button id="btn-anterior" class="botao-menu">◀</button>
      <div class="titulo-centro">
        <h2 id="data-atual"></h2>
        <h5 id="data-atualizacao"></h5>
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
              </tr>
            </thead>
            <tbody id="resumo-por-refeicao">
              <tr>
                <td id="total-cafe"></td>
                <td id="total-almoco"></td>
                <td id="total-janta"></td>
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
