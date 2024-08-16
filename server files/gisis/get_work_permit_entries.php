<?php
header('Content-Type: application/json');

// Include the configuration file
include 'config.php';


// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch the work permit entries
$sql = "SELECT `id`, `immigrant_id`, `file_path`, `upload_date` FROM `work_permit_uploads`";
$result = $conn->query($sql);

$entries = array();
if ($result->num_rows > 0) {
    // Output data of each row
    while ($row = $result->fetch_assoc()) {
        $entries[] = $row;
    }
}

// Output the JSON response
echo json_encode($entries);

// Close the connection
$conn->close();
?>
