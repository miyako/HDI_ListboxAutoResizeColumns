Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		$vers:=Application version:C493
		
		If ($vers<"1600")  //1550 means 13R5   1501 means 15.1
			
			<>Quit:=True:C214
			OBJECT SET TITLE:C194(*; "BtnDemo"; "Quit 4D")
			OBJECT SET VISIBLE:C603(*; "TxtSorry@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
			
		Else 
			
			<>Quit:=False:C215
			
		End if 
		
End case 
