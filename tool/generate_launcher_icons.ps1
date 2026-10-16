Add-Type -AssemblyName System.Drawing
$sizes = @{ mdpi = 48; hdpi = 72; xhdpi = 96; xxhdpi = 144; xxxhdpi = 192 }
$dark = [System.Drawing.ColorTranslator]::FromHtml('#171717')
$mint = [System.Drawing.ColorTranslator]::FromHtml('#C7E5C3')
$bitmap = [System.Drawing.Bitmap]::new(1024, 1024)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.Clear($mint)
$card = [System.Drawing.Drawing2D.GraphicsPath]::new()
$card.AddArc(130, 130, 125, 125, 180, 90); $card.AddArc(769, 130, 125, 125, 270, 90)
$card.AddArc(769, 769, 125, 125, 0, 90); $card.AddArc(130, 769, 125, 125, 90, 90); $card.CloseFigure()
$white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$cardPen = [System.Drawing.Pen]::new($dark, 30)
$graphics.FillPath($white, $card); $graphics.DrawPath($cardPen, $card)
$xs = @(280, 440, 600); $heights = @(190, 325, 460); $fills = @('#FFD600', '#FFA726', '#00C853')
for ($i = 0; $i -lt 3; $i++) {
  $rect = [System.Drawing.Rectangle]::new($xs[$i], (745 - $heights[$i]), 125, $heights[$i])
  $brush = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($fills[$i]))
  $pen = [System.Drawing.Pen]::new($dark, 19)
  $graphics.FillRectangle($brush, $rect); $graphics.DrawRectangle($pen, $rect)
  $brush.Dispose(); $pen.Dispose()
}
$trendPen = [System.Drawing.Pen]::new($dark, 39)
$trendPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$trendPen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$trendPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$points = [System.Drawing.Point[]]@([System.Drawing.Point]::new(260,545), [System.Drawing.Point]::new(425,405), [System.Drawing.Point]::new(535,460), [System.Drawing.Point]::new(735,250))
$graphics.DrawLines($trendPen, $points)
$coinBrush = [System.Drawing.SolidBrush]::new($mint); $coinPen = [System.Drawing.Pen]::new($dark,20)
$graphics.FillEllipse($coinBrush,682,624,205,205); $graphics.DrawEllipse($coinPen,682,624,205,205)
$font = [System.Drawing.Font]::new('Arial',144,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Pixel)
$format = [System.Drawing.StringFormat]::new(); $format.Alignment = [System.Drawing.StringAlignment]::Center; $format.LineAlignment = [System.Drawing.StringAlignment]::Center
$graphics.DrawString('$',$font,[System.Drawing.SolidBrush]::new($dark),[System.Drawing.RectangleF]::new(682,612,205,205),$format)
foreach ($entry in $sizes.GetEnumerator()) {
  $directory = "android/app/src/main/res/mipmap-$($entry.Key)"
  Remove-Item -Force -ErrorAction SilentlyContinue "$directory/ic_launcher.xml", "$directory/ic_launcher_round.xml"
  $resized = [System.Drawing.Bitmap]::new($entry.Value, $entry.Value)
  $rg = [System.Drawing.Graphics]::FromImage($resized)
  $rg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $rg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $rg.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $rg.DrawImage($bitmap, [System.Drawing.Rectangle]::new(0,0,$entry.Value,$entry.Value), [System.Drawing.Rectangle]::new(0,0,1024,1024), [System.Drawing.GraphicsUnit]::Pixel)
  $png = Join-Path $directory 'ic_launcher.png'; $resized.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)
  Copy-Item -Force $png (Join-Path $directory 'ic_launcher_round.png')
  $rg.Dispose(); $resized.Dispose()
}
$format.Dispose(); $font.Dispose(); $coinBrush.Dispose(); $coinPen.Dispose(); $trendPen.Dispose(); $white.Dispose(); $cardPen.Dispose(); $card.Dispose(); $graphics.Dispose(); $bitmap.Dispose()
