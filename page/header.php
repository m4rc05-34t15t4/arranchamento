<?php 
  require_once 'session.php';
  $pagina = pathinfo($_SERVER['PHP_SELF'], PATHINFO_FILENAME);
  $om_id = $_SESSION['ARRANCHAMENTO']['om_id'];
  $id_usu = $_SESSION['ARRANCHAMENTO']['usuario_id'];
  //Variaveis sessão para JS
  echo '
    <script> 
      const $om_id = '.$om_id.';
      const $responsavel_id = '.$id_usu.';
    </script>';
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
      <div>
        <a href="logout.php" class="logout-link" onclick="return confirm('Deseja realmente sair do sistema?')"> Sair </a>
        <?php 
          $titulo = $link = '';
          switch ($pagina) {
            case 'relatorio':
              $link = ' | <a href="arranchamento.php" class="logout-link"> Arranchamento </a>';
              $titulo = "Relatório";
              break;
            case 'arranchamento':
              $link = ' | <a href="relatorio.php" class="logout-link"> Relatório </a>';
              $titulo = "Arranchamento";
              break;
          }
          echo $link;// if($_SESSION['ARRANCHAMENTO']['administrador']) echo ' | <a href="" class="logout-link"> Config </a>'.$link;
        ?>
      </div>
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
