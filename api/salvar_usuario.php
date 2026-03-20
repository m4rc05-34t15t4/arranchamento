<?php
header('Content-Type: application/json');
session_start();
if (!isset($_SESSION['ARRANCHAMENTO']['usuario_id'])){
    http_response_code(400);
    echo json_encode(['erro' => 'Credênciais inválidas']);
    exit;
}
$om_id = $_SESSION['ARRANCHAMENTO']['om_id'];

require_once 'db_conexao.php';

$input = json_decode(file_get_contents('php://input'), true);

if (!$input) {
    http_response_code(400);
    echo json_encode(['erro' => 'JSON inválido']);
    exit;
}

// 1. Prepara os dados (Tratamento básico)
$id            = !empty($input['id']) ? $input['id'] : null;
$id_patente    = $input['patente'] ?? null; // O ID numérico que você filtrou no JS
$nome_guerra   = $input['nome_guerra'] ?? null;
$nome_completo = $input['nome_completo'] ?? null;
$cpf           = preg_replace('/\D/', '', $input['cpf']) ?? null; // Limpa pontos/traços
$ativo         = ($input['ativo'] === 't' || $input['ativo'] === true) ? 't' : 'f';
$padrao        = is_string($input['padrao_semanal']) ? $input['padrao_semanal'] : json_encode($input['padrao_semanal']);

if ( !$id_patente || !$nome_guerra || !$nome_completo || !$cpf ) {
    http_response_code(400);
    echo json_encode(['erro' => 'Dados obrigatórios ausentes']);
    exit;
}
$padraoadm = json_encode($padrao);

if ($id) {
// MODO UPDATE
    $sql = "UPDATE usuarios SET 
        id_patente = $id_patente, 
        nome_guerra = '$nome_guerra', 
        nome_completo = '$nome_completo', 
        cpf = '$cpf', 
        ativo = '$ativo', 
        padrao_semanal = '$padrao'::jsonb
        WHERE id = $id AND id_om = $om_id RETURNING ID;";
} else {
    // MODO INSERT (Caso o ID esteja vazio)
    $s = '$2y$10$v27SCrX./NbDT7771GDTSOXo1fln9EA3Y0HTaHnWy48UCqbpVxpNK';
    $sql = "INSERT INTO usuarios (id_patente, nome_guerra, nome_completo, cpf, ativo, padrao_semanal, senha, id_om) 
            VALUES ($id_patente, '$nome_guerra', '$nome_completo', '$cpf', '$ativo', '$padraoadm'::jsonb, '$s', $om_id)
            RETURNING ID;";
}

$r = executeQuery($sql);
if ( $r["success"] && count($r["data"]) > 0 ){
    echo json_encode([
        'status' => 'ok',
        'mensagem' => 'Usuário salvo com sucesso'
    ]);
} else echo json_encode(['erro' => 'erro ao salvar usuário.']);

