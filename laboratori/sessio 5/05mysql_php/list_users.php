
<?php

  // EXEMPLE D'ÚS DEL SERVIDOR MySQL DES DE PHP
 //  Lab Càlcul EPSEVG + J L Balcazar + J Esteve
//   Octubre 2016 - Març 2018

// Llista tot el contingut de la taula d'usuaris

// Host, nom del servidor o IP del servidor MySQL.
$sql_host = "localhost";  

// Usuari/contrasenya de MySQL i nom de la base de dades
$sql_user = "";
$sql_passwd = "";
$sql_db = "";

// Intentem connectar amb el servidor SQL i informem
$connexio_bd = new mysqli("$sql_host", "$sql_user", "$sql_passwd", "$sql_db") or
die("<br><font color=red>Error al connectar amb el servidor MySQL...</font><br>");

echo("<br><font color=green>Connectat al servidor MySQL...</font><br>");

if ( !($qq = $connexio_bd->prepare("SELECT * FROM users") ) ) {
    echo "Ha fallat la preparació: (" . $connexio_bd->errno . ") " . $connexio_bd->error;
}

$qq->execute();

$qq->bind_result($name,$passwd);

while ($qq->fetch()) {
	$srow = "Nom: ".$name."<br>Contrasenya: ".$passwd."<br><br>";
    print $srow;
}

$connexio_bd->close($connexio_bd);

echo "<br>Connexió tancada<br>"

?>

