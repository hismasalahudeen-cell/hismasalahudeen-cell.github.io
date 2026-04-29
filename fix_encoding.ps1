$path = "index.html"
$content = Get-Content $path -Raw
$replacements = @{
    'Open Escape Room â†’' = 'Open Escape Room &rarr;'
    'Launch Demo â†’' = 'Launch Demo &rarr;'
    'View Full Document â†’' = 'View Full Document &rarr;'
    'View Lesson Plan â†’' = 'View Lesson Plan &rarr;'
    'ðŸ”' = '&#128274;'
    'ðŸŽ¯' = '&#127891;'
    'ðŸ§©' = '&#128161;'
    'ðŸ¤' = '&#128101;'
    'Ã—' = '&times;'
    'ðŸ“¸' = '&#128247;'
    'ðŸ‘¤' = '&#128100;'
    'ðŸ“¬' = '&#128231;'
    'ðŸ·ï¸' = '&#128205;'
    'ðŸ“ž' = '&#128241;'
    'ðŸ’¼' = '&#128279;'
}
foreach ($old in $replacements.Keys) {
    $new = $replacements[$old]
    $content = $content -replace [regex]::Escape($old), $new
}
Set-Content $path -Value $content -Encoding UTF8
Write-Host "Encoding cleanup completed."