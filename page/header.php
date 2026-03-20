<?php 
  require_once 'session.php';
  $pagina = pathinfo($_SERVER['PHP_SELF'], PATHINFO_FILENAME);
  $om_id = $_SESSION['ARRANCHAMENTO']['om_id'];
  $id_usu = $_SESSION['ARRANCHAMENTO']['usuario_id'];
  $adm = $_SESSION['ARRANCHAMENTO']['administrador'];
  //Variaveis sessão para JS
  echo '
    <script> 
      const $om_id = '.$om_id.';
      const $responsavel_id = '.$id_usu.';
    </script>';

  $class_link = [
    'arranchamento' => ['classe' => 'link', 'titulo' => 'Arranchamento', 'adm' => false],
    'relatorio' => ['classe' => 'link', 'titulo' => 'Relatório', 'adm' => true],
    'usuarios' => ['classe' => 'link', 'titulo' => 'Usuários', 'adm' => true]
  ];
  $class_link[$pagina]['classe'] .= ' active';
  $titulo = $class_link[$pagina]['titulo'];
?>
<header class="topbar">
  <div class="left">
    <img src="../img/usuario/<?=$id_usu?>.jpg" alt="Imagem Usuário" class="logo" onerror="
       if (this.src.endsWith('<?=$id_usu?>.jpg')) {
         this.src = '../img/usuario/<?=$id_usu?>.png';
       } else {
         this.src = '../img/avatar.png';
       }
     ">
    <div class="user-info">
      <strong id="nome-usuario"><?php echo $_SESSION['ARRANCHAMENTO']['patente'] . ' ' . $_SESSION['ARRANCHAMENTO']['usuario_nome_guerra']; ?></strong>
      <nav class="menu-navegacao">
          <a href="logout.php" class="link" onclick="return confirm('Deseja realmente sair do sistema?')"> Sair </a>
          <?php 
            foreach ($class_link as $arquivo => $dados):
              if(!$dados['adm'] || ($dados['adm'] && $adm)) echo '<a href="'.$arquivo.'.php" class="'.$dados['classe'].'">'.$dados['titulo'].'</a>';
            endforeach; 
          ?>
      </nav>
    </div>
  </div>

  <div class="center">
    <h1><?=$titulo?></h1>
  </div>

  <div class="right">
    <div class="om-box">
      <strong id="om-usuario" class="quartel"><?php echo $_SESSION['ARRANCHAMENTO']['om_sigla']; ?></strong>
      <img src="../img/om/<?=$om_id?>.png" alt="Logo" class="logo_om">
    </div>
  </div>
</header>
