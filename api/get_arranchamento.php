<?php
    header('Content-Type: application/json');

    require_once 'db_conexao.php';

    $dia = $_GET['dia'] ?? null;
    $om = $_GET['om'] ?? null;

    if (!$dia || !$om) {
        http_response_code(400);
        echo json_encode(['erro' => 'Parâmetros em falta']);
        exit;
    }

    //Relatorios
    $relatorios = null;
    $sql = "SELECT * FROM RELATORIOS WHERE DATA_RELATORIO = '$dia' AND ID_OM = $om;";
    $r = executeQuery($sql);
    if ( $r["success"] && count($r["data"]) > 0 ) $relatorios = $r["data"][0];

    //usuarios
    $usuarios = null;
    $sql = "SELECT
        u.id,
        u.nome_guerra,
        u.nome_completo,
        u.padrao_semanal,
        u.excecao_semanal,
        u.excecao_diaria,
        u.excecao_manual,
        u.ativo,
        p.nome AS patente,
        p.ordem AS ordem_patente, 
        o.nome_om,
        o.sigla_om 
    FROM usuarios u
    JOIN patentes p ON p.id = u.id_patente
    JOIN om o ON o.id_om = u.id_om
    WHERE u.id_om = $om AND u.ativo = TRUE 
    order by ordem_patente desc, nome_guerra;";
    $r = executeQuery($sql);
    if ( $r["success"] && count($r["data"]) > 0 ) $usuarios = $r["data"];

    //quantidade
    $total_ativos = null;
    $sql = "SELECT 
            COALESCE(r.rancho_info->>'nome', 'total_geral') AS rancho,
            COUNT(u.id) AS total_ativos
        FROM 
            om o
        CROSS JOIN LATERAL 
            jsonb_array_elements(o.ranchos) AS r(rancho_info)
        LEFT JOIN 
            patentes p ON r.rancho_info->'patente' ? p.nome
        LEFT JOIN 
            usuarios u ON u.id_patente = p.id 
            AND u.id_om = o.id_om 
            AND u.ativo = true
        WHERE 
            o.id_om = 1
        GROUP BY 
            ROLLUP(r.rancho_info->>'nome')
        ORDER BY 
            (r.rancho_info->>'nome' IS NULL), -- Garante que o TOTAL GERAL fique por último
            total_ativos DESC;
        ";
    $r = executeQuery($sql);
    if ( $r["success"] && count($r["data"]) > 0 ) $total_ativos = array_column($r["data"], null, 'rancho');;

    echo json_encode([
        'relatorios' => $relatorios,
        'usuarios'   => $usuarios,
        'total_ativos' => $total_ativos
    ]);
?>
