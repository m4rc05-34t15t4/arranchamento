<?php $ts = time();?>
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

<?php 
  include 'header.php'; 
  //Apenas para administradores
  if (!$_SESSION['ARRANCHAMENTO']['administrador']) {
    header('Location: arranchamento.php');
    exit;
  }
  //Variaveis sessão para JS
  echo '
    <script> 
      const ranchos = JSON.parse('.json_encode($_SESSION['ARRANCHAMENTO']['ranchos'] ?? null).'); 
      console.log("ranchos", ranchos);
    </script>';
?>

<main class="pagina-dia">

  <div class="tabelas-div">

    <div id="cabecalho_impressao">
      <img src="../img/om/<?=$om_id?>.png" alt="Logo" class="logo-impressao">
      <div class="om-impressao">
        <?php echo $_SESSION['ARRANCHAMENTO']['om_sigla']; ?>
      </div>
      <div class="responsavel-impressao">
        <?php echo $_SESSION['ARRANCHAMENTO']['patente'] . ' ' . $_SESSION['ARRANCHAMENTO']['usuario_nome_guerra']; ?>
      </div>
    </div>

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
          <div class="titulo-rancho">
            <h4>Rancho</h4>
            <button id="bt-editar-ranchos" class="btn-icon editar" title="Editar Ranchos" ranchos="">✏️</button>
          </div>
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

    <div id="assinatura_impressao">
      <table class="tabela-assinatura">
        <thead>
          <tr>
            <th>Furriel</th>
            <th>Cmt SU</th>
            <th>Fiscal Administrativo</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><div class="assinatura-box"></div></td>
            <td><div class="assinatura-box"></div></td>
            <td><div class="assinatura-box"></div></td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>

  <div id="modal-ranchos" class="modal hidden">
    <div class="modal-box">

      <div class="modal-header">
        <h2>Editar pessoal de serviço</h2>
      </div>

      <div class="modal-body" id="lista-ranchos"></div>

      <div class="modal-footer">
        <button id="bt-cancelar" class="btn-cancelar">Cancelar</button>
        <button id="bt-salvar" class="btn-salvar">Salvar</button>
      </div>

    </div>
  </div>

</main>

<script src="../js/relatorio.js?t=<?= $ts ?>"></script>
</body>
</html>
