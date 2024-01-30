-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 30, 2024 at 12:31 PM
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
  `user_lastlogin` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_createdat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_image` varchar(255) DEFAULT NULL,
  `user_role` enum('personal_user','business_user','business_admin') NOT NULL,
  `user_status` enum('active','inactive','suspended','deleted','pending') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `business_profiles`
--

CREATE TABLE `business_profiles` (
  `business_user_id` int(11) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `business_domain` varchar(255) DEFAULT NULL,
  `business_logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `group_activity`
--

CREATE TABLE `group_activity` (
  `activity_id` int(11) NOT NULL,
  `activity_group_id` int(11) NOT NULL,
  `activity_direction_id` int(11) DEFAULT NULL,
  `activity_type` enum('photo','record','text_message','voice_message','poll','document','instructions','other') NOT NULL,
  `activity_content` varchar(2000) NOT NULL,
  `activity_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activity_post_status` enum('admin_agree','admin_not_agree') NOT NULL,
  `activity_notify_others` enum('notify_all','notify_not_mute','without_notify') NOT NULL DEFAULT 'notify_not_mute',
  `activity_owner_id` int(11) NOT NULL,
  `activity_last_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `group_activity_direction`
--

CREATE TABLE `group_activity_direction` (
  `direction_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `direction_address` varchar(255) NOT NULL,
  `direction_max_count_activity` int(11) NOT NULL DEFAULT '100',
  `direction_in_direction_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `group_deails`
--

CREATE TABLE `group_deails` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `group_owner_id` int(11) NOT NULL,
  `group_creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `group_description` varchar(300) DEFAULT NULL,
  `group_visibility` enum('public','private','organization_only') NOT NULL DEFAULT 'public',
  `group_access_type` enum('only_read','read_write','read_write_with_admin_permission') NOT NULL DEFAULT 'read_write_with_admin_permission',
  `group_category` enum('personal','business') NOT NULL,
  `group_image` varchar(255) DEFAULT NULL,
  `group_type` enum('public','private','organization_only') NOT NULL DEFAULT 'public',
  `group_discussion_type` enum('exist','not_exist','exist_but_closed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `member_can_interaction` tinyint(1) NOT NULL DEFAULT '0',
  `member_join_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `member_role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `plan_expired` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchase_data`
--

CREATE TABLE `payment_purchase_data` (
  `purchase_id` int(11) NOT NULL,
  `purchase_user_id` int(11) NOT NULL,
  `purchase_plan_time_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `purchase_total_amount` float NOT NULL,
  `purchase_payment_status` enum('paid','pending','failure') NOT NULL,
  `purchase_method` enum('PayPal','Stripe') NOT NULL,
  `purchase_invoice_num` varchar(100) NOT NULL,
  `purchase_invoice_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `purchase_due_date` datetime DEFAULT NULL,
  `purchase_transaction_id` int(11) DEFAULT NULL,
  `purchase_currency` varchar(5) NOT NULL DEFAULT 'EGP',
  `purchase_discounts` decimal(10,0) DEFAULT NULL,
  `purchase_tax` int(11) DEFAULT NULL,
  `purchase_refund_status` enum('pending','done') NOT NULL DEFAULT 'pending',
  `purchase_refund_amount` float DEFAULT NULL,
  `purchase_refund_date` datetime DEFAULT NULL,
  `purchase_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `user_plan_start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_plan_end_date` datetime NOT NULL
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
-- Indexes for table `group_activity`
--
ALTER TABLE `group_activity`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `group_activity_ibfk_3` (`activity_owner_id`,`activity_group_id`),
  ADD KEY `group_activity_ibfk_4` (`activity_group_id`,`activity_owner_id`),
  ADD KEY `activity_direction_id` (`activity_direction_id`);

--
-- Indexes for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  ADD PRIMARY KEY (`direction_id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`direction_address`),
  ADD KEY `direction_in_direction_id` (`direction_in_direction_id`);

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
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `group_activity`
--
ALTER TABLE `group_activity`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  MODIFY `direction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `group_deails`
--
ALTER TABLE `group_deails`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_plans`
--
ALTER TABLE `payment_plans`
  MODIFY `plan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_plan_time`
--
ALTER TABLE `payment_plan_time`
  MODIFY `plan_time_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_purchase_data`
--
ALTER TABLE `payment_purchase_data`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `verification_codes`
--
ALTER TABLE `verification_codes`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD CONSTRAINT `business_profiles_ibfk_1` FOREIGN KEY (`business_user_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `group_activity`
--
ALTER TABLE `group_activity`
  ADD CONSTRAINT `group_activity_ibfk_1` FOREIGN KEY (`activity_group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_ibfk_3` FOREIGN KEY (`activity_owner_id`) REFERENCES `group_members` (`member_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_ibfk_4` FOREIGN KEY (`activity_group_id`,`activity_owner_id`) REFERENCES `group_members` (`group_id`, `member_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_ibfk_5` FOREIGN KEY (`activity_direction_id`) REFERENCES `group_activity_direction` (`direction_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  ADD CONSTRAINT `group_activity_direction_ibfk_2` FOREIGN KEY (`direction_in_direction_id`) REFERENCES `group_activity_direction` (`direction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_activity_direction_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_deails`
--
ALTER TABLE `group_deails`
  ADD CONSTRAINT `group_deails_ibfk_1` FOREIGN KEY (`group_owner_id`) REFERENCES `app_users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group_deails` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD CONSTRAINT `verification_codes_ibfk_1` FOREIGN KEY (`verification_user`) REFERENCES `app_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
