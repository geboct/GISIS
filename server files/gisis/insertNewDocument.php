<?php
include 'config.php';

// Get POST data
$type = $_POST['type'];
$passportNumber = $_POST['passportNumber'];
$name = $_POST['name'];
$yellowFeverCard = $_POST['yellowFeverCard'];
$visa = $_POST['visa'];

// Prepare SQL statement to insert into documents table
$sql = "INSERT INTO documents (type, passportNumber, name, yellowFeverCard, visa)
        VALUES ('$type', '$passportNumber', '$name', '$yellowFeverCard', '$visa')";

// Execute SQL query
if ($conn->query($sql) === TRUE) {
    echo json_encode(array('success' => true, 'message' => 'New ' . $type . ' registered successfully'));
} else {
    echo json_encode(array('success' => false, 'message' => 'Error: ' . $conn->error));
}

$conn->close();
?>
