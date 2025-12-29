<?php
    header('Content-Type: application/json');

    require_once 'db_conexao.php';

    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) {
        http_response_code(400);
        echo json_encode(['erro' => 'JSON inválido']);
        exit;
    }

    $idOm    = $input['id_om'] ?? null;
    $ranchos = $input['ranchos'] ?? null;
    $acao    = $input['acao'] ?? null;

    if (!$idOm || !$ranchos || !$acao) {
        http_response_code(400);
        echo json_encode(['erro' => 'Dados obrigatórios ausentes']);
        exit;
    }

    if ($acao !== 'salvar_ranchos') {
        http_response_code(400);
        echo json_encode(['erro' => 'Ação inválida']);
        exit;
    }

    /* =========================
    CONVERTE PARA JSONB
    ========================= */

    $ranchosJson = json_encode($ranchos);

    /* =========================
    SQL
    ========================= */

    $sql = "
        UPDATE om
        SET ranchos = '$ranchosJson'::jsonb
        WHERE id_om = $idOm
        RETURNING id_om, ranchos;
    ";

    /* =========================
    EXECUTA
    ========================= */

    $r = executeQuery($sql);

    if ($r['success'] && count($r['data']) > 0) {

        session_start();
        if(isset($_SESSION['ARRANCHAMENTO']['ranchos'])) $_SESSION['ARRANCHAMENTO']['ranchos'] = $r['data'][0]['ranchos'];

        echo json_encode([
            'status'   => 'ok',
            'mensagem' => 'Ranchos salvos com sucesso',
            'id_om'    => $r['data'][0]['id_om']
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['erro' => 'Erro ao salvar ranchos']);
    }
?>