<?php
// including the database connection file
include_once("config.php");

if(isset($_POST['add']) or isset($_POST['update'])) {	
	$username = $_POST['username'];
	$passwd = $_POST['passwd'];
	// checking empty fields
	if(empty($username) or empty($passwd)) {
		if(empty($username)) {
			echo "<font color='red'>Name field is empty.</font><br/>";
		}
		if(empty($passwd)) {
			echo "<font color='red'>Password field is empty.</font><br/>";
		}
		//link to the previous page
		echo "<br/><a href='javascript:self.history.back();'><button type=\"button\">Go Back</button></a>";

	} else {
        if(isset($_POST['add'])) {
            //insert data to database	
            $result = mysqli_query($mysqli, "INSERT INTO users(username,passwd) VALUES('$username','$passwd')");
        }
        if(isset($_POST['update'])) {
    		//updating the table
    		$result = mysqli_query($mysqli, "UPDATE users SET passwd='$passwd' WHERE username='$username'");
        }
		$mysqli->close();
        //redirecting to the display page (index.php in our case)
        header("Location:index.php");

	}
}

//getting username from url
$username = $_GET['username'];
if (!empty($username)) {
    //selecting data associated with this particular username
    $result = mysqli_query($mysqli, "SELECT * FROM users WHERE username='$username'");

    while($res = mysqli_fetch_array($result)) {
        $passwd = $res['passwd'];
    }
}

$mysqli->close();
?>

<html>
<head>
	<title>Add/Edit user</title>
</head>

<body>
	<form name="form1" method="post" action="add_edit.php">
		<table border="0">
			<tr> 
				<td>Name</td>
				<td><input type="text" name="username" value="<?php echo $username;?>" <?php if ($username) echo "readonly";?>></td>
			</tr>
			<tr> 
				<td>Password</td>
				<td><input type="text" name="passwd" value="<?php echo $passwd;?>"></td>
			</tr>
			<tr>
                <td><a href="index.php"><button type="button">Cancel</button></a></td>
                <?php
                if ($username)
                    echo "<td><input type=\"submit\" name=\"update\" value=\"Update\"></td>";
                else
                    echo "<td><input type=\"submit\" name=\"add\" value=\"Add\"></td>";
                ?>
			</tr>
		</table>
	</form>
</body>
</html>
