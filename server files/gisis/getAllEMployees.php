<?php
header('Content-Type: application/json');

require_once 'config.php';


// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to get all employees
$sql = "SELECT * FROM users";
$result = $conn->query($sql);

$employees = array();

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        $employees[] = $row;
    }
} else {
    echo json_encode(array("success" => false, "message" => "No Users found."));
    $conn->close();
    exit();
}

$conn->close();

echo json_encode(array("success" => true, "employees" => $employees));
?>
