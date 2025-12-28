<?php
    session_start();
    /* Remove apenas o contexto do sistema */
    unset($_SESSION['ARRANCHAMENTO']);
    /* Se quiser garantir tudo limpo (opcional) */
    // session_destroy();
    header('Location: login.php');
    exit;
?>