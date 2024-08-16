<?php
include('config.php');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get data from POST request
$id = $_POST['id'];
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];

// Prepare and bind SQL statement
$sql = "UPDATE `users` SET `name`=?, `email`=?, `phone`=? WHERE `id`=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssss", $name, $email, $phone, $id);

// Execute the statement and check for success
if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(array("success" => true, "message" => "User updated successfully"));
    } else {
        echo json_encode(array("success" => false, "message" => "No user found with the given ID"));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Error: " . $stmt->error));
}

// Close statement and connection
$stmt->close();
$conn->close();
?>
