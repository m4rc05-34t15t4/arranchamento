<?php $ts = time(); ?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Arranchamento Diário</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../style.css?t=<?= $ts ?>">
</head>
<body>

<?php include 'header.php'; ?>

<main class="pagina-dia">

  <div class="tabelas-div" style="max-width: 1200px">

    <div>
      <h2>Arranchamento – <span id="data-atual"></span></h2>
    </div>

    <div class="tabelas-duplas resumo-card">

      <table class="tabela-dia">
        <thead>
          <tr>
            <th>Usuário</th>
            <th>OM</th>
            <th>C</th>
            <th>A</th>
            <th>J</th>
          </tr>
        </thead>
        <tbody id="tabela-dia-esq"></tbody>
      </table>

      <table class="tabela-dia">
        <thead>
          <tr>
            <th>Usuário</th>
            <th>OM</th>
            <th>C</th>
            <th>A</th>
            <th>J</th>
          </tr>
        </thead>
        <tbody id="tabela-dia-dir"></tbody>
      </table>

    </div>

    <div class="resumo-arranchamento">

      <h3>Resumo do Arranchamento do Dia</h3>

      <div class="resumo-blocos">

        <!-- Totais gerais -->
        <div class="resumo-card">
          <h4>Total Geral</h4>
          <p>Café: <strong id="total-cafe">0</strong></p>
          <p>Almoço: <strong id="total-almoco">0</strong></p>
          <p>Janta: <strong id="total-janta">0</strong></p>
        </div>

        <!-- Totais por posto -->
        <div class="resumo-card">
          <h4>Por Posto / Graduação</h4>
          <table>
            <thead>
              <tr>
                <th>Posto</th>
                <th>C</th>
                <th>A</th>
                <th>J</th>
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
