<?php

  // EXEMPLE D'ÚS DEL SERVIDOR MySQL DES DE PHP
 //  Lab Càlcul EPSEVG + J L Balcazar + J Esteve
//   Març 2004 - Març 2006 - Octubre 2013 - Octubre 2016 - Març 2018

// Afegeix un parell (nom,contrasenya) a la taula d'usuaris

echo("Iniciant...");

// Host, nom del servidor o IP del servidor MySQL.
$sql_host = "localhost";  

// Usuari/contrasenya de MySQL i nom de la base de dades
$sql_user = "-";
$sql_passwd = "-";
$sql_db = "-";


// Intentem connectar amb el servidor SQL i informem
$connexio_bd = new mysqli("$sql_host", "$sql_user", "$sql_passwd", "$sql_db") or
die("<br><font color=red>Error al connectar amb el servidor MySQL...</font><br>");

echo("<br><font color=green>Connectat al servidor MySQL...</font><br>");

$qq = $connexio_bd->prepare("INSERT INTO users VALUES(?,?)");

$qq->bind_param("ss",$_POST['nom'],$_POST['contrasenya']);

$qq->execute();

$connexio_bd->close();

echo "<br>Connexió tancada<br>"

?>
	
