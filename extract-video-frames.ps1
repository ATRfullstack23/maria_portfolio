Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$videoPath = 'C:\Users\trama\Downloads\WhatsApp Video 2026-04-01 at 1.01.36 PM.mp4'
$outDir = 'C:\Projects\mary_portfolio\video-frames'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$player = New-Object System.Windows.Media.MediaPlayer
$opened = $false
$handler = [System.EventHandler] { $script:opened = $true }
$player.add_MediaOpened($handler)
$player.Open((New-Object System.Uri($videoPath)))

$sw = [System.Diagnostics.Stopwatch]::StartNew()
while (-not $script:opened -and $sw.ElapsedMilliseconds -lt 10000) {
  Start-Sleep -Milliseconds 100
}
if (-not $script:opened) { throw 'Media failed to open' }

$times = @(2, 6, 10, 14, 18)
$width = 900
$height = 506
foreach ($t in $times) {
  $player.Position = [TimeSpan]::FromSeconds($t)
  Start-Sleep -Milliseconds 700

  $drawingVisual = New-Object System.Windows.Media.DrawingVisual
  $drawingContext = $drawingVisual.RenderOpen()
  $rect = New-Object System.Windows.Rect(0, 0, $width, $height)
  $videoDrawing = New-Object System.Windows.Media.VideoDrawing
  $videoDrawing.Rect = $rect
  $videoDrawing.Player = $player
  $drawingContext.DrawDrawing($videoDrawing)
  $drawingContext.Close()

  $renderTarget = New-Object System.Windows.Media.Imaging.RenderTargetBitmap($width, $height, 96, 96, [System.Windows.Media.PixelFormats]::Pbgra32)
  $renderTarget.Render($drawingVisual)

  $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
  $encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($renderTarget))
  $filePath = Join-Path $outDir ("frame-$t.png")
  $stream = [System.IO.File]::Open($filePath, [System.IO.FileMode]::Create)
  $encoder.Save($stream)
  $stream.Close()
}

$player.Close()
