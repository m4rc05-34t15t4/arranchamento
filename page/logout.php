<?php
    session_start();
    $om_id = $_SESSION['ARRANCHAMENTO']['om_id'];
    /* Remove apenas o contexto do sistema */
    unset($_SESSION['ARRANCHAMENTO']);
    /* Se quiser garantir tudo limpo (opcional) */
    // session_destroy();
    header('Location: login.php?id_om='.$om_id);
    exit;
?>