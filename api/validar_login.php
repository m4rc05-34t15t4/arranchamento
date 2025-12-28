<?php
    session_start();
    require_once 'db_conexao.php';

    $link_erro = 'Location: ../page/login.php?erro=1';

    $usuario = trim($_POST['usuario'] ?? '');
    $senha   = $_POST['senha'] ?? '';

    if (!$usuario || !$senha) {
        header($link_erro);
        exit;
    }

    /**
     * 🔐 Busca usuário no banco
     * Usa o mesmo padrão executeQuery que você já utiliza
     */
    $sql = "
        SELECT
            u.id,
            u.email AS usuario_login,
            u.senha,
            u.nome_guerra,
            u.nome_completo,
            p.nome  AS patente,
            p.ordem AS ordem_patente,
            o.id_om,
            o.nome_om,
            o.sigla_om,
            o.ranchos,
            CASE
                WHEN o.administradores IS NULL THEN 0
                WHEN u.id = ANY(o.administradores) THEN 1
                ELSE 0
            END AS administrador
        FROM usuarios u
        JOIN patentes p ON p.id = u.id_patente
        JOIN om o ON o.id_om = u.id_om
        WHERE (u.email = '{$usuario}' OR u.idt_mil = '{$usuario}' OR u.cpf = '{$usuario}')
        AND u.ativo = true
        LIMIT 1;
    ";

    $r = executeQuery($sql);

    if (!$r['success'] || count($r['data']) === 0) {
        header($link_erro);
        exit;
    }

    $u = $r['data'][0];

    /**
     * 🔐 Verificação de senha (hash imutável entre VPS)
     */
    if (!password_verify($senha, $u['senha'])) {
        header($link_erro);
        exit;
    }

    /**
     * ✅ Login OK → cria sessão
     */
    $_SESSION['ARRANCHAMENTO'] = [
        'usuario_id'           => $u['id'],
        'usuario_nome'         => $u['nome_completo'],
        'usuario_nome_guerra'  => $u['nome_guerra'],
        'patente'              => $u['patente'],
        'administrador'        => $u['administrador'] == 1,
        'om_id'                => $u['id_om'],
        'om_nome'              => $u['nome_om'],
        'om_sigla'             => $u['sigla_om'],
        'ranchos'             => $u['ranchos'],
    ];

    /**
     * 🔄 Regenera ID da sessão (segurança)
     */
    session_regenerate_id(true);

    header('Location: ../page/arranchamento.php');
    exit;
?>