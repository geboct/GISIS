<?php
include 'config.php';

$passport_number = $_GET['passport_number'];

$sql = "SELECT * FROM users WHERE passport_number = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $passport_number);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        echo json_encode($result->fetch_assoc());
    } else {
        echo json_encode(["success" => false, "message" => "User not found"]);
    }
} else {
    echo json_encode(["success" => false, "error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
