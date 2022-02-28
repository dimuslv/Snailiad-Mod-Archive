$mappath = "C:\Users\dimus\Desktop\snailmods\githubbed\constants\base.tmx";
$sheetpath = "C:\Users\dimus\Desktop\snailmods\githubbed\constants\tilesheet.png";
$tiledpath = "C:\Program Files\Tiled\tmxrasterizer.exe";

$cmap = New-Object XML;
$cmap.Load($mappath);
$xmap = New-Object XML;
$binaries = Get-Childitem "$destination\exports\binaryData";
$c = $false;
$x = $false;
foreach ($binary in $binaries) {
	if ($binary.name -match "WorldMap_WorldMap(...?)Txt") {
		$num = -1;
		switch ($Matches[1]) {
			"Sky" {$num = 0;}
			"Bg" {$num = 1;}
			"Fg" {$num = 2;}
			"Sp" {$num = 3;}
		}
		if ($num -ne -1) {
			$txt = Get-Content $binary.fullname;
			$h = $txt.length;
			$w = $txt[0].split(",").length;
			if ($txt[$h-1].split(",").length -ne $w) {
				$txt[$h-1] += ",";
			}
			$insert = ($txt -join ",") -replace "(?<=^|,)\D*?(?=,|$)", "0";
			$cmap.map.layer[$num].data.innerText = $insert;
			$cmap.map.layer[$num].width = [string]$w;
			$cmap.map.layer[$num].height = [string]$h;
			$cmap.map.width = [string]$w;
			$cmap.map.height = [string]$h;
			$c = $true;
		}
	} elseif ($binary.name -match "Configurable_configXmlFile" -and !$x -and !$c) {
		$xmap.Load($binary.fullname);
		if ($xmap.map.width) {
			$x = $true;
		}
	}
}

if ($c -or $x) {
	if ($c) {
		$xml = $cmap;
	} else {
		$xml = $xmap;
	}

	$xml.map.tileset.image.source = $sheetpath;
	$images = Get-Childitem "$destination\exports\images";
	foreach ($image in $images) {
		if ($image.name -match "Art_TileSheet") {
			$xml.map.tileset.image.source = $image.fullname;
			break;
		}
	}
	New-Item $destination -name "map" -ItemType "directory";
	$xml.Save("$destination\map\map.tmx");

	& $tiledpath "$destination\map\map.tmx" "$destination\map\map.png";
	#Remove-Item "$destination\map\map.tmx";
}
