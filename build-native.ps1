$ErrorActionPreference = 'Stop'

$repositoryRoot = $PSScriptRoot
$vsWhere = 'C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe'
$visualStudio = & $vsWhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
if (-not $visualStudio) {
    throw 'Visual Studio C++ build tools were not found.'
}

$developerEnvironment = Join-Path $visualStudio 'Common7\Tools\VsDevCmd.bat'
$sourceDirectory = Join-Path $repositoryRoot 'native'
$artifactDirectory = Join-Path $repositoryRoot 'artifacts'
$resourceOutput = Join-Path $sourceDirectory 'Resonance32x9Patcher.res'
$executableOutput = Join-Path $artifactDirectory 'Resonance32x9Patcher.exe'
New-Item -ItemType Directory -Force -Path $artifactDirectory | Out-Null

$buildCommand = 'call "' + $developerEnvironment + '" -arch=x64 -host_arch=x64 >nul && ' +
    'rc.exe /nologo /fo "' + $resourceOutput + '" "' + $sourceDirectory + '\Resonance32x9Patcher.rc" && ' +
    'cl.exe /nologo /std:c++17 /O2 /GL /MT /EHsc /W4 "' + $sourceDirectory + '\Resonance32x9Patcher.cpp" "' +
    $resourceOutput + '" /link /LTCG /OPT:REF /OPT:ICF /SUBSYSTEM:WINDOWS /OUT:"' + $executableOutput + '"'

& cmd.exe /d /c $buildCommand
if ($LASTEXITCODE -ne 0) {
    throw "Native build failed with exit code $LASTEXITCODE."
}

Get-Item $executableOutput | Select-Object FullName, Length, LastWriteTime
