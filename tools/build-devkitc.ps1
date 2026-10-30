param([Parameter(Mandatory=$true)][string]$ArduinoCli,[Parameter(Mandatory=$true)][string]$ConfigFile)
$ErrorActionPreference = 'Stop'
try {
 $projectRoot = Split-Path -Parent $PSScriptRoot
 $firmwareOutput = Join-Path $projectRoot 'build-devkitc'
 & $ArduinoCli --config-file $ConfigFile compile --fqbn 'esp32:esp32:esp32:FlashMode=dio,FlashFreq=40,FlashSize=4M,PartitionScheme=min_spiffs,PSRAM=disabled' --build-property 'compiler.cpp.extra_flags=-DBB_LINK_DEVKITC_32E' --jobs 2 --output-dir $firmwareOutput (Join-Path $projectRoot 'src/bb-link')
 if ($LASTEXITCODE -ne 0) { throw "Compile failed: $LASTEXITCODE" }
 exit 0
} catch { Write-Error $_; exit 1 }
