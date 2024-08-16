<?php
include 'config.php';

$name = $_POST['name'];
$passport_number = $_POST['passport_number'];
$yellow_fever_card = $_POST['yellow_fever_card'];
$visa = $_POST['visa'];
$role = $_POST['role'];

$sql = "INSERT INTO users (name, passport_number, yellow_fever_card, visa, role) VALUES (?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssss", $name, $passport_number, $yellow_fever_card, $visa, $role);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
