<?php
    session_start();

    // EXEMPLO (substituir por banco depois)
    $usuario_padrao = 'admin';
    $senha_padrao   = '123456';

    $usuario = $_POST['usuario'] ?? '';
    $senha   = $_POST['senha'] ?? '';

    if ($usuario === $usuario_padrao && $senha === $senha_padrao) {
        $_SESSION['ARRANCHAMENTO']['usuario_id'] = 1;
        $_SESSION['ARRANCHAMENTO']['usuario_nome'] = 'Administrador';
        $_SESSION['ARRANCHAMENTO']['usuario_nome_guerra'] = 'Marcos Batista';
        $_SESSION['ARRANCHAMENTO']['patente'] = '2º Sgt';
        $_SESSION['ARRANCHAMENTO']['administrador'] = True;
        $_SESSION['ARRANCHAMENTO']['om_id'] = 1;
        $_SESSION['ARRANCHAMENTO']['om_nome'] = '3º Centro de Geoinformação';
        $_SESSION['ARRANCHAMENTO']['om_sigla'] = '3º CGEO';

        header('Location: arranchamento.php');
        exit;
    }

header('Location: login.php?erro=1');
exit;
