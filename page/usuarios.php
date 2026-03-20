<?php $ts = time(); ?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Gerenciamento de Usuários - OM</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/style.css?t=<?= $ts ?>">
  <style>
    /* Estilos específicos para a gestão de usuários */
    .status-ativo { color: green; font-weight: bold; }
    .status-inativo { color: red; font-weight: bold; }
    .tabela-usuarios th { position: sticky; top: 0; background: #fff; z-index: 5; }
    .filtros-usuarios { display: flex; gap: 15px; margin-bottom: 20px; flex-wrap: wrap; }
    .filtros-usuarios input, .filtros-usuarios select { padding: 8px; border-radius: 4px; border: 1px solid #ccc; }
  </style>
</head>
<body>

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

  <div class="layout-arranchamento" style="">
    <div class="card" style="width: 100%; max-width: none !important;">
      <div class="excecoes-header">
        <h2>Gerenciamento de Usuários</h2>
        <button class="primary" onclick="editarUsuario()">Cadastrar Novo Usuário</button>
      </div>

      <!-- Barra de Filtros -->
      <div class="filtros-usuarios">
        <input type="text" id="buscaNome" placeholder="Nome de Guerra..." oninput="filtrarTabela()">
        <select id="filtroPatente" onchange="filtrarTabela()">
          <option value="">Todas as Patentes</option>
          <!-- Populado via JS ou PHP -->
        </select>
        <select id="filtroStatus" onchange="filtrarTabela()">
          <option value="todos">Todos (Ativos/Inativos)</option>
          <option value="1" selected>Apenas Ativos</option>
          <option value="0">Apenas Inativos</option>
        </select>
      </div>

      <!-- Tabela Principal -->
      <div style="overflow-y: auto; border: 1px solid #eee;">
        <table class="tabela-usuarios" width="100%">
          <thead>
            <tr>
              <th onclick="ordenar('patente')" style="cursor: pointer;">P/G ↕</th>
              <th onclick="ordenar('nome_guerra')" style="cursor: pointer;">Nome de Guerra ↕</th>
              <th onclick="ordenar('nome_completo')" style="cursor: pointer;">Nome Completo ↕</th>
              <th onclick="ordenar('cpf')" style="cursor: pointer;">CPF ↕</th>
              <th onclick="ordenar('padrao_semanal')" style="cursor: pointer;">Padrão Semanal ↕</th>
              <th onclick="ordenar('ativo')" style="cursor: pointer;">Status</th>
              <th>Ações</th>
            </tr>
          </thead>
          <tbody id="lista-geral-usuarios">
            <!-- Preenchido via JS -->
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!--modal de edição de inserção de usuário-->
  <dialog id="modalEditarUsuario" style="width: 90%; max-width: 950px; padding: 20px; border-radius: 8px; border: 1px solid #ccc;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
      <h2 id="tituloModal">Editar Usuário</h2>
      <button onclick="fecharModal()" style="background:none; border:none; font-size:20px; cursor:pointer;">&times;</button>
    </div>

    <div style="display: flex; gap: 25px; flex-wrap: wrap;">
      
      <!-- Coluna Esquerda: Dados Pessoais -->
      <div style="flex: 1; min-width: 300px;">
        <form id="formEditarUsuario">
          <input type="hidden" id="editId">
          
          <div class="dialog-div-input">Patente: 
            <select id="editPatente" style="width:60%"></select>
          </div>
          <div class="dialog-div-input">Nome de Guerra: 
            <input type="text" id="editNomeGuerra" style="width:60%">
          </div>
          <div class="dialog-div-input">Nome Completo: 
            <input type="text" id="editNomeCompleto" style="width:60%">
          </div>
          <div class="dialog-div-input">CPF: 
            <input type="text" id="editCPF" placeholder="000.000.000-00" maxlength="14" style="width:60%">
          </div>
          <div style="margin-top:15px;">Usuário Ativo:
            <label class="switch-header">
              <input type="checkbox" id="editAtivo"><span class="slider_atv"></span> 
            </label>
          </div>
        </form>
      </div>

      <!-- Coluna Direita: Padrão Semanal -->
      <div class="card" style="flex: 1; min-width: 350px; margin: 0;">
        <h2 style="margin-top:0">Padrão Semanal</h2>
        <table style="width: 100%; text-align: center;">
          <thead>
            <tr>
              <th>Dia</th>
              <th>Café</th>
              <th>Almoço</th>
              <th>Janta</th>
            </tr>
          </thead>
          <tbody id="tabela-padrao-edit">
            <!-- Gerado via JS -->
          </tbody>
        </table>
      </div>

    </div>

    <div style="margin-top: 25px; text-align: right; border-top: 1px solid #eee; padding-top: 15px;">
      <button class="primary" onclick="salvarAlteracoesUsuario()">Salvar Alterações</button>
      <button onclick="fecharModal()">Cancelar</button>
    </div>
  </dialog>

  <?php include 'footer.php'; ?>
  <script src="../js/funcoes.js?t=<?= $ts ?>"></script>
  <script src="../js/usuarios.js?t=<?= $ts ?>"></script>
</body>
</html>
