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
            <th>P/G</th>
            <th>Nome de Guerra</th>
            <th>
                <label class="switch-header">
                    <input type="checkbox" id="master-nao" onclick="toggleColuna('chk-nao', this.checked)">
                    <span class="slider"></span>
                </label><br><small>Não Arranchar</small>
            </th>
            <th><input type="checkbox" id="master-cafe" onclick="toggleColuna('chk-cafe', this.checked)"><br>Café</th>
            <th><input type="checkbox" id="master-almoco" onclick="toggleColuna('chk-almoco', this.checked)"><br>Almoço</th>
            <th><input type="checkbox" id="master-janta" onclick="toggleColuna('chk-janta', this.checked)"><br>Janta</th>
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
