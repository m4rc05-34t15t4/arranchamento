<?php
header('Content-Type: application/json');

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
    echo json_encode(['erro' => 'Erro de conexão']);
    exit;
}

$id = $_GET['id'] ?? null;

if (!$id) {
    http_response_code(400);
    echo json_encode(['erro' => 'ID não informado']);
    exit;
}

$sql = "
SELECT
    u.id,
    u.nome_guerra,
    u.nome_completo,
    u.padrao_semanal,
    u.excecao_semanal,
    u.excecao_diaria,
    u.excecao_manual,
    p.nome AS patente,
    p.ordem AS ordem_patente, 
    o.nome_om,
    o.sigla_om
FROM usuarios u
JOIN patentes p ON p.id = u.id_patente
JOIN om o ON o.id_om = u.id_om
WHERE u.id = :id
";

$stmt = $pdo->prepare($sql);
$stmt->execute([':id' => $id]);

$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$usuario) {
    http_response_code(404);
    echo json_encode(['erro' => 'Usuário não encontrado']);
    exit;
}

//arranchamentos_anteriores

$sql = "
SELECT id as id_relatorio, data_relatorio, usuarios_refeicoes, data_atualizacao FROM relatorios
WHERE data_relatorio >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
AND jsonb_exists(usuarios_refeicoes::jsonb, :id_usuario)
";

//echo json_encode(['erro' => $sql]);

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':id_usuario', (string)$id, PDO::PARAM_STR);
$stmt->execute();
$registros = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 🔄 decodificar JSON

foreach ($registros as &$r) {
    if (isset($r['usuarios_refeicoes'])) {
        $r['usuarios_refeicoes'] = json_decode($r['usuarios_refeicoes'], true);
        $r['usuarios_refeicoes'] = $r['usuarios_refeicoes'][$id];
    }
}

echo json_encode([
    'id'              => $usuario['id'],
    'nome'            => $usuario['nome_guerra'],
    'nome_completo'   => $usuario['nome_completo'],
    'patente'         => $usuario['patente'],
    'om'              => $usuario['nome_om'],
    'sigla_om'        => $usuario['sigla_om'],
    'padrao_semanal'  => json_decode($usuario['padrao_semanal'] ?? '[]', true) ?? [],
    'excecao_semanal' => json_decode($usuario['excecao_semanal'] ?? '[]', true) ?? [],
    'excecao_diaria'  => json_decode($usuario['excecao_diaria'] ?? '[]', true) ?? [],
    'excecao_manual'  => json_decode($usuario['excecao_manual'] ?? '[]', true) ?? [],
    'arranchamentos_relatorios' => $registros
]);
