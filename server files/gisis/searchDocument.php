<?php
include 'config.php';

$passportNumber = $_POST['passportNumber'];

$sql = "SELECT * FROM documents WHERE passportNumber = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $passportNumber);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode([
        'success' => true,
        'document' => [
            'passportNumber' => $row['passportNumber'],
            'name' => $row['name'],
            'yellowFeverCard' => $row['yellowFeverCard'],
            'visa' => $row['visa'],
            'status' => $row['status']
        ]
    ]);
} else {
    echo json_encode([
        'success' => false
    ]);
}

$stmt->close();
$conn->close();
?>
