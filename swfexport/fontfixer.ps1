$pypath="C:\Users\dimus\AppData\Local\Programs\Python\Python39\Scripts\ttx.exe";

$xml=New-Object XML;

$fpath="$destination\exports\fonts";

$fonts=Get-ChildItem $fpath -Name

foreach ($f in $fonts) {
    
    & $pypath -f -o "$fpath\temp.ttx" -t head "$fpath\$f"
    $xml.Load("$fpath\temp.ttx")
    $xml.SelectSingleNode("/ttFont/head/created").SetAttribute("value", "Mon Jun 27 00:00:00 2011");
    $xml.SelectSingleNode("/ttFont/head/modified").SetAttribute("value", "Mon Jun 27 00:00:00 2011");
    $xml.Save("$fpath\temp.ttx")
    & $pypath -f -o "$fpath\$f" -m "$fpath\$f" --no-recalc-timestamp "$fpath\temp.ttx"
}
Remove-Item "$fpath\temp.ttx";