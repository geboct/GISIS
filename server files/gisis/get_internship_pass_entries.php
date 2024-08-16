<?php
header('Content-Type: application/json');

// Include the configuration file
include 'config.php';

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch the student pass form entries
$sql = "SELECT `id`, `application_number`, `student_name`, `gender`, `email`, `nationality`, `institution_name`, `educational_duration`, `admission_number`, `student_declaration`, `academic_qualification`, `submission_date` FROM `student_pass_forms`";
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
