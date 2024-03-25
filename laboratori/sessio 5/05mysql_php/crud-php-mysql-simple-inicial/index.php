<html>
<head>	
	<title>Users list</title>
</head>

<body>
<h2>Users List</h2><a href="add_edit.php"><button type="button">Add user</button></a><br/><br/>

	<table border=0>
	<tr bgcolor='#CCCCCC'>
		<td>Name</td>
		<td>Password</td>
        <td></td>
	</tr>
	<?php
    //including the database connection file
    include_once("config.php");
    $result = mysqli_query($mysqli, "SELECT * FROM users");
	while($res = mysqli_fetch_array($result)) {
		echo "<tr>";
		echo "<td>".$res['username']."</td>";
		echo "<td>".$res['passwd']."</td>";
        echo "<td>
        <a href=\"add_edit.php?username=$res[username]\"><img src=\"b_edit.png\"/></a>
        <a href=\"delete.php?username=$res[username]\" onClick=\"return confirm('Are you sure you want to delete?')\"><img src=\"b_drop.png\"/></a>
        </td></tr>";	
	}
    $mysqli->close();
	?>
	</table>
</body>
</html>
