<?php
include 'config.php';

$username = $_POST['username'];
$password = $_POST['password'];

// Query to check if the user exists
$sql = "SELECT * FROM immigrants WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        // User found, now verify the password
        $user = $result->fetch_assoc();

        // Verify the password
        if (password_verify($password, $user['password'])) {
            // Password is correct
            echo json_encode([
                "success" => true,
                "user" => $user
            ]);
        } else {
            // Password is incorrect
            echo json_encode([
                "success" => false,
                "message" => "Invalid username or password"
            ]);
        }
    } else {
        // User not found
        echo json_encode([
            "success" => false,
            "message" => "Invalid username or password"
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "error" => $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>
