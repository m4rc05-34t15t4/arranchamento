<?php
    session_start();
    if (isset($_SESSION['ARRANCHAMENTO']['usuario_id'])) {
        header('Location: arranchamento.php');
        exit;
    }
    $ts = time();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Sistema de Arranchamento</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/style.css?t=<?= $ts ?>">
</head>
<body>

<div class="login-page">
  <div class="card login-card">

   <?php
      if (isset($_GET['id_om']) && $_GET['id_om'] !== '') {
          $id_om = basename($_GET['id_om']);
          $caminho_img = "../img/om/{$id_om}.png";
          if (file_exists($caminho_img)) echo '<img src="'.$caminho_img.'" alt="Logo OM" class="logo-login">';
      }
    ?>

    <h1>Arranchamento</h1>

    <?php if (!empty($_GET['erro'])): ?>
      <div class="login-erro">Usuário ou senha inválidos</div>
    <?php endif; ?>

    <form method="post" action="../api/validar_login.php">
      <label>Usuário</label>
      <input type="text" name="usuario" required>

      <label>Senha</label>
      <input type="password" name="senha" required>

      <button type="submit">Entrar</button>
    </form>

  </div>
</div>

</body>
</html>
