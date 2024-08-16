<?php
// upload_work_permit.php

// Include the config file
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['work_permit_file'])) {
    $immigrant_id = $_POST['immigrant_id'];
    $upload_dir = 'workpermit/uploads/';
    $file_name = basename($_FILES['work_permit_file']['name']);
    $file_path = $upload_dir . $file_name;

    if (move_uploaded_file($_FILES['work_permit_file']['tmp_name'], $file_path)) {
        // Store the file path in the database
        $stmt = $conn->prepare("INSERT INTO work_permit_uploads (immigrant_id, file_path) VALUES (?, ?)");
        $stmt->bind_param("is", $immigrant_id, $file_path);
        $stmt->execute();
        $stmt->close();
        $conn->close();

        echo "File uploaded successfully.";
    } else {
        echo "Failed to upload file.";
    }
} else {
    echo "No file uploaded.";
}
?>
