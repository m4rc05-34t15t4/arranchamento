<?php
header('Content-Type: application/json');

// ================== CONFIG BANCO ==================
$host = 'localhost';
$db   = 'arranchamento';
$user = 'postgres';
$pass = 'admin';
$port = '5432';

try {
    $pdo = new PDO(
        "pgsql:host=$host;port=$port;dbname=$db",
        $user,
        $pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['erro' => 'Erro ao conectar no banco']);
    exit;
}

// ================== LER JSON ==================
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

// ================== SEPARAR EXCEÇÕES ==================
$excecaoSemanal = [];
$excecaoDiaria  = [];

foreach ($excecoes as $e) {
    if ($e['modo'] === 'semanal') {
        $excecaoSemanal[] = $e;
    } else {
        $excecaoDiaria[] = $e;
    }
}

// ================== UPDATE ==================
$sql = "
    UPDATE usuarios
    SET
        padrao_semanal   = :padrao,
        excecao_semanal  = :excecao_semanal,
        excecao_diaria   = :excecao_diaria
    WHERE id = :id
";

$stmt = $pdo->prepare($sql);

$stmt->execute([
    ':padrao'           => json_encode($padraoSemanal),
    ':excecao_semanal'  => json_encode($excecaoSemanal),
    ':excecao_diaria'   => json_encode($excecaoDiaria),
    ':id'               => $idUsuario
]);

echo json_encode([
    'status' => 'ok',
    'mensagem' => 'Arranchamento salvo com sucesso'
]);
