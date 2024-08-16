<?php
// submit_multiple_visa_entry.php

// Include the config file
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $application_number = $_POST['application_number'];
    $type_of_visa = $_POST['type_of_visa'];
    $full_name = $_POST['full_name'];
    $gender = $_POST['gender'];
    $age = $_POST['age'];
    $nationality = $_POST['nationality'];
    $occupation = $_POST['occupation'];
    $country_of_birth = $_POST['country_of_birth'];
    $country_of_residence = $_POST['country_of_residence'];
    $email = $_POST['email'];
    $passport_number = $_POST['passport_number'];
    $place_of_issue = $_POST['place_of_issue'];
    $date_of_issue = $_POST['date_of_issue'];
    $expiry_date = $_POST['expiry_date'];
    $reason_for_entry = $_POST['reason_for_entry'];
    $proposed_date_of_entry = $_POST['proposed_date_of_entry'];
    $duration_of_stay_in_days = $_POST['duration_of_stay'];

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO multiple_visa_entries (application_number, type_of_visa, full_name, gender, age, nationality, occupation, country_of_birth, country_of_residence, email, passport_number, place_of_issue, date_of_issue, expiry_date, reason_for_entry, proposed_date_of_entry, duration_of_stay_in_days) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssisssssssssssi", $application_number, $type_of_visa, $full_name, $gender, $age, $nationality, $occupation, $country_of_birth, $country_of_residence, $email, $passport_number, $place_of_issue, $date_of_issue, $expiry_date, $reason_for_entry, $proposed_date_of_entry, $duration_of_stay_in_days);

    // Execute the query
    if ($stmt->execute()) {
        echo "Form submitted successfully.";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
} else {
    echo "Invalid request method.";
}
?>
