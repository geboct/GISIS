<?php
header('Content-Type: application/json');

// Include the configuration file
include 'config.php';


// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch the citizenship form entries
$sql = "SELECT `id`, `full_name`, `date_of_birth`, `place_of_birth`, `gender`, `marital_status`, `nationality`, `passport_number`, `date_of_issue`, `expiry_date`, `place_of_issue`, `occupation`, `contact_person_name`, `contact_person_phone`, `passport_photo_path`, `nationality_id_path`, `created_at` FROM `citizenship_forms`";
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
