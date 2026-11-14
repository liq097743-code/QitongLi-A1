param([switch]$Test)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$compiler = Get-Command javac -ErrorAction SilentlyContinue
if ($compiler) {
    $javaBin = Split-Path $compiler.Source
} elseif ($env:JAVA_HOME -and (Test-Path (Join-Path $env:JAVA_HOME 'bin/javac.exe'))) {
    $javaBin = Join-Path $env:JAVA_HOME 'bin'
} else {
    throw 'Install JDK 17 and set JAVA_HOME or add its bin directory to PATH.'
}
New-Item -ItemType Directory -Force out | Out-Null
$sources = @(Get-ChildItem src/*.java, tests/*.java | ForEach-Object { $_.FullName })
& (Join-Path $javaBin 'javac.exe') -encoding UTF-8 -Xlint:all -d out @sources
if ($LASTEXITCODE -ne 0) { throw 'Compilation failed.' }
$entryPoint = if ($Test) { 'AppointmentSystemTest' } else { 'AssignmentOne' }
& (Join-Path $javaBin 'java.exe') -cp out $entryPoint
if ($LASTEXITCODE -ne 0) { throw 'Execution failed.' }
