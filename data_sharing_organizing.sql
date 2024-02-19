-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 19, 2024 at 01:53 PM
-- Server version: 10.6.16-MariaDB-cll-lve
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
  `a_create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `a_last_login` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`a_id`, `a_email`, `a_first_name`, `a_last_name`, `a_password`, `a_verified_code`, `a_create_at`, `a_last_login`) VALUES
(4, 'elshoram974@gmail.com', 'Mohammed', 'El Shora', '12345678', NULL, '2024-01-31 15:33:52', '2024-02-19 21:03:22');

-- --------------------------------------------------------

--
-- Table structure for table `app_features`
--

CREATE TABLE `app_features` (
  `feature_id` int(11) NOT NULL,
  `feature_name` varchar(50) NOT NULL,
  `feature_description` text DEFAULT NULL,
  `feature_status` enum('enabled','disabled','in_development') NOT NULL DEFAULT 'in_development',
  `feature_start_version` int(11) NOT NULL DEFAULT 1 COMMENT 'the build version number we want to start with',
  `feature_created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `feature_updated_at` datetime DEFAULT NULL,
  `feature_created_by` varchar(50) NOT NULL,
  `feature_updated_by` varchar(50) DEFAULT NULL,
  `feature_access_level` enum('personal_user','business_admin','business_user','only_business','all','no_one') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_info`
--

CREATE TABLE `app_info` (
  `app_id` varchar(50) NOT NULL,
  `app_name` varchar(40) NOT NULL,
  `app_description` text DEFAULT NULL,
  `build_version` smallint(3) NOT NULL DEFAULT 1,
  `version` char(10) NOT NULL DEFAULT '1.0.0',
  `message_title` varchar(50) DEFAULT NULL COMMENT 'on open the app if we want',
  `message_body` varchar(255) DEFAULT NULL,
  `on_press_ok_android` varchar(255) DEFAULT NULL,
  `on_press_ok_web` varchar(255) DEFAULT NULL,
  `show_dialog_in` enum('android','web','all') NOT NULL DEFAULT 'all',
  `put_cancel_button` tinyint(1) NOT NULL DEFAULT 0,
  `first_release` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `developed_by` varchar(50) NOT NULL,
  `developer_site` varchar(255) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `license_info` varchar(255) DEFAULT NULL,
  `privacy_policy_link` varchar(255) DEFAULT NULL,
  `app_legalese_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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
  `user_lastlogin` datetime NOT NULL DEFAULT current_timestamp(),
  `user_createdat` datetime NOT NULL DEFAULT current_timestamp(),
  `user_image` varchar(255) DEFAULT NULL,
  `user_type` enum('personal','business') NOT NULL,
  `user_status` enum('active','inactive','suspended','deleted','pending') NOT NULL DEFAULT 'pending',
  `user_status_message` varchar(255) DEFAULT 'want to verify the account'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`user_id`, `user_email`, `user_first_name`, `user_last_name`, `user_password`, `user_provider`, `user_lastlogin`, `user_createdat`, `user_image`, `user_type`, `user_status`, `user_status_message`) VALUES
(42, 'elshoram974@gmail.com', 'Mohammed', 'El Shora', '$2y$10$I1ysgWmZ9Ske.CeMzCOpcuaPR9vjIIDN4Sf/L.uGAAMFkiE/GJemW', 'email_password', '2024-02-19 21:05:07', '2024-02-01 01:53:48', NULL, 'personal', 'active', NULL),
(45, 'mre9743@gmail.com', 'Mohammed', 'El Shora', '$2y$10$ExlqpJ7wW1NdMncnYu2sQOSZa4V4rgBcqB6TJNzD6ZWOroQYCDJ9i', 'email_password', '2024-02-13 22:21:19', '2024-02-13 22:21:19', NULL, 'personal', 'pending', 'want to verify the account');

-- --------------------------------------------------------

--
-- Table structure for table `business_profiles`
--

CREATE TABLE `business_profiles` (
  `business_user_id` int(11) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `business_domain` varchar(255) DEFAULT NULL,
  `business_logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_users`
--

CREATE TABLE `business_users` (
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_role` enum('owner','admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_activity`
--

CREATE TABLE `group_activity` (
  `activity_id` int(11) NOT NULL,
  `activity_group_id` int(11) NOT NULL,
  `activity_direction_id` int(11) DEFAULT NULL,
  `activity_type` enum('photo','record_file','text_message','voice_message','poll','document','instructions','video','location','other') NOT NULL,
  `activity_reply_on` int(11) DEFAULT NULL COMMENT 'if this activity is replied on other activity',
  `activity_content` varchar(2000) DEFAULT NULL,
  `activity_attachments` varchar(255) DEFAULT NULL COMMENT 'if user send file with content',
  `activity_date` datetime NOT NULL DEFAULT current_timestamp(),
  `activity_post_status` enum('admin_agree','admin_not_agree') NOT NULL,
  `activity_notify_others` enum('notify','without_notify','custom_notify') NOT NULL DEFAULT 'custom_notify' COMMENT 'custom_notify when users is custom and users notify',
  `activity_owner_id` int(11) NOT NULL,
  `activity_last_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_activity_direction`
--

CREATE TABLE `group_activity_direction` (
  `direction_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `direction_address` varchar(255) NOT NULL,
  `direction_max_count_activity` int(11) NOT NULL DEFAULT 100,
  `direction_in_direction_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_activity_seen`
--

CREATE TABLE `group_activity_seen` (
  `activity_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `seen_time` datetime DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_deails`
--

CREATE TABLE `group_deails` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `group_owner_id` int(11) NOT NULL,
  `group_creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `group_description` varchar(300) DEFAULT NULL,
  `group_visibility` enum('public','private','organization_only') NOT NULL DEFAULT 'public',
  `group_access_type` enum('only_read','read_write','read_write_with_admin_permission') NOT NULL DEFAULT 'read_write_with_admin_permission',
  `group_category` enum('personal','business') NOT NULL,
  `group_image` varchar(255) DEFAULT NULL,
  `group_type` enum('public','private','organization_only') NOT NULL DEFAULT 'public',
  `group_discussion_type` enum('exist','not_exist','exist_but_closed') NOT NULL,
  `group_status` enum('active','inactive','suspended','deleted','pending') NOT NULL DEFAULT 'active',
  `group_status_message` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `member_can_interaction` tinyint(1) NOT NULL DEFAULT 0,
  `member_notification` enum('notify','without_notify','custom_notify') NOT NULL,
  `member_join_date` datetime NOT NULL DEFAULT current_timestamp(),
  `member_role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `help_and_support`
--

CREATE TABLE `help_and_support` (
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `priority` enum('Low','Medium','High') NOT NULL,
  `status` enum('Open','In Progress','Closed') NOT NULL,
  `category` enum('Technical Support','Account Help','Feature Request') NOT NULL COMMENT 'Technical Support,Account Help,Feature Request',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notes` text DEFAULT NULL,
  `attachments` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_plans`
--

CREATE TABLE `payment_plans` (
  `plan_id` int(11) NOT NULL,
  `plan_name` varchar(30) NOT NULL,
  `plan_details` varchar(255) NOT NULL,
  `plan_max_size_in_byte` int(11) NOT NULL,
  `plan_max_group_num` int(11) NOT NULL,
  `plan_for_type` enum('personal','business') NOT NULL,
  `plan_expired` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `payment_plans`
--

INSERT INTO `payment_plans` (`plan_id`, `plan_name`, `plan_details`, `plan_max_size_in_byte`, `plan_max_group_num`, `plan_for_type`, `plan_expired`) VALUES
(1, 'Initial personal plan', 'make 2 groups with just 100 MB', 104857600, 2, 'personal', 0),
(2, 'Initial business plan', 'make any groups with just 500 MB', 524288000, 1000, 'business', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment_plan_time`
--

CREATE TABLE `payment_plan_time` (
  `plan_time_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `plan_time in months` int(11) NOT NULL,
  `plan_time_price_in_months` int(11) NOT NULL,
  `plan_time_discount` decimal(10,0) DEFAULT NULL,
  `plan_time_start_discount` datetime DEFAULT NULL,
  `plan_time_end_discount` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `payment_plan_time`
--

INSERT INTO `payment_plan_time` (`plan_time_id`, `plan_id`, `plan_time in months`, `plan_time_price_in_months`, `plan_time_discount`, `plan_time_start_discount`, `plan_time_end_discount`) VALUES
(1, 1, 1200, 0, NULL, NULL, NULL),
(2, 2, 1200, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchase_data`
--

CREATE TABLE `payment_purchase_data` (
  `purchase_id` int(11) NOT NULL,
  `purchase_user_id` int(11) NOT NULL,
  `purchase_plan_time_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT current_timestamp(),
  `purchase_total_amount` float NOT NULL,
  `purchase_payment_status` enum('paid','pending','failure') NOT NULL,
  `purchase_method` enum('PayPal','Stripe') NOT NULL,
  `purchase_invoice_num` varchar(100) NOT NULL,
  `purchase_invoice_date` datetime NOT NULL DEFAULT current_timestamp(),
  `purchase_due_date` datetime DEFAULT NULL,
  `purchase_transaction_id` int(11) DEFAULT NULL,
  `purchase_currency` varchar(5) NOT NULL DEFAULT 'EGP',
  `purchase_discounts` decimal(10,0) DEFAULT NULL,
  `purchase_tax` int(11) DEFAULT NULL,
  `purchase_refund_status` enum('pending','done') NOT NULL DEFAULT 'pending',
  `purchase_refund_amount` float DEFAULT NULL,
  `purchase_refund_date` datetime DEFAULT NULL,
  `purchase_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_user_plan`
--

CREATE TABLE `payment_user_plan` (
  `user_id` int(11) NOT NULL,
  `plan_time_id` int(11) NOT NULL,
  `purchase_data_id` int(11) DEFAULT NULL,
  `current_size_in_byte` int(11) NOT NULL,
  `current_group_num` int(11) NOT NULL,
  `user_plan_start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_plan_end_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `payment_user_plan`
--

INSERT INTO `payment_user_plan` (`user_id`, `plan_time_id`, `purchase_data_id`, `current_size_in_byte`, `current_group_num`, `user_plan_start_date`, `user_plan_end_date`) VALUES
(42, 1, NULL, 0, 0, '2024-02-08 10:24:08', '2024-02-08 10:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `user_action_history`
--

CREATE TABLE `user_action_history` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `action_time` datetime NOT NULL DEFAULT current_timestamp(),
  `action_type` enum('login','logout','account_crud','page_view','feature_usage','group_crud','activity_crud','other') NOT NULL COMMENT 'login, logout, account_crud, page_view, feature_usage, group_crud, activity_crud, other',
  `action_details` text DEFAULT NULL,
  `ip_address` varchar(15) DEFAULT NULL COMMENT 'IP address of the user''s device or network.',
  `location_info` varchar(200) DEFAULT NULL COMMENT 'Geographic information about the user''s location, such as the country or city.',
  `action_duration` int(11) DEFAULT NULL COMMENT 'Duration of the action in seconds',
  `status_code` int(11) NOT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `access_type` enum('android','web') NOT NULL,
  `additional_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_devices`
--

CREATE TABLE `user_devices` (
  `device_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_token` varchar(255) NOT NULL,
  `device_platform` enum('android','web') NOT NULL,
  `device_platform_version` varchar(30) DEFAULT NULL COMMENT 'The version of the platform (e.g., iOS 14, Android 12).',
  `device_model` varchar(30) DEFAULT NULL COMMENT 'Information about the specific device model (e.g., iPhone 12, Samsung Galaxy S21).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `user_devices`
--

INSERT INTO `user_devices` (`device_id`, `user_id`, `device_token`, `device_platform`, `device_platform_version`, `device_model`) VALUES
(4, 45, '121212', 'android', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `verification_codes`
--

CREATE TABLE `verification_codes` (
  `verification_id` int(11) NOT NULL,
  `verification_user` int(11) NOT NULL,
  `verification_code` varchar(6) NOT NULL,
  `verification_type` enum('forgot_password','create_email') NOT NULL,
  `verification_created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `verification_codes`
--

INSERT INTO `verification_codes` (`verification_id`, `verification_user`, `verification_code`, `verification_type`, `verification_created_at`) VALUES
(20, 42, '777878', 'create_email', '2024-02-13 04:18:59');

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
-- Indexes for table `app_features`
--
ALTER TABLE `app_features`
  ADD PRIMARY KEY (`feature_id`);

--
-- Indexes for table `app_info`
--
ALTER TABLE `app_info`
  ADD PRIMARY KEY (`app_id`);

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
-- Indexes for table `business_users`
--
ALTER TABLE `business_users`
  ADD PRIMARY KEY (`business_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `group_activity`
--
ALTER TABLE `group_activity`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `group_activity_ibfk_3` (`activity_owner_id`,`activity_group_id`),
  ADD KEY `activity_direction_id` (`activity_direction_id`),
  ADD KEY `activity_reply_on` (`activity_reply_on`),
  ADD KEY `group_activity_ibfk_7` (`activity_group_id`,`activity_owner_id`);

--
-- Indexes for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  ADD PRIMARY KEY (`direction_id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`direction_address`),
  ADD KEY `direction_in_direction_id` (`direction_in_direction_id`);

--
-- Indexes for table `group_activity_seen`
--
ALTER TABLE `group_activity_seen`
  ADD PRIMARY KEY (`activity_id`,`member_id`),
  ADD KEY `group_activity_seen_ibfk_2` (`member_id`);

--
-- Indexes for table `group_deails`
--
ALTER TABLE `group_deails`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `group_deails_ibfk_1` (`group_owner_id`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`group_id`,`member_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `help_and_support`
--
ALTER TABLE `help_and_support`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payment_plans`
--
ALTER TABLE `payment_plans`
  ADD PRIMARY KEY (`plan_id`),
  ADD UNIQUE KEY `plan_name` (`plan_name`);

--
-- Indexes for table `payment_plan_time`
--
ALTER TABLE `payment_plan_time`
  ADD PRIMARY KEY (`plan_time_id`),
  ADD UNIQUE KEY `plan_id` (`plan_id`,`plan_time in months`);

--
-- Indexes for table `payment_purchase_data`
--
ALTER TABLE `payment_purchase_data`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `payment_purchase_data_ibfk_1` (`purchase_user_id`),
  ADD KEY `payment_purchase_data_ibfk_2` (`purchase_plan_time_id`);

--
-- Indexes for table `payment_user_plan`
--
ALTER TABLE `payment_user_plan`
  ADD PRIMARY KEY (`user_id`,`plan_time_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `purchase_data_id` (`purchase_data_id`),
  ADD KEY `plan_time_id` (`plan_time_id`);

--
-- Indexes for table `user_action_history`
--
ALTER TABLE `user_action_history`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `device_id` (`device_id`);

--
-- Indexes for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD PRIMARY KEY (`device_id`),
  ADD UNIQUE KEY `device_token` (`device_token`),
  ADD KEY `user_devices_ibfk_1` (`user_id`);

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
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `app_features`
--
ALTER TABLE `app_features`
  MODIFY `feature_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `group_activity`
--
ALTER TABLE `group_activity`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  MODIFY `direction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_deails`
--
ALTER TABLE `group_deails`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `help_and_support`
--
ALTER TABLE `help_and_support`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_plans`
--
ALTER TABLE `payment_plans`
  MODIFY `plan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_plan_time`
--
ALTER TABLE `payment_plan_time`
  MODIFY `plan_time_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_purchase_data`
--
ALTER TABLE `payment_purchase_data`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_action_history`
--
ALTER TABLE `user_action_history`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `verification_codes`
--
ALTER TABLE `verification_codes`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD CONSTRAINT `business_profiles_ibfk_1` FOREIGN KEY (`business_user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `business_users`
--
ALTER TABLE `business_users`
  ADD CONSTRAINT `business_users_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business_profiles` (`business_user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `business_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_activity`
--
ALTER TABLE `group_activity`
  ADD CONSTRAINT `group_activity_ibfk_1` FOREIGN KEY (`activity_group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_ibfk_5` FOREIGN KEY (`activity_direction_id`) REFERENCES `group_activity_direction` (`direction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_ibfk_6` FOREIGN KEY (`activity_reply_on`) REFERENCES `group_activity` (`activity_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  ADD CONSTRAINT `group_activity_direction_ibfk_2` FOREIGN KEY (`direction_in_direction_id`) REFERENCES `group_activity_direction` (`direction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_direction_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_activity_seen`
--
ALTER TABLE `group_activity_seen`
  ADD CONSTRAINT `group_activity_seen_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `group_activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_seen_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `group_members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_deails`
--
ALTER TABLE `group_deails`
  ADD CONSTRAINT `group_deails_ibfk_1` FOREIGN KEY (`group_owner_id`) REFERENCES `app_users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `help_and_support`
--
ALTER TABLE `help_and_support`
  ADD CONSTRAINT `help_and_support_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_plan_time`
--
ALTER TABLE `payment_plan_time`
  ADD CONSTRAINT `payment_plan_time_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `payment_plans` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_purchase_data`
--
ALTER TABLE `payment_purchase_data`
  ADD CONSTRAINT `payment_purchase_data_ibfk_2` FOREIGN KEY (`purchase_plan_time_id`) REFERENCES `payment_plan_time` (`plan_time_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_user_plan`
--
ALTER TABLE `payment_user_plan`
  ADD CONSTRAINT `payment_user_plan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_user_plan_ibfk_2` FOREIGN KEY (`plan_time_id`) REFERENCES `payment_plan_time` (`plan_time_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_user_plan_ibfk_3` FOREIGN KEY (`purchase_data_id`) REFERENCES `payment_purchase_data` (`purchase_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `user_action_history`
--
ALTER TABLE `user_action_history`
  ADD CONSTRAINT `user_action_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `user_action_history_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `user_devices` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD CONSTRAINT `verification_codes_ibfk_1` FOREIGN KEY (`verification_user`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
