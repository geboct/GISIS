-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 16, 2024 at 08:58 AM
-- Server version: 10.3.39-MariaDB-0ubuntu0.20.04.2
-- PHP Version: 8.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jewelspa_gisis`
--

-- --------------------------------------------------------

--
-- Table structure for table `citizenship_forms`
--

CREATE TABLE `citizenship_forms` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `place_of_birth` varchar(255) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `marital_status` varchar(50) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `passport_number` varchar(100) NOT NULL,
  `date_of_issue` date NOT NULL,
  `expiry_date` date NOT NULL,
  `place_of_issue` varchar(255) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `contact_person_name` varchar(255) NOT NULL,
  `contact_person_phone` varchar(50) NOT NULL,
  `passport_photo_path` varchar(255) NOT NULL,
  `nationality_id_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `citizenship_forms`
--

INSERT INTO `citizenship_forms` (`id`, `full_name`, `date_of_birth`, `place_of_birth`, `gender`, `marital_status`, `nationality`, `passport_number`, `date_of_issue`, `expiry_date`, `place_of_issue`, `occupation`, `contact_person_name`, `contact_person_phone`, `passport_photo_path`, `nationality_id_path`, `created_at`) VALUES
(1, 'JAmes Mcctharty', '2024-08-01', 'eaven', 'Male', 'Divorced', 'Japanese', '2142342q34', '2024-08-01', '2024-08-13', 'Wimbledon', 'Farmer', 'reamer', '3435434321', 'passphoto/WhatsApp Image 2024-08-06 at 20.06.30.jpeg', 'ID/WhatsApp Image 2024-08-06 at 14.50.11.jpeg', '2024-08-13 08:14:45');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `passportNumber` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `yellowFeverCard` varchar(50) NOT NULL,
  `visa` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('Immigrant','Emigrant') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `passportNumber`, `name`, `yellowFeverCard`, `visa`, `status`, `created_at`, `type`) VALUES
(1, '123456789', 'John Doe', 'Valid', 'Valid', 'Pending', '2024-06-08 14:59:58', 'Immigrant'),
(2, '987654321', 'Jane Smith', 'Valid', 'Expired', 'Approved', '2024-06-08 14:59:58', 'Immigrant'),
(4, '111122223', 'Bob Brown', 'Valid', 'Valid', 'Approved', '2024-06-08 14:59:58', 'Immigrant'),
(6, '123456789', 'John Doe', 'Valid', 'Valid', 'Pending', '2024-06-08 15:02:50', 'Immigrant'),
(7, '987654321', 'Jane Smith', 'Valid', 'Expired', 'Approved', '2024-06-08 15:02:50', 'Emigrant'),
(9, '231414545', 'kennedy', '', '', '', '2024-06-08 15:53:47', 'Immigrant');

-- --------------------------------------------------------

--
-- Table structure for table `document_verifications`
--

CREATE TABLE `document_verifications` (
  `id` int(11) NOT NULL,
  `passport_number` varchar(255) NOT NULL,
  `verified_by` int(11) NOT NULL,
  `verified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `position` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `date_hired` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `position`, `department`, `date_hired`) VALUES
(1, 'john', '1234', 'John', 'Doe', 'john.doe@example.com', '1234567890', 'Software Engineer', 'IT', '2023-01-15'),
(2, '', '', 'Jane', 'Smith', 'jane.smith@example.com', '0987654321', 'Project Manager', 'Management', '2022-05-23'),
(3, '', '', 'Alice', 'Johnson', 'alice.johnson@example.com', '1122334455', 'Data Analyst', 'Analytics', '2021-11-10'),
(4, '', '', 'Michael', 'Brown', 'michael.brown@example.com', '2233445566', 'System Administrator', 'IT', '2020-03-19'),
(5, '', '', 'Emily', 'Davis', 'emily.davis@example.com', '3344556677', 'HR Specialist', 'Human Resources', '2019-07-29'),
(6, '', '', 'David', 'Wilson', 'david.wilson@example.com', '4455667788', 'Marketing Manager', 'Marketing', '2018-09-15'),
(7, '', '', 'hdvshv', 'sahdhb', 'gauchxhb', 'gdubhjcb', 'ucbbcu', 'bcbhb ', '0000-00-00'),
(8, '', '', 'gdjhg', 'usiuaf', 'uiachxb', 'uhsacj', 'uhahk', 'uhaxkzjhc', '0000-00-00'),
(9, '', '', 'jsgfjsdjh', 'shdjzhjkxvi', 'usdhajczj', '09876543', 'jzckjk', 'jkzhvk', '0000-00-00'),
(10, '', '', 'jsghg', 'uifhadjh', 'uisahsd', 'uihciuash', 'hsajai', 'uishaci\\hi', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `immigrants`
--

CREATE TABLE `immigrants` (
  `id` int(11) UNSIGNED NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `phoneNumber` varchar(15) NOT NULL,
  `placeOfBirth` varchar(255) NOT NULL,
  `passportNumber` varchar(50) NOT NULL,
  `dateOfIssue` date NOT NULL,
  `expiryDate` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `immigrants`
--

INSERT INTO `immigrants` (`id`, `fullName`, `dateOfBirth`, `nationality`, `phoneNumber`, `placeOfBirth`, `passportNumber`, `dateOfIssue`, `expiryDate`, `email`, `password`, `created_at`) VALUES
(1, 'Salifu Jibri', '2000-01-13', 'Ghanaian', '0243930223', 'Kumasi', '7261567', '2024-08-07', '2034-08-10', 'gaagafg', '$2y$10$0fpnY.LO6JWWe.y9ksICkeNU5RwZTtg/SOO46Nr5pHkit32E99OtS', '2024-08-12 12:03:48'),
(2, 'Karim benzima', '2000-01-19', 'Ghanaian', '0243938048', 'Sasam', '786483646', '2024-08-07', '2034-08-10', 'hdgshdhgsg', '$2y$10$/Fhg36nfJO4CEtxDANm1We0M/.ITvWlK75hq2XnO1k7HaYUiyqz4u', '2024-08-12 12:16:17'),
(3, 'Albert Anum', '2024-01-01', 'Ghanaian ', '0541994657', 'Accra', 'GH0111111', '2024-01-01', '2034-08-13', 'anumalbert0@gmail.com', '$2y$10$yGC4asTkdcodbzAebAz/Su4gaBVnuc2JlZaYo/1V08GVZhBSyiEyq', '2024-08-15 11:39:17'),
(4, 'Evans Apeadu ', '2000-01-02', 'Ghanaian ', '0547321629', 'Accra', '20930201', '2024-08-15', '2035-04-01', 'supamybet@gmail.com', '$2y$10$NfQ/rIck7y2jkZjWD3DX9.H4kl08gRq42ZopymEFIJlUFN10FqNCi', '2024-08-15 12:12:16'),
(5, 'Linda Yeboah ', '2000-01-01', 'Ghanaian ', '0201556276', 'Aburi', '1556276', '2024-07-01', '2035-07-01', 'zeddscore@gmail.com', '$2y$10$lBe2OFsCVczAttmCF8oa5uZ44H36LB0S8bMqeMiIFmZwRHj96GOrC', '2024-08-15 12:20:35');

-- --------------------------------------------------------

--
-- Table structure for table `multiple_visa_entries`
--

CREATE TABLE `multiple_visa_entries` (
  `id` int(11) NOT NULL,
  `application_number` varchar(50) NOT NULL,
  `type_of_visa` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` int(11) NOT NULL,
  `nationality` varchar(50) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `country_of_birth` varchar(50) NOT NULL,
  `country_of_residence` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `passport_number` varchar(50) NOT NULL,
  `place_of_issue` varchar(50) NOT NULL,
  `date_of_issue` date NOT NULL,
  `expiry_date` date NOT NULL,
  `reason_for_entry` text NOT NULL,
  `proposed_date_of_entry` date NOT NULL,
  `duration_of_stay_in_days` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `multiple_visa_entries`
--

INSERT INTO `multiple_visa_entries` (`id`, `application_number`, `type_of_visa`, `full_name`, `gender`, `age`, `nationality`, `occupation`, `country_of_birth`, `country_of_residence`, `email`, `passport_number`, `place_of_issue`, `date_of_issue`, `expiry_date`, `reason_for_entry`, `proposed_date_of_entry`, `duration_of_stay_in_days`, `created_at`) VALUES
(1, '23', 'Visas for medical treatment.', 'Mahatma Ghandhi', 'Male', 3456, 'India', 'Speaker', 'Ghana', 'Ghana', 'hsjdsdhsvhv', '132423', 'Pokuase', '2024-08-13', '2024-08-13', 'dead', '2024-08-13', 34, '2024-08-13 17:04:41');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_pass_forms`
--

CREATE TABLE `student_pass_forms` (
  `id` int(11) NOT NULL,
  `application_number` varchar(100) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `email` varchar(255) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `institution_name` varchar(255) NOT NULL,
  `educational_duration` varchar(100) NOT NULL,
  `admission_number` varchar(100) NOT NULL,
  `student_declaration` text NOT NULL,
  `academic_qualification` text NOT NULL,
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_pass_forms`
--

INSERT INTO `student_pass_forms` (`id`, `application_number`, `student_name`, `gender`, `email`, `nationality`, `institution_name`, `educational_duration`, `admission_number`, `student_declaration`, `academic_qualification`, `submission_date`) VALUES
(1, '4', 'fred', 'Male', 'gebililas@gmail.com', 'Ghana', 'trerre', '23', '112323', 'sjakbdjbdjabjhb', 'BSC', '2024-08-12 21:13:53'),
(2, '4', 'fred', 'Male', 'gebililas@gmail.com', 'Ghana', 'trerre', '23', '112323', 'sjakbdjbdjabjhb', 'BSC', '2024-08-13 05:13:09');

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `password` varchar(255) DEFAULT NULL,
  `phone` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `created_at`, `password`, `phone`) VALUES
(1, 'Salifu Gebilila', 'gebililasalifu@gmail.com', '2024-06-07 09:41:02', '$2y$10$/Fhg36nfJO4CEtxDANm1We0M/.ITvWlK75hq2XnO1k7HaYUiyqz4u', 243930223);

-- --------------------------------------------------------

--
-- Table structure for table `work_permit_uploads`
--

CREATE TABLE `work_permit_uploads` (
  `id` int(11) NOT NULL,
  `immigrant_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `work_permit_uploads`
--

INSERT INTO `work_permit_uploads` (`id`, `immigrant_id`, `file_path`, `upload_date`) VALUES
(1, 1, 'workpermit/uploads/WORK-PERMIT-APPLICATION-FORM.pdf', '2024-08-13 15:13:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `citizenship_forms`
--
ALTER TABLE `citizenship_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_verifications`
--
ALTER TABLE `document_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `immigrants`
--
ALTER TABLE `immigrants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multiple_visa_entries`
--
ALTER TABLE `multiple_visa_entries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `student_pass_forms`
--
ALTER TABLE `student_pass_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_permit_uploads`
--
ALTER TABLE `work_permit_uploads`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `citizenship_forms`
--
ALTER TABLE `citizenship_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `document_verifications`
--
ALTER TABLE `document_verifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `immigrants`
--
ALTER TABLE `immigrants`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `multiple_visa_entries`
--
ALTER TABLE `multiple_visa_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_pass_forms`
--
ALTER TABLE `student_pass_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `work_permit_uploads`
--
ALTER TABLE `work_permit_uploads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `document_verifications`
--
ALTER TABLE `document_verifications`
  ADD CONSTRAINT `document_verifications_ibfk_1` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD CONSTRAINT `support_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
