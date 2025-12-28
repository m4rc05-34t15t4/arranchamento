<?php
    session_start();
    if (!isset($_SESSION['ARRANCHAMENTO']['usuario_id'])) {
        header('Location: login.php');
        exit;
    }
?>