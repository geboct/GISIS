<?php
header('Content-Type: application/json');

// Include database connection
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    if (isset($input['immigrant_id'])) {
        $immigrantId = $input['immigrant_id'];

        // Prepare the SQL query
        $stmt = $conn->prepare("SELECT * FROM immigrants WHERE id = ?");
        $stmt->bind_param("s", $immigrantId);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();

        // Check if any data is returned
        if ($data) {
            echo json_encode($data);
        } else {
            echo json_encode(['error' => 'No data found']);
        }

        $stmt->close();
    } else {
        echo json_encode(['error' => 'Invalid parameters']);
    }

    $conn->close();
} else {
    echo json_encode(['error' => 'Invalid request method']);
}
?>
