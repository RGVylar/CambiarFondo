SetNext()

;Si descomentas esto puedes cambiar el fondo de pantalla pulsando ctrl+F1 cada vez que quieras
;Pero el script se mantendra en ejecucion en segundo plano
;⬇️⬇️⬇️⬇️⬇️⬇️
;^F1::
;  SetNext()
;Return

SetNext()
{
  FileList := []
  Loop, Files, C:\RUTA\* ;Sustituir por la ruta de la carpeta donde tengas las imagenes con * para que use todas las imagenes o .jpg para coger solo jpg, .png solo para png, etc...
  {
    FileList.Insert(A_LoopFileFullPath)
  }
  num :=  Filelist.MaxIndex()
  Random, rand, 1, num
  background_file := % FileList[rand]
  Needle = abc

  ;IfInString, background_file, desktop.ini
  ;{
  ;  FileRecycle, %background_file%
  ;  SetNext()   
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
  MsgBox, 4, SUBE ESO AL TAG seleccionado %name%, Se ve bien?,
  IfMsgBox Yes
    Return
  else
    FileRecycle, %background_file%
    SetNext()
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
