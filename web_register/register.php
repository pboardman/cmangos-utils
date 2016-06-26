<?php
$player_username = $_POST['username'];
$player_password = $_POST['user_password'];

$servername = "db";
$username = "mangos";
$password = "mangos";
$dbname = "realmd";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $sql = "INSERT INTO account (username, sha_pass_hash, gmlevel, last_login)
    VALUE ('$player_username', SHA1(CONCAT(UPPER('$player_username'), ':', UPPER('$player_password'))),0, '2006-04-25')";
    // use exec() because no results are returned
    $conn->exec($sql);
    echo "New account created for $player_username";
    }
catch(PDOException $e)
    {
    echo "An error occured.";
    }

$conn = null;
?>
