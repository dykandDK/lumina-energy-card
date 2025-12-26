$paths = @('.\\locales', '.\\dist\\locales')
foreach ($p in $paths) {
    if (Test-Path $p) {
        Get-ChildItem -Path $p -Filter *.json -File -Recurse | ForEach-Object {
            Write-Output ("--- Checking: " + $_.FullName)
            try {
                $s = Get-Content -Raw -Path $_.FullName
                $null = $s | ConvertFrom-Json
                Write-Output ("OK: " + $_.FullName)
            }
            catch {
                Write-Output ("ERROR: " + $_.FullName + " - " + $_.Exception.Message)
            }
        }
    }
    else {
        Write-Output ("Path not found: " + $p)
    }
}
Write-Output "Done"
