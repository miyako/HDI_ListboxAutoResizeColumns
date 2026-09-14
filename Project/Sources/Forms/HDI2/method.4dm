
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		var $json : Collection
		
		If (Get database localization:C1009(Current localization:K5:22)="ja")
			$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLES-ja.json").getText(); Is collection:K8:32)
		Else 
			$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLES-en.json").getText(); Is collection:K8:32)
		End if 
		
		Var1:=$json.first().Text
		
		ARRAY TEXT:C222(Column1; 5)
		ARRAY TEXT:C222(Column2; 5)
		ARRAY TEXT:C222(Column3; 5)
		ARRAY TEXT:C222(Column4; 5)
		ARRAY TEXT:C222(Column5; 5)
		
End case 

