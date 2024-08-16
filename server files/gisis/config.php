<?php
$servername = "localhost";
$username = "jewelspa_gisis";
$password = "Salifuandme1.@";
$dbname = "jewelspa_gisis";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
