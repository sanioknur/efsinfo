$crypt=Cipher /U /N
$arr = @()
gci $crypt -recurse | ? {$_.PSIsContainer -eq $False} | % {
  $obj = New-Object PSObject
  $obj | Add-Member NoteProperty Directory $_.DirectoryName
  $obj | Add-Member NoteProperty Name $_.Name
  $obj | Add-Member NoteProperty Length $_.Length
  $obj | Add-Member NoteProperty Owner ((Get-ACL $_.FullName).Owner)
  $arr += $obj
  }
  $arr | Export-CSV -notypeinformation "report.csv"