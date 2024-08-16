<?php
include('config.php');

// Ensure that all required POST parameters are provided
if (!isset($_POST['name'], $_POST['email'], $_POST['phone'])) {
    echo json_encode(array("success" => false, "message" => "Missing required fields"));
    exit;
}

// Get data from POST request
$fullName = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = '1234'; // Default password (should be hashed)

// Hash the password before storing it in the database
$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

// Prepare and bind SQL statement
$stmt = $conn->prepare("INSERT INTO `users`(`name`, `email`, `password`, `phone`) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $fullName, $email, $hashedPassword, $phone);

// Execute the statement
if ($stmt->execute()) {
    echo json_encode(array("success" => true, "message" => "Employee added successfully"));
} else {
    echo json_encode(array("success" => false, "message" => "Error: " . $stmt->error));
}

// Close statement and connection
$stmt->close();
$conn->close();
?>
