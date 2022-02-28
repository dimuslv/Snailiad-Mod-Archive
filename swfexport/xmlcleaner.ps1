$xml=New-Object XML;

$xml.Load("$destination\exports\swf.xml");

$nodes = $xml.SelectNodes("/swf/tags/item");
foreach($node in $nodes) {
    
    if ($node.GetAttribute("soundData")) {
    	$node.SetAttribute("soundData", "");
    }
    if ($node.GetAttribute("binaryData")) {
    	$node.SetAttribute("binaryData", "");
    }
    if ($node.GetAttribute("zlibBitmapData")) {
    	$node.SetAttribute("zlibBitmapData", "");
    }
    if ($node.GetAttribute("type") -eq "DoABC2Tag") {
    	$node.InnerText = "";
    }
    
}

$xml.Save("$destination\exports\swf.xml");