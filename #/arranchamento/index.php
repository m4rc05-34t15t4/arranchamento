<?php
// Caminho do PDF
$pdfFile = __DIR__ . "/arranchamento.pdf";

if (!file_exists($pdfFile)) {
    die("Arquivo não encontrado: $pdfFile\n");
}

// === Lê PDF cru ===
$conteudo = file_get_contents($pdfFile);

// Remove caracteres não imprimíveis
$texto = preg_replace('/[^(\x20-\x7F)\x0A\x0D\xC0-\xFF]/', ' ', $conteudo);

// Quebra em linhas
$linhas = preg_split("/\r\n|\n|\r/", $texto);

// Normalizações de postos
$normalizacoes = [
    "cel"     => "Coronel",
    "maj"     => "Major",
    "cap"     => "Capitão",
    "1º ten"  => "1º Tenente",
    "1° ten"  => "1º Tenente",
    "2º ten"  => "2º Tenente",
    "2° ten"  => "2º Tenente",
    "asp"     => "Aspirante",
    "s ten"   => "Subtenente",
    "1º sgt"  => "1º Sargento",
    "2º sgt"  => "2º Sargento",
    "3º sgt"  => "3º Sargento",
    "cb"      => "Cabo",
    "sd ev"   => "Recruta",   // 👈 aqui você pediu
    "sd"      => "Soldado",
];


// Função de normalização
function normalizaPosto($linha, $normalizacoes) {
    $txt = strtolower($linha);
    foreach ($normalizacoes as $abbr => $posto) {
        if (strpos($txt, $abbr) !== false) {
            return $posto;
        }
    }
    return "Outros";
}

$resumo = [];
$total = ["cafe"=>0, "almoco"=>0, "janta"=>0];

// Processa linhas
foreach ($linhas as $linha) {
    $linha = trim($linha);
    if ($linha === "") continue;

    echo $linha . "<br>";

    $posto = normalizaPosto($linha, $normalizacoes);

    // Conta quantos "SIM" existem na linha
    preg_match_all('/\bSIM\b/u', $linha, $matches);
    $qtdSim = count($matches[0]);

    if ($qtdSim > 0) {
        if (!isset($resumo[$posto])) {
            $resumo[$posto] = ["cafe"=>0, "almoco"=>0, "janta"=>0];
        }
        if ($qtdSim >= 1) { $resumo[$posto]["cafe"]++; $total["cafe"]++; }
        if ($qtdSim >= 2) { $resumo[$posto]["almoco"]++; $total["almoco"]++; }
        if ($qtdSim >= 3) { $resumo[$posto]["janta"]++; $total["janta"]++; }
    }
}

// === Mostra resultado ===
echo "=== Resumo por Posto/Graduação ===\n";
foreach ($resumo as $posto => $dados) {
    echo sprintf("%-15s | Café: %3d | Almoço: %3d | Janta: %3d\n",
        $posto, $dados["cafe"], $dados["almoco"], $dados["janta"]);
}
echo "---------------------------------\n";
echo sprintf("TOTAL           | Café: %3d | Almoço: %3d | Janta: %3d\n",
    $total["cafe"], $total["almoco"], $total["janta"]);
