<?php
    //header('Content-Type: application/json');

    //require_once 'db_conexao.php';

    //$ip = $_SERVER['REMOTE_ADDR'];

    //echo $ip;


    /*//Relatorios
    $relatorios = null;
    $sql = "SELECT * FROM RELATORIOS;";
    $r = executeQuery($sql);
    if ( $r["success"] && count($r["data"]) > 0 ) $relatorios = $r["data"][0];

    var_dump($relatorios);*/

    //session_start();

    //VAR_DUMP($_SESSION['ARRANCHAMENTO']);

    $s = '3cgeo';

    $senha_plana = $s; // <<< TROQUE AQUI PELA SENHA REAL

    $hash = password_hash($senha_plana, PASSWORD_DEFAULT);

    echo password_verify($s, $hash);

    echo "<pre>";
    echo "Senha original: {$senha_plana}\n\n";
    echo "Hash para salvar no banco:\n{$hash}\n";
    echo "</pre>";


?>
