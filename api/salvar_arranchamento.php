<?php
header('Content-Type: application/json');

require_once 'db_conexao.php';

$input = json_decode(file_get_contents('php://input'), true);

if (!$input) {
    http_response_code(400);
    echo json_encode(['erro' => 'JSON inválido']);
    exit;
}

$idUsuario      = $input['id_usuario'] ?? null;
$padraoSemanal  = $input['padrao_semanal'] ?? null;
$excecoes       = $input['excecoes'] ?? null;

if (!$idUsuario || !$padraoSemanal) {
    http_response_code(400);
    echo json_encode(['erro' => 'Dados obrigatórios ausentes']);
    exit;
}

$excecaoSemanal = $excecoes['semanal'] ?? [];
$excecaoDiaria = $excecoes['diaria'] ?? [];
$excecaoManual = $excecoes['manual'] ?? [];

$padrao = json_encode($padraoSemanal);
$excecao_semanal = json_encode($excecaoSemanal);
$excecao_diaria = json_encode($excecaoDiaria);
$excecao_manual = json_encode($excecaoManual);
$sql = "
    UPDATE usuarios SET
        padrao_semanal   = '$padrao',
        excecao_semanal  = '$excecao_semanal',
        excecao_diaria   = '$excecao_diaria',
        excecao_manual   = '$excecao_manual' 
    WHERE id = $idUsuario RETURNING ID;";

$r = executeQuery($sql);
if ( $r["success"] && count($r["data"]) > 0 ){
    echo json_encode([
        'status' => 'ok',
        'mensagem' => 'Arranchamento salvo com sucesso'
    ]);
} else echo json_encode(['erro' => 'erro ao salvar arranchamento.']);

