<?php
include 'config.php';

$application_number = $_POST['application_number'];
$student_name = $_POST['student_name'];
$gender = $_POST['gender'];
$email = $_POST['email'];
$nationality = $_POST['nationality'];
$institution_name = $_POST['institution_name'];
$educational_duration = $_POST['educational_duration'];
$admission_number = $_POST['admission_number'];
$student_declaration = $_POST['student_declaration'];
$academic_qualification = $_POST['academic_qualification'];

$sql = "INSERT INTO student_pass_forms (application_number, student_name, gender, email, nationality, institution_name, educational_duration, admission_number, student_declaration, academic_qualification) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssssssssss", $application_number, $student_name, $gender, $email, $nationality, $institution_name, $educational_duration, $admission_number, $student_declaration, $academic_qualification);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Form submitted successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Failed to submit form"]);
}

$stmt->close();
$conn->close();
?>
