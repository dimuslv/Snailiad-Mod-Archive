$txt = "";
$assetfolders = Get-Childitem "$destination\exports" -directory;
foreach ($assetfolder in $assetfolders) {
	$assets = Get-Childitem "$destination\exports\$assetfolder" -recurse;
	$assets = $assets | Sort-Object {0 - $_.fullname.split("\").length},{$_.name -replace "\d", ""},{[uint64]($_.name -replace "[^\d]", "")};
	foreach ($asset in $assets) {
		$newname = $asset.basename -replace "(^\d+(_|`$))|(_\d+(?=_|`$))", "";
		$tempname = $newname;
		if ($asset.basename -ne $newname) {
			$changed = $true;
			if ("$($asset.basename)$($asset.extension)" -eq $asset.name) {
				$ext = $asset.extension;
			} else {
				$ext = "";
			}
			if ($newname) {
				$i = 1;
				do {
					$retry = $false;
					try {
						if ($asset.basename -ne $newname) {
							$asset | Rename-Item -NewName "$newname$ext" -ErrorAction Stop;
						} else {
							$changed = $false;
						}
					} catch {
						if ($i -gt 100) {
							$newname;
							$asset | Rename-Item -NewName "$newname$ext";
						}
						$retry = $true;
						$newname = "$i`_$tempname";
						$i++;
					}
				} while ($retry);
			} else {
				$newname = "1";
				$i = 2;
				do {
					$retry = $false;
					try {
						if ($asset.basename -ne $newname) {
							$asset | Rename-Item -NewName "$newname$ext" -ErrorAction Stop;
						} else {
							$changed = $false;
						}
					} catch {
						if ($i -gt 100) {
							$newname;
							$asset | Rename-Item -NewName "$newname$ext";
						}
						$retry = $true;
						$newname = "$i";
						$i++;
					}
				} while ($retry);
			}
			if ($changed) {
				$txt += "$($asset.fullname -replace [RegEx]::Escape(`"$destination\`"), `"`") -> $newname$ext`n";
			}
		} else {
			#$txt += "$($asset.fullname -replace [RegEx]::Escape("$destination\"), `"`") O`n";
		}
	}
}

Set-Content -path "$destination\tinkerlogs\asset_renames.log" -value $txt -encoding default;
