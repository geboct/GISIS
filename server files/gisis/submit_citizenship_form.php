<?php
// Include the configuration file
include 'config.php';

// Check if form was submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $fullName = $_POST['full_name'];
    $dateOfBirth = $_POST['date_of_birth'];
    $placeOfBirth = $_POST['place_of_birth'];
    $gender = $_POST['gender'];
    $maritalStatus = $_POST['marital_status'];
    $nationality = $_POST['nationality'];
    $passportNumber = $_POST['passport_number'];
    $dateOfIssue = $_POST['date_of_issue'];
    $expiryDate = $_POST['expiry_date'];
    $placeOfIssue = $_POST['place_of_issue'];
    $occupation = $_POST['occupation'];
    $contactPersonName = $_POST['contact_person_name'];
    $contactPersonPhone = $_POST['contact_person_phone'];

    // Handle file uploads
    $passportPhotoPath = '';
    $nationalityIDPath = '';

    if (isset($_FILES['passport_photo']) && $_FILES['passport_photo']['error'] == UPLOAD_ERR_OK) {
        $passportPhoto = $_FILES['passport_photo'];
        $passportPhotoPath = 'passphoto/' . basename($passportPhoto['name']);
        move_uploaded_file($passportPhoto['tmp_name'], $passportPhotoPath);
    }

    if (isset($_FILES['nationality_id']) && $_FILES['nationality_id']['error'] == UPLOAD_ERR_OK) {
        $nationalityID = $_FILES['nationality_id'];
        $nationalityIDPath = 'ID/' . basename($nationalityID['name']);
        move_uploaded_file($nationalityID['tmp_name'], $nationalityIDPath);
    }

    // Prepare and execute the insert query
    $stmt = $conn->prepare("
        INSERT INTO citizenship_forms (
            full_name, date_of_birth, place_of_birth, gender, marital_status, 
            nationality, passport_number, date_of_issue, expiry_date, place_of_issue, 
            occupation, contact_person_name, contact_person_phone, passport_photo_path, nationality_id_path
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");

    $stmt->bind_param(
        'sssssssssssssss',
        $fullName, $dateOfBirth, $placeOfBirth, $gender, $maritalStatus,
        $nationality, $passportNumber, $dateOfIssue, $expiryDate, $placeOfIssue,
        $occupation, $contactPersonName, $contactPersonPhone, $passportPhotoPath, $nationalityIDPath
    );

    if ($stmt->execute()) {
        echo "Form submitted successfully!";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
} else {
    echo "Invalid request.";
}
?>
