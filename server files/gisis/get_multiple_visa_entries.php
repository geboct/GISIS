<?php
header('Content-Type: application/json');

// Include the configuration file
include 'config.php';

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch the multiple journey visa entries
$sql = "SELECT `id`, `application_number`, `type_of_visa`, `full_name`, `gender`, `age`, `nationality`, `occupation`, `country_of_birth`, `country_of_residence`, `email`, `passport_number`, `place_of_issue`, `date_of_issue`, `expiry_date`, `reason_for_entry`, `proposed_date_of_entry`, `duration_of_stay_in_days`, `created_at` FROM `multiple_visa_entries`";
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
