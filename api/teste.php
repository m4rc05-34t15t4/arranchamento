<?php
    //header('Content-Type: application/json');

    require_once 'db_conexao.php';


    //Relatorios
    $relatorios = null;
    $sql = "SELECT * FROM RELATORIOS;";
    $r = executeQuery($sql);
    if ( $r["success"] && count($r["data"]) > 0 ) $relatorios = $r["data"][0];

    var_dump($relatorios);

?>
