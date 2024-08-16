<?php
require_once('config.php');

// Assuming you're receiving the passport number as a POST parameter
$passportNumber = $_POST['passportNumber'];

// SQL query to delete a document from the database
$sql = "DELETE FROM documents WHERE passportNumber = '$passportNumber'";

if ($conn->query($sql) === TRUE) {
    $response['success'] = true;
    $response['message'] = "Document with passport number $passportNumber deleted successfully";
} else {
    $response['success'] = false;
    $response['message'] = "Error deleting document: " . $conn->error;
}

// Sending JSON response back to the Flutter app
header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>
