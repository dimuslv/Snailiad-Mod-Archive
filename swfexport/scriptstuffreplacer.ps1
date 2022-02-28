$xml = New-Object XML;
$xml.Load("$destination\exports\swf.xml");
$doabcs = $xml.SelectNodes("swf/tags/item[@type='DoABC2Tag']");
foreach ($doabc in $doabcs) {
	$pnamespaces = $doabc.SelectNodes("abc/constants/constant_namespace/item[@kind='5']")
	$i = 0;
	foreach ($pnamespace in $pnamespaces) {
		if ($pnamespace.name_index -eq "0") {
			$pnamespace.SetAttribute("num", $i)
			$i++;
		}
	}
	$pnslist = @($null) * $i;
	$c = $doabc.abc.constants;
	$cm = $c.constant_multiname;
	$cn = $c.constant_namespace;
	$cs = $c.constant_string;
	$instances = $doabc.SelectNodes("abc/instance_info/item");
	$indlist = @("e") * $instances.count;
	$scopers = @("-") * $instances.count;
	$i = 0;
	foreach ($instance in $instances) {
		$imultiname = $cm.item[$instance.name_index];
		$iname = $cs.item[$imultiname.name_index];
		$indlist[$i] = $iname;
		$stay = 2;
		$traits = $instance.SelectNodes("instance_traits/traits/item")
		while ($stay) {
			foreach ($trait in $traits) {
				$tmultiname = $cm.item[$trait.name_index];
				$tns = $cn.item[$tmultiname.namespace_index];
				if ($tns.GetAttribute("kind") -eq "5" -and $tns.name_index -eq "0") {
					$pnslist[$tns.num] = $iname;
					$stay = 1;
					break;
				}
			}
			if ($stay -eq 2) {
				$traits = $doabc.abc.class_info.item[$i].static_traits.traits.item;
			}
			$stay--;	
		}
		$i++;
	}
	
	$i = 0;
	foreach ($instance in $instances) {
		$imultiname = $cm.item[$instance.name_index];
		$iname = $cs.item[$imultiname.name_index];
		$insn = $cs.item[$cn.item[$imultiname.namespace_index].name_index];
		
		$pcodepath = "$destination\exports\scripts\$($insn -replace "\.", "\")\$iname.pcode";
		if (Test-Path $pcodepath) {
			$txt = (Get-Content $pcodepath) -join "`r`n";
			
			$j = 1;
			while ($txt -match "PrivateNamespace\(null(,`"(\d+)`")?\)") {
				if (!$Matches[1]) {
					$m = "0";
				} else {
					$m = $Matches[2];
				}
				if (!$pnslist[$m]) {
					$pnslist[$m] = "$iname/$j";
					$j++;
				}
				
				$txt = $txt -replace  [RegEx]::Escape($Matches[0]), "PrivateNamespace(null,`"#$($pnslist[$m])`")";
			}
			while ($txt -match "newclass (\d+)") {
				$txt = $txt -replace $Matches[0], "newclass #$($indlist[$Matches[1]])";
			}
			
			$sects = $txt -split "end ; method";
			for ($k = 0; $k -lt $sects.length; $k++) {
				for ($l = 0; $sects[$k] -match "ofs[\da-f]{4}"; $l++) {
					$sects[$k] = $sects[$k] -replace $Matches[0], "ofs$l";
				}
			}
			$txt = $sects -join "end ; method";
			
			if ($txt -match "pushscope\s*?getscopeobject 0\s*?getlex QName\(PackageNamespace\(`"`"\),`"Object`"\)\s*?pushscope") {
				$scopers[$i] = "0";
				$txt = $txt -replace "(?<=pushscope\s*?)getscopeobject 0(?=\s*?getlex QName\(PackageNamespace\(`"`"\),`"Object`"\)\s*?pushscope)", "findpropstrict Multiname(`"$iname`",[PackageNamespace(`"$insn`")])";
			}
			
			Set-Content -path $pcodepath -value $txt -encoding default;
		} else {
			"Doesn't exist: $pcodepath";
			$scopers[$i] = "";
		}
		$i++;
	}
	$rid = "";
	
	$rid += "Class IDs:`n"
	
	for ($i = 0; $i -lt $indlist.length; $i++) {
		$rid += "${i}: $($indlist[$i]) $($scopers[$i])`n";
	}
	$rid += "`nPrivateNamespace IDs:";
	
	for ($i = 0; $i -lt $pnslist.length; $i++) {
		$rid += "`n${i}: $($pnslist[$i])";
	}
	Set-Content -path "$destination\tinkerlogs\script_ID_renames_$($doabc.name).log" -value $rid -encoding default;
}