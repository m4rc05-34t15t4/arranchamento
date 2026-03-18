<dialog id="dialogAdm" style="width: 80%; max-width: 800px;">
  <h2>Adicionar Exceção Administrativa</h2>
  
  <!-- Filtros -->
  <div style="display: flex; gap: 10px; margin-bottom: 15px;">
    <input type="text" id="filtroNome" placeholder="Filtrar por nome..." oninput="filtrarUsuarios()">
    <select id="filtroPosto" onchange="filtrarUsuarios()"></select>
  </div>

  <!-- Tabela de Usuários -->
  <div style="max-height: 500px; overflow-y: auto;">
    <table id="tabelaAdm">
      <thead>
        <tr>
          <th onclick="ordenarUsuarios('patente')">P/G ↕</th>
          <th onclick="ordenarUsuarios('nome_guerra')">Nome de Guerra ↕</th>
          <th>Não arranchar</th>
          <th>Café</th>
          <th>Almoço</th>
          <th>Janta</th>
        </tr>
      </thead>
      <tbody id="lista-usuarios-adm">
        <!-- Preenchido via JS -->
      </tbody>
    </table>
  </div>

  <div style="margin-top: 20px; text-align: right;">
    <button class="primary" onclick="salvarExcecaoAdm()">Salvar</button>
    <button onclick="fecharDialogAdm()">Cancelar</button>
  </div>
</dialog>
<script src="../js/dialog_usuarios.js?t=<?=$ts?>"></script>
