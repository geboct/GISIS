<?php
// Include the database configuration file
include 'config.php';

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect data from the POST request
    $fullName = $_POST['fullName'];
    $dateOfBirth = $_POST['dateOfBirth'];
    $nationality = $_POST['nationality'];
    $phoneNumber = $_POST['phoneNumber'];
    $placeOfBirth = $_POST['placeOfBirth'];
    $passportNumber = $_POST['passportNumber'];
    $dateOfIssue = $_POST['dateOfIssue'];
    $expiryDate = $_POST['expiryDate'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Hash the password for security
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Prepare and bind the SQL statement to prevent SQL injection
    $stmt = $conn->prepare("INSERT INTO immigrants (fullName, dateOfBirth, nationality, phoneNumber, placeOfBirth, passportNumber, dateOfIssue, expiryDate, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssssssss", $fullName, $dateOfBirth, $nationality, $phoneNumber, $placeOfBirth, $passportNumber, $dateOfIssue, $expiryDate, $email, $hashedPassword);

    // Execute the query
    if ($stmt->execute()) {
        // If the signup is successful, return a success message
        echo json_encode(["status" => "success", "message" => "Signup successful!"]);
    } else {
        // If there's an error, return an error message
        echo json_encode(["status" => "error", "message" => "Signup failed. Please try again later."]);
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
} else {
    // If the request method is not POST, return an error message
    echo json_encode(["status" => "error", "message" => "Invalid request method."]);
}
?>
