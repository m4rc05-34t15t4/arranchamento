<?php
    header('Content-Type: application/json');

    require_once 'db_conexao.php';

    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input) {
        http_response_code(400);
        echo json_encode(['erro' => 'JSON inválido']);
        exit;
    }

    $dataRelatorio      = $input['data_relatorio'] ?? null;
    $idOm               = $input['id_om'] ?? null;
    $idResponsavel      = $input['id_responsavel'] ?? null;
    $usuariosRefeicoes  = $input['usuarios_refeicoes'] ?? null;
    $acao               = $input['acao'] ?? null;

    if (!$dataRelatorio || !$idOm || !$idResponsavel || !$acao) {
        http_response_code(400);
        echo json_encode(['erro' => 'Dados obrigatórios ausentes']);
        exit;
    }

    // transforma o array em JSON para o jsonb
    if($usuariosRefeicoes)  $usuariosRefeicoesJson = json_encode($usuariosRefeicoes);
    else $usuariosRefeicoesJson = json_encode((object)$usuariosRefeicoes);

    /* =========================
    DEFINE SQL POR AÇÃO
    ========================= */

    if ($acao === 'gerar') {
        $sql = "
            INSERT INTO relatorios (
                data_relatorio,
                id_om,
                usuarios_refeicoes,
                id_responsavel
            ) VALUES (
                '$dataRelatorio',
                $idOm,
                '$usuariosRefeicoesJson'::jsonb,
                $idResponsavel
            )
            RETURNING id;
        ";

    } elseif ($acao === 'atualizar') {
        $sql = "
            UPDATE relatorios SET
                usuarios_refeicoes = '$usuariosRefeicoesJson'::jsonb,
                id_responsavel     = $idResponsavel,
                data_atualizacao   = CURRENT_TIMESTAMP
            WHERE data_relatorio = '$dataRelatorio'
            AND id_om = $idOm
            RETURNING id;
        ";
    } elseif ($acao === 'deletar') $sql = "DELETE FROM relatorios WHERE data_relatorio = '$dataRelatorio' AND id_om = $idOm RETURNING id;";
    else {
        http_response_code(400);
        echo json_encode(['erro' => 'Ação inválida']);
        exit;
    }

    /* =========================
    EXECUTA
    ========================= */

    $r = executeQuery($sql);

    if ($r['success'] && count($r['data']) > 0) {
        echo json_encode([
            'status'   => 'ok',
            'mensagem' => $acao === 'Gerar'
                ? 'Arranchamento diário gerado com sucesso'
                : 'Arranchamento diário atualizado com sucesso',
            'id' => $r['data'][0]['id']
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['erro' => 'Erro ao salvar arranchamento diário']);
    }
?>