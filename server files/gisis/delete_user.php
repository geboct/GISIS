<?php
// Include your database connection file
include('config.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if the ID is provided in the request
    if (isset($_POST['id'])) {
        $id = $_POST['id'];

        // Prepare the SQL delete statement
        $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $id);

        // Execute the statement and check if the deletion was successful
        if ($stmt->execute()) {
            echo json_encode('success');
        } else {
            echo json_encode('error');
        }

        // Close the statement
        $stmt->close();
    } else {
        echo json_encode('error');
    }
} else {
    echo json_encode('error');
}

// Close the database connection
$conn->close();
?>
