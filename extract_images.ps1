# Script to extract base64 images from HTML and replace with file references

$content = Get-Content "index.html" -Raw
$imageIndex = 1

# Find all data:image URIs
$dataUris = [regex]::Matches($content, 'data:image/([^;]+);base64,([^"]+)')

foreach ($match in $dataUris) {
    $mimeType = $match.Groups[1].Value
    $base64Data = $match.Groups[2].Value

    # Decode base64
    try {
        $bytes = [System.Convert]::FromBase64String($base64Data)
        $extension = if ($mimeType -eq 'jpeg') { 'jpg' } else { $mimeType }
        $filename = "images/image_$imageIndex.$extension"
        [System.IO.File]::WriteAllBytes($filename, $bytes)
        Write-Host "Extracted $filename"

        # Replace in content
        $oldUri = $match.Value
        $newUri = $filename
        $content = $content.Replace($oldUri, $newUri)
        $imageIndex++
    } catch {
        Write-Host "Failed to decode image $imageIndex"
    }
}

# Save the updated HTML
$content | Out-File "index_new.html" -Encoding UTF8
Write-Host "Updated HTML saved as index_new.html"