$ffdecpath="C:\Program Files (x86)\FFDec\ffdec.bat";

Remove-Item -path "$destination\**" -recurse;

New-Item $destination -Name "swf" -ItemType "directory";
Copy-Item $file -Destination "$destination\swf";

New-Item $destination -Name "exports" -ItemType "directory";
& $ffdecpath -export all "$destination\exports" $file;
& $ffdecpath -format script:pcode -onerror ignore -export script "$destination\exports" $file;
& $ffdecpath -swf2xml $file "$destination\exports\swf.xml";

New-Item $destination -Name "tinkerlogs" -ItemType "directory";