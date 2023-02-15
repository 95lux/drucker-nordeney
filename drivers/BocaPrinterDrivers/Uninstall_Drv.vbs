'***************************************************************
'
' Uninstall Boca Systems Printer Driver
'
' Version 1.0.0.0
'
'     (c) 2021 Boca Systems Inc.
'
'     Note: The primary purpose of this script
'     is to remove legacy driver installers and
'     files. Newer drivers using dpinst - 
'     will be handled by the installer itself.
'
'***************************************************************
Dim ArgObj
Dim WshShell ' as object
Dim objEnv ' as collection
Dim sOperatingSystem ' as string

Dim gProgFilesPath
Dim gProgFilesX86Path
Dim gSysNativePath
Dim gIsx64Platform
'Dim gPrintingAdminScriptsPath

Const kWin95    = "Windows 95"
Const kWin98    = "Windows 98"
Const kWinNT    = "Windows NT"
Const kWin2K    = "Windows 2000"
Const kWinXP    = "Windows XP"
Const kSrvr2003 = "Windows 2003"
Const kWinVista = "Windows Vista"
Const kWin7     = "Windows 7"
Const kWin8     = "Windows 8"
Const kWin10    = "Windows 10"

Const kInstallerNameLegacy = "Boca Printer Driver"
Const kInstallerName	 = "Boca Printer Driver Installer"
Const kProductNameLegacy = "Boca Printer Driver"
Const kProductName   = "Boca Printer Driver Installer"

Const kboca200Prefix		 = "boca200"
Const kboca300Prefix		 = "boca300"
Const kboca600Prefix		 = "boca600"
Const kpcl300Prefix		 = "pcl300"
Const kLMPrefix		 = "ddkfglmon"
Const kmsvcrPrefix		 = "msvcr120"
Const kLMName		 = "FGL Language Monitor"
Const kDriverName	 = "Boca Systems Printer Driver"
Const kModelName	 = "Boca Systems Printer Driver"

Const kBidiFgl22_42_200HardwareID	 = "boca_systemsfgl42_2bbb2"
Const kBidiFgl22_42_300HardwareID	 = "boca_systemsfgl42_37b73"
Const kPcl22_42_300HardwareID	 = "boca_systemsfgl42_p5233"

Const kBidiFgl24_44_200HardwareID	 = "boca_systems44_200ef65"
Const kBidiFgl24_44_300HardwareID	 = "boca_systems44_3002f34"
Const kBidiFgl24_44_600HardwareID	 = "boca_systems44_6002e24"
Const kPcl24_44_300HardwareID	 = "boca_systems44_pcle0e0"

Const kBidiFgl26_46_200HardwareID	 = "boca_systems46_2002f1c"
Const kBidiFgl26_46_300HardwareID	 = "boca_systems46_300ef4d"
Const kBidiFgl26_46_600HardwareID	 = "boca_systems46_600ee5d"
Const kPcl26_46_300HardwareID	 = "boca_systems46_pcl2099"

Const kBidiFgl_200HardwareID	 = "1284_CID_Boca_FGL_200"
Const kBidiFgl_300HardwareID	 = "1284_CID_Boca_FGL_300"
Const kBidiFgl_600HardwareID	 = "1284_CID_Boca_FGL_600"
Const kPcl_300HardwareID	 = "1284_CID_Boca_PCL_300"

Const kInfFile		 = "boca"
'KHardwareID is PLACEHOLDER FOR DELETEFILES ONLY
Const kHardwareID	 = "boca_HardwareID"

Const HKEY_CLASSES_ROOT   = &H80000000
Const HKEY_CURRENT_USER   = &H80000001
Const HKEY_LOCAL_MACHINE  = &H80000002
Const strComputer = "."

' Get the Arguments object
Set ArgObj = WScript.Arguments

Set WshShell = WScript.CreateObject("WScript.Shell")
Set objEnv = WshShell.Environment("PROCESS")
Set objFileSystem = WScript.CreateObject("Scripting.FileSystemObject")
Set objReg=GetObject("winmgmts:\\" & strComputer & "\root\default:StdRegProv")

' Determine OS
'gPrintingAdminScriptsPath = ""
'sOperatingSystem = GetOS
'If sOperatingSystem = "" Or _
'   sOperatingSystem = kWin95 Or _
'   sOperatingSystem = kWin98 Or _
'   sOperatingSystem = kWinNT Then
'    WScript.Quit ' unsupported
'End If

' Determine architecture
gProgFilesPath = objEnv("PROGRAMFILES")
gProgFilesX86Path = objEnv("PROGRAMFILES(X86)")
If len(gProgFilesX86Path) = 0 Then
	gIsx64Platform = false
Else
	gIsx64Platform = true
End If

'Check to see if we're running under 32bit emulation on x64 systems
gSysNativePath = objEnv("SYSTEMROOT") & "\System32\"
If InStr(1, WScript.FullName, "SysWOW64", vbBinaryCompare) <> 0 Then
    'Running under 32bit emulation - use sysnative
    gSysNativePath = objEnv("SYSTEMROOT") & "\sysnative\"
End If

'Call the uninstaller first, if it exists
'This is for InstallShield (older installers)-NO BOCA BUT DO IT ANYWAY PLACEHOLDER
Call UninstallISEntry(kProductNameLegacy)
Call UninstallISEntry(kProductName)

'This is for DPInst (newer installers)
Call UninstallDriverPackage(kInfFile)

'Delete Printer and Driver -NO BOCA BUT DO IT ANYWAY PLACEHOLDER
'Call DeletePrinterDriver(kModelName)

'Stop spooler
'BOCA Set first Stop window to open on top so LPDSVC question will be visible if needed
WshShell.Run "Net Stop Spooler",1,true
WshShell.Run "Net Start Spooler",7,true
WshShell.Run "Net Stop Spooler",7,true
WScript.Sleep 1000 ' Wait for complete clean up of spooler

'Delete installed files if any still exist - NO BOCA _ PLACEHOLDER
'Call DeleteFiles( kboca200Prefix & " " & kkboca300Prefix & " " & kboca600Prefix & " " & kpcl300Prefix & " " & kLMPrefix & " " & kmsvcrPrefix )

' Remove OEM INF files - BOCA SHOULD NOT HAVE ANY BUT DO IT ANYWAY PLACEHOLDER
Call DeleteOEM_INF(kBidiFgl22_42_200HardwareID)
Call DeleteOEM_INF(kBidiFgl22_42_300HardwareID)
Call DeleteOEM_INF(kPcl22_42_300HardwareID)
Call DeleteOEM_INF(kBidiFgl24_44_200HardwareID)
Call DeleteOEM_INF(kBidiFgl24_44_300HardwareID)
Call DeleteOEM_INF(kBidiFgl24_44_600HardwareID)
Call DeleteOEM_INF(kPcl24_44_300HardwareID)
Call DeleteOEM_INF(kBidiFgl26_46_200HardwareID)
Call DeleteOEM_INF(kBidiFgl26_46_300HardwareID)
Call DeleteOEM_INF(kBidiFgl26_46_600HardwareID)
Call DeleteOEM_INF(kPcl26_46_300HardwareID)
Call DeleteOEM_INF(kBidiFgl_200HardwareID)
Call DeleteOEM_INF(kBidiFgl_300HardwareID)
Call DeleteOEM_INF(kBidiFgl_600HardwareID)
Call DeleteOEM_INF(kPcl_300HardwareID)

' Remove ICC Profiles - NO BOCA ICC FILES-PLACEHOLDER
'Call DeleteICMFile("Boca Systems.icm")

' Remove old InstallShield files (driver only) NO INSTALLSHIELD-PLACEHOLDER
'Call DeleteISFolder("\Boca\Boca Systems")

'Remove possible registry entries. NO LONGER USED-PLACEHOLDER
'Call EnumerateAndDeletePrinterRegEntries(kDriverName)
'Call DeleteLMRegEntry(kLMName)

'Remove possible abandoned InstallShield registry entries. NO INSTALLSHIELD-PLACEHOLDER
'If bDiagToolInstalled = false Then
'	Call DeleteISInstallRegEntry(kInstallerNameLegacy)
'	Call DeleteISUninstallRegEntry(kInstallerNameLegacy)
'	Call DeleteISInstallRegEntry(kInstallerName)
'	Call DeleteISUninstallRegEntry(kInstallerName)
'End If

' Start Spooler
WshShell.Run "Net Start Spooler",7,true
WScript.Sleep 1000 ' Let spooler start up

'MsgBox "All Boca Systems printer drivers have been removed from the system.", vbOKOnly, "Uninstall Complete"

WScript.Quit


'***********************************************
' Subroutine: UninstallDriverPackage
' Purpose:  Calls DPInst to uninstall the driver
'           if an uninstaller exists.
' Input:      Prefix of folder name in DRVSTORE
'***********************************************
Private Sub UninstallDriverPackage( strDriverPrefix )
    On Error Resume Next
    Dim arrSubKeys
    Dim result
    Dim Subkey
    Dim strNewSubKeyPath, strNewSubKeyValue
    Dim strINFFile, strUninstaller
    Dim strPath
    Dim strDPInstInstaller, strUninstallCmd
    
    Const strKeyPath  = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    
    result = objReg.EnumKey( HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys )

    'Enumerate uninstallers to clean up any left over registry keys (if someone deleted the
    'folder in the driver store)
    If( result = 0 And IsArray(arrSubKeys) ) Then
        For Each Subkey in arrSubKeys
            strNewSubKeyPath = strKeyPath & "\" & Subkey
            result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "Publisher", strNewSubKeyValue )
            if( result = 0 And (strNewSubKeyValue = "Boca Systems Inc." Or strNewSubKeyValue = "Boca Systems") ) Then
                result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "UninstallString", strNewSubKeyValue )
                If InStr(1, strNewSubKeyValue, "DRVSTORE\" & strDriverPrefix, vbTextCompare) Or _
                   InStr(1, strNewSubKeyValue, "DriverStore\FileRepository\" & strDriverPrefix & ".inf_", vbTextCompare) Then
					' get the path to the uninstaller and ensure it exists
					strUninstaller = trim((split(strNewSubKeyValue, "/u"))(0))
					strINFFile = trim((split(strNewSubKeyValue, "/u"))(1))
					If objFileSystem.FileExists(strUninstaller) and objFileSystem.FileExists(strINFFile) Then
					    ' modify the uninstaller switches to force silent removal of the package
					    strUninstallCmd = strUninstaller & " /s /u " & strINFFile
						' call the uninstaller for the printer - this displays a pop-up unless /s is specified
						WshShell.Run strUninstallCmd,1,true
					Else
						'If the files are missing from the driver store,
						'the registry key will be left behind, as will the
						'entry in add/remove programs - delete the registry key
						DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, strNewSubKeyPath
                    End If
                End If
            End If
        Next
    End If
    
    'Stranded driver packages are most likely to be found on
    'Windows 7 because the old version of DPInst does not
    'create an uninstaller. Try to uninstall these, then
    'delete the stranded driver packages for this printer
    If gIsx64Platform = true Then
		strPath = objEnv("SYSTEMROOT") & gSysNativePath & "DriverStore\FileRepository\"
    Else
		strPath = objEnv("SYSTEMROOT") & gSysNativePath & "DRVSTORE\"
	End If

    Set drvstoreFolder = objFileSystem.GetFolder(strPath)
    Set subFolders = drvstoreFolder.SubFolders

    For Each drvPkgFolder in subFolders
        If InStr(1, drvPkgFolder, strDriverPrefix, vbTextCompare) Then
			'First, try to uninstall directly, if the installer is available in the current
			'folder. This should handle any installed packages that don't have uninstallers.
			If gIsx64Platform = true Then
				strDPInstInstaller = "dpinstx64.exe"
			Else
				strDPInstInstaller = "dpinstx86.exe"
			End If
			If objFileSystem.FileExists(strDPInstInstaller) Then
				strUninstallCmd = strDPInstInstaller & " /s /u " & strDriverPrefix & ".inf"
				WshShell.Run strUninstallCmd,1,true
			End If
            'delete the DIFx DriverStore registry entry
            DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Windows\CurrentVersion\DIFx\DriverStore\" & drvPkgFolder.Name
            objFileSystem.DeleteFolder drvPkgFolder, true 
        End If
    Next

    On Error Goto 0
End Sub

'***********************************************
' Subroutine: EnumerateAndDeletePrinterRegEntries
' Purpose:  Enumerates registry and deletes
'           printer entries
' Input:    Name of Driver
'***********************************************
'Private Sub EnumerateAndDeletePrinterRegEntries( strDriverName )
'    On Error Resume Next
'    Dim arrKeyValues, arrSubKeys
'    Dim result
'    Dim Subkey, KeyValue
'    Dim strNewSubKeyPath, strNewSubKeyValue
'    Dim strPath
'    
'    Const strKeyPath  = "SYSTEM\CurrentControlSet\Control\Print\Printers"
'    
'    result = objReg.EnumKey( HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys )
'    
'    'Enumerate uninstallers
'    If( result = 0 And IsArray(arrSubKeys) ) Then
'        For Each Subkey in arrSubKeys
'            strNewSubKeyPath = strKeyPath & "\" & Subkey
'            result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "Printer Driver", strNewSubKeyValue )
'            If( result = 0 And strNewSubKeyValue = strDriverName ) Then
'				'Enumerate values
'				result = objReg.EnumValues( HKEY_LOCAL_MACHINE, strNewSubKeyPath, arrKeyValues )
'				If(IsArray(arrKeyValues)) Then
'				    DeletePrinterRegEntry( Subkey )
'				End If
'				result = objReg.DeleteKey( HKEY_LOCAL_MACHINE, strNewSubKeyPath )
'				
'				Exit For
'            End If
'        Next
'    End If
'        
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeletePrinterRegEntry
' Purpose:  Delete Printer Registry Entry
' Input:    Name of Driver
'***********************************************
'Private Sub DeletePrinterRegEntry( strDriverName )
'    On Error Resume Next
'    DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Printers\" & strDriverName
'    
'    If gIsx64Platform = true Then
'		DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Environments\Windows x64\Drivers\Version-3\" & strDriverName
'	Else
'		DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Environments\Windows NT x86\Drivers\Version-3\" & strDriverName
'	End If

'    DeleteRegKeysRecursively HKEY_CURRENT_USER, "Printers\DevModePerUser\" & strDriverName
'    DeleteRegKeysRecursively HKEY_CURRENT_USER, "Printers\DevModes2\" & strDriverName
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeletePPRRegEntry
' Purpose:  Delete Printer Processor Registry Entry
' Input:      Name of Driver
'***********************************************
'Private Sub DeletePPRRegEntry ( strPPRName )
'    On Error Resume Next
'    If gIsx64Platform = true Then
'		DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Environments\Windows x64\Print Processors\" &  strPPRName
'	Else
'		DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Environments\Windows NT x86\Print Processors\" &  strPPRName
'	End If
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeleteLMRegEntry
' Purpose:  Delete Printer Processor Registry Entry
' Input:    Name of Driver
'***********************************************
'Private Sub DeleteLMRegEntry ( strLMName )
'    On Error Resume Next
'    DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\Print\Monitors\" & strLMName
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeleteEKRegEntry
' Purpose:  Delete Driver Registry Entry
' Input:    EK Driver Name
'***********************************************
'Private Sub DeleteEKRegEntry ( strEKName )
'    On Error Resume Next
'    DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, "SOFTWARE\BOCA\" & strEKName
'    On Error Goto 0
'End Sub



'***********************************************
' Subroutine: UninstallISEntry
' Purpose:  Calls InstallShield Uninstall script
' Input:      Name of Driver
'***********************************************
Private Sub UninstallISEntry( strDisplayName )
    On Error Resume Next
    Dim arrKeyValues, arrSubKeys
    Dim result
    Dim Subkey, KeyValue
    Dim strKeyPath, strNewSubKeyPath, strNewSubKeyValue
    Dim strPath
    
    If gIsx64Platform = true Then
		'InstallShield is 32-bit - the 32-bit driver cannot be installed
		'but the installer may have been run and left stuff behind
		strKeyPath  = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    Else
		strKeyPath  = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
	End If
    
    result = objReg.EnumKey( HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys )
    
    'Enumerate uninstallers
    If( result = 0 And IsArray(arrSubKeys) ) Then
        For Each Subkey in arrSubKeys
            strNewSubKeyPath = strKeyPath & "\" & Subkey
            result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "DisplayName", strNewSubKeyValue )
            if( result = 0 And strNewSubKeyValue = strDisplayName ) Then
                result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "UninstallString", strNewSubKeyValue )
                If InStr(1, strNewSubKeyValue, "MsiExec.exe /I", vbTextCompare) Then
					' modify the uninstaller switches to force silent removal of the package
					strUninstaller = trim((split(strNewSubKeyValue, "/I"))(0)) & " /QN /X " & trim((split(strNewSubKeyValue, "/I"))(1))

					' call the uninstaller for the printer
					WshShell.Run strUninstaller,1,true
                End If
            End If
        Next
    End If
        
    On Error Goto 0
End Sub

'***********************************************
' Subroutine: DeleteISInstallRegEntry
' Purpose:  Delete InstallShield Installation Registry Entry
' Input:      Name of Driver
'***********************************************
'Private Sub DeleteISInstallRegEntry( strProductName )
'    On Error Resume Next
'    Dim arrKeyValues, arrSubKeys
'    Dim result
'    Dim ChildKey, Subkey, KeyValue
'    Dim strNewSubKeyPath, strNewSubKeyValue
'    Dim strPath
'    
'    Const strKeyPath  = "Installer\Products"
'    
'    result = objReg.EnumKey( HKEY_CLASSES_ROOT, strKeyPath, arrSubKeys )
'    
'    'Enumerate installers
'    If( result = 0 And IsArray(arrSubKeys) ) Then
'        For Each Subkey in arrSubKeys
'            strNewSubKeyPath = strKeyPath & "\" & Subkey
'            result = objReg.GetStringValue( HKEY_CLASSES_ROOT, strNewSubKeyPath, "ProductName", strNewSubKeyValue )
'            If( result = 0 And strNewSubKeyValue = strProductName ) Then
'				DeleteRegKeysRecursively HKEY_CLASSES_ROOT, strNewSubKeyPath
'            End If
'        Next
'    End If
'    
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeleteISUninstallRegEntry
' Purpose:  Delete InstallShield Uninstall Registry Entry
' Input:      Name of Driver
'***********************************************
'Private Sub DeleteISUninstallRegEntry( strDisplayName )
'    On Error Resume Next
'    Dim arrKeyValues, arrSubKeys
'    Dim result
'    Dim Subkey, KeyValue
'    Dim strNewSubKeyPath, strNewSubKeyValue
'    Dim strPath
'    
'    Const strKeyPath  = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
'    
'    result = objReg.EnumKey( HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys )
'    
'    'Enumerate uninstallers
'    If( result = 0 And IsArray(arrSubKeys) ) Then
'        For Each Subkey in arrSubKeys
'            strNewSubKeyPath = strKeyPath & "\" & Subkey
'            result = objReg.GetStringValue( HKEY_LOCAL_MACHINE, strNewSubKeyPath, "DisplayName", strNewSubKeyValue )
'            If( result = 0 And strNewSubKeyValue = strDisplayName ) Then
'				DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, strNewSubKeyPath				
'				Exit For
'            End If
'        Next
'    End If
'        
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: TerminateProcess
' Purpose:  Terminates a process
' Input:      Name of process
'***********************************************
'Private Sub ProcessTerminate( strProcess )
'    Dim colProcessList, objProcess

'    On Error Resume Next   
'    Set colProcessList = GetObject("Winmgmts:").ExecQuery _
'        ("Select * from Win32_Process Where Name ='" & strProcess & "'")
'    For Each objProcess in colProcessList
'        objProcess.Terminate( )
'    Next

'    Set colProcessList = Nothing
'    On Error Goto 0  
'  
'End Sub


'***********************************************
' Subroutine: DeleteOEM_INF
' Purpose:  Delete OEM#.INF
' Input:    String to find in OEM#.inf
'***********************************************
Private Sub DeleteOEM_INF( strDeleteOn )
    On Error Resume Next
    Dim i
    Dim bCallPnPUtil
    Dim objFile
    Dim strSystem32Folder
    Dim strText
    Dim strFile
    Dim strFilePNF

    bCallPnPUtil = false
    
    If objFileSystem.FileExists( gSysNativePath & "pnputil.exe") Then
		bCallPnPUtil = true
	End If
    
'    If sOperatingSystem = kWinVista Or sOperatingSystem = kWin7 Then
'        'Check to see if we're running under 32bit emulation
'         If objFileSystem.FileExists(objEnv("SYSTEMROOT") & "\System32\" & "pnputil.exe") Then
'             'Running under 32bit emulation - use system32
'             bCallPnPUtil = true
'         Elseif objFileSystem.FileExists(objEnv("SYSTEMROOT") & "\sysnative\" & "pnputil.exe") Then
'             'Running natively on 64bit - use sysnative
'             strSystem32Folder = "\sysnative\"
'             bCallPnPUtil = true
'         End If
'    End If

    For i = 0 to 999 Step 1
        strFile = objEnv("SYSTEMROOT") & "\INF\OEM" & i & ".INF"
        strFilePNF = objEnv("SYSTEMROOT") & "\INF\OEM" & i & ".PNF"
        If objFileSystem.FileExists(strFile) then 	
            On Error Resume Next
            Set objFile = objFileSystem.OpenTextFile(strFile, 1)
            strText = objFile.ReadAll
            objFile.Close
            If InStr(1, strText, strDeleteOn, 1) <> 0 Then
				If bCallPnPUtil = true Then		
                    strCommand = gSysNativePath & "pnputil.exe -f -d OEM" & i & ".INF"
                    
                    If 0 <> WshShell.Run( strCommand,7,true ) Then
						'pnputil failed to remove the inf file - forcibly delete it
						objFileSystem.DeleteFile strFile, true
						objFileSystem.DeleteFile strFilePNF, true
					End If
				Else
					objFileSystem.DeleteFile strFile, true
					objFileSystem.DeleteFile strFilePNF, true
                End If
            End if
        End if
    Next
End Sub

'***********************************************
' Subroutine: DeleteICMFile
' Purpose:  Deletes icm file
' Input:    icm file name (*.icm)
'***********************************************
'Private Sub DeleteICMFile ( strFilename )
'   On Error Resume Next 
'    
'    Dim strPath
'    strPath = gSysNativePath & "spool\drivers\color\" & strFilename
'    objFileSystem.DeleteFile(strPath), true
'   
'   On Error Goto 0

'End Sub

'***********************************************
' Subroutine: DeleteFiles
' Purpose:  Deletes driver files
' Input:    List of prefixes separated by spaces (e.g. "ek7000 ek7010")
'***********************************************
'Private Sub DeleteFiles ( strPrefixesList )
'   On Error Resume Next 

'   Dim Directories_list
'   Dim Files_list

'   Dim prefixes_array
'   Dim prefix
'   Dim directories_array
'   Dim directory
'   Dim files_array
'   Dim strPath
'                      
'   Directories_list = "w32x86 x64"
'   Files_list       = ".bud .gpd .ini _gdi.dll _gpd.dll _preview.bmp " & _
'                      "_rc.gpd _ui.dll"

'   prefixes_array    = Split(strPrefixesList, " ")
'   directories_array = Split(Directories_list, " ")
'   files_array       = Split(Files_list, " ")

'   For Each prefix in prefixes_array
'       For Each directory in directories_array
'           For Each file in files_array
'               strPath = gSysNativePath & "spool\drivers\" & directory & "\3\" & prefix & file

'               On Error Resume Next
'               objFileSystem.DeleteFile(strPath), true
'               On Error Goto 0
'           Next
'     Next

''     strPath = gSysNativePath & prefix & "LM.dll"

'     On Error Resume Next
'     objFileSystem.DeleteFile(strPath), true
'     On Error Goto 0

'   Next

'    On Error Resume Next
'    
'    If gIsx64Platform = true Then
'		objFileSystem.DeleteFolder(gSysNativePath & "spool\drivers\x64\" & kHardwareID)
'    Else
'		objFileSystem.DeleteFolder(objEnv("SYSTEMROOT") & "\system32\spool\drivers\w32x86\" & kHardwareID)
'    End If

'    On Error Goto 0

'End Sub

'***********************************************
' Subroutine: DeleteISFolder
' Purpose:  Removes old InstallShield folder and registry entries on 32-bit OS
' Input:    Folder path under Program Files  
'***********************************************
'Private Sub DeleteISFolder(strFolder)

'    On Error Resume Next 
'    
'    Dim strPath

'	If gIsx64Platform = true Then
'		strPath = gProgFilesX86Path & strFolder   
'	Else
'		strPath = gProgFilesPath & strFolder  
'	End If
'    objFileSystem.DeleteFolder(strPath), true
'    
'    On Error Goto 0

'End Sub


'***********************************************
' Subroutine: DeletePrinterDriver
' Purpose:  Run Print VBS scripts to delete driver and printer
' Input:    Printer/Driver Name  
'***********************************************
'Private Sub DeletePrinterDriver( strDrvrModelName  )

'    On Error Resume Next 

'	Dim sCommand, sPath
'	
'	sPath = GetPASPath( GetOS )
'  
'    On Error Resume Next
'    
'    if Len(sPath) > 0 Then
'		sCommand = "cscript " & sPath & "prnmngr.vbs -d -p """ & strDrvrModelName & """"
'		WshShell.Run sCommand,7,true

'		sCommand = "cscript " & sPath & "prndrvr.vbs -d -m """ & strDrvrModelName & """ -v 3 -e ""Windows NT x86"""
'		WshShell.Run sCommand,7,true
'	    
'		sCommand = "cscript " & sPath & "prndrvr.vbs -d -m """ & strDrvrModelName & """ -v 3 -e ""Windows x64"""
'		WshShell.Run sCommand,7,true
'    End If
'    
'    On Error Goto 0

'End Sub


'***********************************************
' Function: GetOS
' Purpose:  Returns string describing OS level
' Input:    none
' Note:		The OS string returned indicates the
'			OS level - so Windows Server 2008 R2
'           will be returned as "Windows 7"
'***********************************************
'Private Function GetOS()

'    On Error Resume Next
'    
'    GetOS = ""
'    
'    Dim oShell 
'    Dim oShellExec, oStdOutputText, sText, iElement, aOS

'    Set oShell = CreateObject("Wscript.Shell") 
'    Set oShellExec = oShell.Exec("%comspec% /c ver") 
'    Set oStdOutputText = oShellExec.StdOut 
'    
'    aOS = Array(kWin95, kWin98, kWinNT, kWin2K, kWinXP, "Microsoft Windows [Version 5.2", "Microsoft Windows [Version 6.0", "Microsoft Windows [Version 6.1", "Microsoft Windows [Version 6.2") 
'   
'    Do While Not oStdOutputText.AtEndOfStream 
'        sText = oStdOutputText.ReadLine 
'    
'        If sText <> "" Then
'            For iElement = LBound(aOS) To UBound(aOS) 
'                If InStr(sText, aOS(iElement)) <> 0 Then 
'                    If aOS(iElement) = "Microsoft Windows [Version 10.0" Then
'                        GetOS = kWin10
'                    ElseIf aOS(iElement) = "Microsoft Windows [Version 6.3" Then
'					    GetOS = kWin8
'                    ElseIf aOS(iElement) = "Microsoft Windows [Version 6.2" Then
'					    GetOS = kWin8
'                    ElseIf aOS(iElement) = "Microsoft Windows [Version 6.1" Then
'					    GetOS = kWin7
'                    ElseIf aOS(iElement) = "Microsoft Windows [Version 6.0" Then 
'                        GetOS = kWinVista
'                    ElseIf aOS(iElement) = "Microsoft Windows [Version 5.2" Then 
'                        GetOS = kSrvr2003 
'                    Else 
'                        GetOS = aOS(iElement)
'                    End If 
'                    Exit Do
'                 End If 
'             Next 
'         End If
'    Loop 
'    
'    On Error Goto 0

'End  Function


'***********************************************
' Function: GetPASPath
' Purpose:  Returns the path to Printing_Admin_Scripts
' Input:    The OS string
' Note:		The returned path must include the locale ***
'***********************************************
'Private Function GetPASPath( strOS )

'    On Error Resume Next
'    
'    GetPASPath = ""
'    
'    If gPrintingAdminScriptsPath = "" Then
'        If Len(strOS) > 0 Then 
'            If strOS = kWin10 Or _
'               strOS = kWin8 Or _
'               strOS = kWin7 Or _
'               strOS = kWinVista Or _
'               strOS = kSrvr2003 Then
'                GetPASPath = FindLocalizedPath
'            Else
'                GetPASPath = gSysNativePath 
'            End If 
'        End If

'        gPrintingAdminScriptsPath = GetPASPath
'    Else
'        GetPASPath = gPrintingAdminScriptsPath
'    End If
'    
'    On Error Goto 0

'End  Function

'***********************************************
' Function: FindLocalizedPath
' Purpose:  Parses the Printing_Admin_Scripts folder for
'           the localized subfolder name.
'           Returns the path to Printing_Admin_Scripts
' Input:    The OS string
' Note:		The returned path must include the locale ***
'***********************************************
'Private Function FindLocalizedPath()

'    On Error Resume Next
'    
'    Dim folder
'    Dim file
'    FindLocalizedPath = ""
'    BasePath = gSysNativePath & "Printing_Admin_Scripts\"

'    Set dirList = objFileSystem.GetFolder(BasePath)
'    Set subFolders = dirList.SubFolders

'    For Each folder in SubFolders
'        file = folder & "\prnmngr.vbs"
'        If objFileSystem.FileExists(file) Then
'            FindLocalizedPath = folder & "\"
'            Exit For
'        End if
'    Next
'    
'    On Error Goto 0

'End  Function


'***********************************************
' Subroutine: DeleteUSBPrinterRegEntry
' Purpose:  Delete USBPrinter Registry Entry
' Input:    Symbolic Name
'***********************************************
'Private Sub DeleteUSBPrinterRegEntry( strSymbNameName )
'    On Error Resume Next
'    Dim strPath
'    
'    strPath  = "SYSTEM\CurrentControlSet\Enum\USBPRINT\" & strSymbNameName
'    
'    DeleteRegKeysRecursively HKEY_LOCAL_MACHINE, strPath
'        
'    On Error Goto 0
'End Sub

'***********************************************
' Subroutine: DeleteRegKeysRecursively
' Purpose:  Deletes a registry entry and all of
'           its child nodes. This will fail if
'           the calling process does not have
'           sufficient access rights.
' Input:    Fully qualified key name
'***********************************************
'Private Sub DeleteRegKeysRecursively( hive, keyName )
'    On Error Resume Next
'    
'    Dim result
'    Dim arrSubKeys, subKey
'    
'    result = objReg.EnumKey( hive, keyname, arrSubKeys )
'    
'    If( result = 0 And IsArray(arrSubKeys) ) Then
'		For Each subkey in arrSubKeys
'			If Err.number <> 0 Then
'				Err.Clear
'				Exit Sub
'			End If
'			DeleteRegKeysRecursively hive, keyName & "\" & subKey
'		Next
'    End If
'    
'    objReg.DeleteKey hive, keyName
'    
'End Sub
