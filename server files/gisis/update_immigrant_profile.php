<?php
include 'config.php'; // Make sure this file contains your DB connection details

$data = json_decode(file_get_contents('php://input'), true);

$id = $data['id'];
$fullName = $data['fullName'];
$email = $data['email'];
$phoneNumber = $data['phoneNumber'];
$nationality = $data['nationality'];
$placeOfBirth = $data['placeOfBirth'];

$sql = "UPDATE immigrants SET fullName = ?, email = ?, phoneNumber = ?, nationality = ?, placeOfBirth = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param('sssssi', $fullName, $email, $phoneNumber, $nationality, $placeOfBirth, $id);

if ($stmt->execute()) {
    echo json_encode(['message' => 'Profile updated successfully']);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update profile']);
}

$stmt->close();
$conn->close();
?>
