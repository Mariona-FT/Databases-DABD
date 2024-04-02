<?php
// Including the database connection file
include_once("config.php");

if(isset($_POST['add']) || isset($_POST['update'])) {  
    $username = $_POST['username'];
    $passwd = $_POST['passwd'];
    // Checking empty fields
    if(empty($username) || empty($passwd)) {
        if(empty($username)) {
            echo "<font color='red'>Name field is empty.</font><br/>";
        }
        if(empty($passwd)) {
            echo "<font color='red'>Password field is empty.</font><br/>";
        }
        // Link to the previous page
        echo "<br/><a href='javascript:self.history.back();'><button type=\"button\">Go Back</button></a>";

    } else {
        if(isset($_POST['add'])) {
            // Inserting data to database  
            $stmt = $mysqli->prepare("INSERT INTO users(username, passwd) VALUES(?, ?)");
            $stmt->bind_param("ss", $username, $passwd);
            $stmt->execute();
        }
        if(isset($_POST['update'])) {
            // Updating the table
            $stmt = $mysqli->prepare("UPDATE users SET passwd = ? WHERE username = ?");
            $stmt->bind_param("ss", $passwd, $username);
            $stmt->execute();
        }
        $stmt->close();
        $mysqli->close();
        // Redirecting to the display page (index.php in our case)
        header("Location:index.php");
    }
}

// Getting username from URL
$username = "";
$passwd = "";
if (isset($_GET['username'])) {
    $username = $_GET['username'];
    // Selecting data associated with this particular username
    $stmt = $mysqli->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    if($res = $result->fetch_assoc()) {
        $passwd = $res['passwd'];
    }
    $stmt->close();
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
                <td><input type="text" name="username" value="<?php echo htmlspecialchars($username);?>" <?php if (!empty($username)) echo "readonly";?>></td>
            </tr>
            <tr> 
                <td>Password</td>
                <td><input type="text" name="passwd" value="<?php echo htmlspecialchars($passwd);?>"></td>
            </tr>
            <tr>
                <td><a href="index.php"><button type="button">Cancel</button></a></td>
                <?php
                if (!empty($username))
                    echo "<td><input type=\"submit\" name=\"update\" value=\"Update\"></td>";
                else
                    echo "<td><input type=\"submit\" name=\"add\" value=\"Add\"></td>";
                ?>
            </tr>
        </table>
    </form>
</body>
</html>
