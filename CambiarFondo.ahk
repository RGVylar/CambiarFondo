bLogs := true
if(bLogs)
{
  FileCreateDir, logs
}
FileCreateDir, wallpapers
SetNext(bLogs)

;Si descomentas esto puedes cambiar el fondo de pantalla pulsando escribiendo la cadena cada vez que quieras
;Pero el script se mantendra en ejecucion en segundo plano
;⬇️⬇️⬇️⬇️⬇️⬇️
:R*?:CBF::
  SetNext(bLogs)
Return

SetNext(bLogs)
{
  if(bLogs)
  {
    FormatTime, fecha,, dd-MM-yy
    FormatTime, hora,, HH:mm:ss
    FileAppend, [%hora%]: Se arranca el script.`n, %A_WorkingDir%\logs\%fecha%.txt  
  }
  FileList := []
  Loop, Files,  %A_WorkingDir%\wallpapers\* ;Sustituir por la ruta de la carpeta donde tengas las imagenes con * para que use todas las imagenes o .jpg para coger solo jpg, .png solo para png, etc...
  {
    FileList.Insert(A_LoopFileFullPath)
  }
  num :=  Filelist.MaxIndex()
  if(bLogs)
  {
    FormatTime, hora,, HH:mm:ss
    FileAppend, [%hora%]: Archivos encontrados %num%.`n, %A_WorkingDir%\logs\%fecha%.txt
  }
  Random, rand, 1, num
  background_file := % FileList[rand]
  Needle = abc

  ;IfInString, background_file, desktop.ini
  ;{
  ;  FileRecycle, %background_file%
  ;  SetNext(bLogsbLogs)   
  ;}
  
  IfInString, background_file, dual
  {
    SetWallpaperStyle("Mosaico")
  }
  else
  {
    SetWallpaperStyle("Extendido") ; Sustituir aqui el estilo dependiendo de las imagenes, si son duales mosaico, si son normales Duplicado
  }
  DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, background_file, UInt, 2)
  name_array := StrSplit(background_file, "\", ".")
  name := % name_array[name_array.MaxIndex()]
  if(bLogs)
  {
    FormatTime, hora,, HH:mm:ss
    FileAppend, [%hora%]: Se setea el archivo %rand% : %name%.`n, %A_WorkingDir%\logs\%fecha%.txt
  }
  MsgBox, 4, File %name%, Se ve bien?,
  IfMsgBox Yes
    Return
  else
    FileRecycle, %background_file%
    FileDelete, %background_file%
    if(bLogs)
    {
      FormatTime, hora,, HH:mm:ss
      FileAppend, [%hora%]: Se elimina el archivo %name%.`n, %A_WorkingDir%\logs\%fecha%.txt
    }
    SetNext(bLogs)
}

SetWallpaperStyle(style)
{
  if style=Mosaico ;Para fondos de escritorio duales
  {
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, TileWallpaper, 1
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, WallpaperStyle, 0
  }
 	else if style=Centrado ;Este solo lo he puesto porque podia
  {
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, TileWallpaper, 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, WallpaperStyle, 0
  }
	else if style=Duplicado ;Para poner el mismo fondo en ambos escritorios
  {
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, TileWallpaper, 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, WallpaperStyle, 2
  }
  else if style=Arreglado ;Para poner el mismo fondo en ambos escritorios
  {
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, TileWallpaper, 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, WallpaperStyle, 6
  }
  else if style=Extendido ;Para poner el mismo fondo en ambos escritorios 
  {
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, TileWallpaper, 0
    RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop, WallpaperStyle, 10
  }
}
