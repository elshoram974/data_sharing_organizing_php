-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 27, 2024 at 12:52 AM
-- Server version: 5.7.44-cll-lve
-- PHP Version: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data_sharing_organizing`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `a_id` int(11) NOT NULL,
  `a_email` varchar(100) NOT NULL,
  `a_first_name` varchar(25) NOT NULL,
  `a_last_name` varchar(25) NOT NULL,
  `a_password` varchar(255) NOT NULL,
  `a_verified_code` varchar(6) DEFAULT NULL,
  `a_create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `a_last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`a_id`, `a_email`, `a_first_name`, `a_last_name`, `a_password`, `a_verified_code`, `a_create_at`, `a_last_login`) VALUES
(1, 'elshora@gmail.com', 'Mohammed', 'El Shora', '$2y$10$9b6PVcuWrgJATyrKx4OH7ergNHNgEHRVtt3dOvRKh9g2rZvTr99B.', NULL, '2024-01-23 04:56:39', '2024-01-27 07:08:17'),
(2, 'elshoram974@gmail.com', 'محمد', 'الشوره', '$2y$10$9b6PVcuWrgJATyrKx4OH7ergNHNgEHRVtt3dOvRKh9g2rZvTr99B.', '279711', '2024-01-26 23:41:31', '2024-01-26 23:41:31');

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE `app_users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_first_name` varchar(30) NOT NULL,
  `user_last_name` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_provider` enum('facebook','google','email_password') NOT NULL DEFAULT 'email_password',
  `user_is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `user_lastlogin` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_createdat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_image` varchar(255) DEFAULT NULL,
  `user_role` enum('personal_user','business_user','business_admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `business_profiles`
--

CREATE TABLE `business_profiles` (
  `business_user_id` int(11) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `business_domain` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_business_roles`
--

CREATE TABLE `user_business_roles` (
  `user_id` int(11) NOT NULL,
  `business_user_id` int(11) NOT NULL,
  `is_business_admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `verification_codes`
--

CREATE TABLE `verification_codes` (
  `verification_id` int(11) NOT NULL,
  `verification_user` int(11) NOT NULL,
  `verification_code` varchar(6) NOT NULL,
  `verification_type` enum('forgot_password','create_email') NOT NULL,
  `verification_created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`a_id`),
  ADD UNIQUE KEY `a_email` (`a_email`);

--
-- Indexes for table `app_users`
--
ALTER TABLE `app_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- Indexes for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD PRIMARY KEY (`business_user_id`);

--
-- Indexes for table `user_business_roles`
--
ALTER TABLE `user_business_roles`
  ADD PRIMARY KEY (`user_id`,`business_user_id`),
  ADD KEY `business_user_id` (`business_user_id`);

--
-- Indexes for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD PRIMARY KEY (`verification_id`),
  ADD UNIQUE KEY `user_id` (`verification_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `verification_codes`
--
ALTER TABLE `verification_codes`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD CONSTRAINT `business_profiles_ibfk_1` FOREIGN KEY (`business_user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_business_roles`
--
ALTER TABLE `user_business_roles`
  ADD CONSTRAINT `user_business_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_business_roles_ibfk_2` FOREIGN KEY (`business_user_id`) REFERENCES `business_profiles` (`business_user_id`) ON DELETE CASCADE;

--
-- Constraints for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD CONSTRAINT `verification_codes_ibfk_1` FOREIGN KEY (`verification_user`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
