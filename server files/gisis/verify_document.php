<?php
include 'config.php';

$passport_number = $_POST['passport_number'];
$verified_by = $_POST['verified_by'];

$sql = "INSERT INTO document_verifications (passport_number, verified_by) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $passport_number, $verified_by);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
