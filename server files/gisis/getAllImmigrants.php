<?php
// Include the database connection
require_once 'config.php';

// SQL query to fetch all emigrants
$sql = "SELECT * FROM documents WHERE type = 'Immigrant'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $emigrants = array();
    while ($row = $result->fetch_assoc()) {
        $emigrants[] = $row;
    }
    echo json_encode($emigrants);
} else {
    echo json_encode(array()); // Return an empty array if no emigrants found
}

$conn->close();
?>
