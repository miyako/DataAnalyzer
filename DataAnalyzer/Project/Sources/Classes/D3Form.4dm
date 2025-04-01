property name : Text
property html : 4D:C1709.File
property WA : Text
property formatter : cs:C1710._JSONFormatter
property window : Integer
property data : Object

Class constructor($name : Text)
	
	If ($name#"")
		This:C1470.name:=$name
		This:C1470.html:=File:C1566(File:C1566("/RESOURCES/HTML/"+$name+".html").platformPath; fk platform path:K87:2)
	End if 
	
Function onLoad() : cs:C1710.D3Form
	
	This:C1470.formatter:=cs:C1710._JSONFormatter.new()
	This:C1470.window:=Current form window:C827
	
	return This:C1470
	
Function onUnload()
	
Function bind($WA : Text) : cs:C1710.D3Form
	
	This:C1470.WA:=$WA
	
	WA SET PREFERENCE:C1041(*; This:C1470.WA; WA enable URL drop:K62:8; True:C214)
	WA SET PREFERENCE:C1041(*; This:C1470.WA; WA enable contextual menu:K62:6; True:C214)
	WA SET PREFERENCE:C1041(*; This:C1470.WA; WA enable Web inspector:K62:7; True:C214)
	
	return This:C1470
	
Function open($data : Object) : cs:C1710.D3Form
	
	Form:C1466.data:=$data
	
	If (This:C1470.html#Null:C1517) && (This:C1470.html.exists) && (Form:C1466.data#Null:C1517)
		WA OPEN URL:C1020(*; This:C1470.WA; This:C1470.html.platformPath)
	End if 
	
	return This:C1470
	
Function chart($data : Object) : cs:C1710.D3Form
	
	$data:=This:C1470.formatter.d3sunburst(This:C1470.data)
	
	var $l; $t; $r; $b; $width; $height; $size : Integer
	OBJECT GET COORDINATES:C663(*; This:C1470.WA; $l; $t; $r; $b)
	
	$width:=$r-$l
	$height:=$b-$t
	$size:=$width>$height ? $height : $width
	
	WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; This:C1470.WA; "chart"; *; $data; $size; This:C1470.window)
	
	return This:C1470