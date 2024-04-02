<?php
//configuracio inicial
include_once("config.php");

$username = $_GET['username'];
if(empty($username)) {

    echo "<font color='red'>Name field is empty.</font><br/>";
    echo "<br/><a href='javascript:self.history.back();'><button type=\"button\">Go Back</button></a>";

} else {
    // Using prepared statements to delete data
    $stmt = $mysqli->prepare("DELETE FROM users WHERE username=?");
    
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->close();

    $mysqli->close();
    //redirigir to the display page-index.php 
    header("Location:index.php");
}
?>