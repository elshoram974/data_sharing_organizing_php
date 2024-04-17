-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 16, 2024 at 11:58 PM
-- Server version: 10.6.17-MariaDB-cll-lve
-- PHP Version: 8.1.26

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
(4, 'elshoram974@gmail.com', 'ali', 'alhamoli', '123456789', '326485', '2024-01-31 15:33:52', '2024-03-25 22:20:06');

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
(42, 'elshoram974@gmail.com', 'Mohammed', 'El Shora', '$2y$10$SXgmXICjEpc859MKjfFMEOu5Jky70lx1RYuiBMmrf4Fwht1vuHNre', 'email_password', '2024-04-15 20:23:41', '2024-02-01 01:53:48', 'https://thiet.mrecode.com/api/assets/users_photo/33840image_cropper_1711461424567.jpg', 'personal', 'active', NULL),
(45, 'mre9743@gmail.com', 'MRE', 'CODE', '$2y$10$ExlqpJ7wW1NdMncnYu2sQOSZa4V4rgBcqB6TJNzD6ZWOroQYCDJ9i', 'email_password', '2024-04-16 12:57:07', '2024-02-13 22:21:19', 'https://thiet.mrecode.com/api/assets/users_photo/24108image_cropper_1713180520806.jpg', 'personal', 'active', NULL),
(48, 'r7HJAAuguifcFd5ycuWaGq2HfOF3', 'adel', 'eid', '$2y$10$FaVuTk1lHxx.Bm8DF3oCjupoSAyYFOAj359BNkELETKAUBBPZ/rsq', 'facebook', '2024-04-06 01:00:40', '2024-02-20 21:13:58', NULL, 'personal', 'active', NULL),
(49, 'eidm56511@gmail.com', 'ramadan', 'kareem', '$2y$10$WHiW2iJhdITTDaCz61SBWuVXEQ7Q90jlYpZnZqZRZx6wHABZR0lZ2', 'google', '2024-03-21 16:33:19', '2024-02-27 21:54:20', NULL, 'personal', 'deleted', NULL),
(50, 'alialiali@gmail.com', 'adel', 'eid', '$2y$10$K6pZNEyoX45C4Y01A5V4uOaG0oOnUnyo1sbXw4YnC0gbWwxTtcLqS', 'email_password', '2024-03-14 16:29:12', '2024-03-14 16:29:12', NULL, 'personal', 'deleted', 'want to verify the account'),
(51, 'mre97433@gmail.com', 'mohamad', 'elshora', '$2y$10$nZ1IoioWL7mapaA6vxQcn.k8LGZUXjI1ajcAxmr0AYv4p5TEVTtUK', 'email_password', '2024-03-21 16:23:27', '2024-03-21 16:23:27', NULL, 'personal', 'pending', 'want to verify the account'),
(52, 'mre9733@gmail.com', 'mohamad', 'elshora', '$2y$10$xllplkfmnz1Um70lyRFzkOEs.ZkiDTGFk.2mIPyBFDrzn/9Z5Rdt2', 'email_password', '2024-03-21 16:24:15', '2024-03-21 16:24:15', NULL, 'personal', 'pending', 'want to verify the account'),
(53, 'mre973300@gmail.com', 'mohamad', 'elshora', '$2y$10$lg3IbAg0lJNwRHS/pQJm1.YaLBIwSGZ/03kW0jGZxuQl7..aNgMa6', 'email_password', '2024-03-21 16:55:51', '2024-03-21 16:55:51', NULL, 'personal', 'deleted', 'want to verify the account'),
(54, 'mre97330@gmail.com', 'mohamad', 'elshora', '$2y$10$DYPUtpL0mW1SePuTNFM7qeT28RzSCnMfIPsHQwac05YZCbkz4g/ri', 'email_password', '2024-03-21 16:56:00', '2024-03-21 16:56:00', NULL, 'personal', 'pending', 'want to verify the account'),
(55, 'mr97330@gmail.com', 'mohamad', 'elshora', '$2y$10$ynqSWQnyg5K/d7/tJZMa4O2aK2twt/mFA456Ka5u5Xqa274bv0hsC', 'email_password', '2024-03-21 16:56:21', '2024-03-21 16:56:21', NULL, 'personal', 'pending', 'want to verify the account'),
(56, 'mr97330@mail.com', 'mohamad', 'elshora', '$2y$10$6cPF0ruQMH8sqvLIDKREYOsRW6ECSH5PSpa58LYxCKwzioIX7WtmO', 'email_password', '2024-03-21 16:57:07', '2024-03-21 16:57:07', NULL, 'personal', 'pending', 'want to verify the account'),
(57, 'mahmoudyahyaabla@gmail.com', 'Mahmoud', '', '$2y$10$W3WhIyYekNcOYatYNKHai.u/XE4N2WcShC5XV18oxEaD.D1RCy4T.', 'email_password', '2024-03-26 00:29:25', '2024-03-26 00:27:11', NULL, 'personal', 'active', NULL),
(58, 'riyadm2001@gmail.com', 'Mohammed', 'Riyad', '$2y$10$rv6YuGecG92rf.vRajWVH.qwyAGcEufZ2zsW1VC3gKsPYeAZF1xvu', 'google', '2024-04-15 20:35:36', '2024-04-06 01:00:57', NULL, 'personal', 'active', NULL),
(59, 'blackack599@gmail.com', 'Omar', 'Elbayoumi', '$2y$10$qjebZesnSC4KU9iQzWRnZ.K0sCDlWPMstuvqwT57smxBFIYz5Fpqu', 'email_password', '2024-04-07 02:51:45', '2024-04-07 02:51:45', NULL, 'personal', 'pending', 'want to verify the account'),
(60, 'elshora@gmail.com', 'B', '', '$2y$10$HYsjlP87MX6IAIY.lptQSuvu44687D59QvplddbhUBOFdOhpONR6S', 'email_password', '2024-04-07 02:58:01', '2024-04-07 02:58:01', NULL, '', 'deleted', 'want to verify the account'),
(61, 'ao9270016@gmail.com', 'Ahmed', 'Osama', '$2y$10$3tE/GrljTMtOXqaRUXvilubpiUgh4ALB78RL0hIYnRrolL7c4uB9.', 'google', '2024-04-14 23:21:19', '2024-04-14 23:21:19', NULL, 'personal', 'active', NULL);

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
  `activity_is_approved` tinyint(1) NOT NULL,
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
  `inside_direction_id` int(11) DEFAULT NULL,
  `direction_is_approved` tinyint(1) NOT NULL,
  `direction_owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `group_activity_direction`
--

INSERT INTO `group_activity_direction` (`direction_id`, `group_id`, `direction_address`, `direction_max_count_activity`, `inside_direction_id`, `direction_is_approved`, `direction_owner_id`) VALUES
(1, 5, 'aaaa', 100, NULL, 1, 42);

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
  `group_status_message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `group_deails`
--

INSERT INTO `group_deails` (`group_id`, `group_name`, `group_owner_id`, `group_creation_date`, `group_description`, `group_visibility`, `group_access_type`, `group_category`, `group_image`, `group_type`, `group_discussion_type`, `group_status`, `group_status_message`) VALUES
(5, 'asas', 42, '2024-03-25 08:40:38', 'asasasasasasasssssssssssssssssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'public', 'read_write_with_admin_permission', 'personal', 'https://pbs.twimg.com/profile_images/1744393322418802688/-ZF7VwbA_400x400.jpg', 'public', 'exist_but_closed', 'active', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `member_can_interaction` tinyint(1) NOT NULL DEFAULT 1,
  `member_notification` enum('notify','without_notify','custom_notify') NOT NULL DEFAULT 'notify',
  `member_join_date` datetime NOT NULL DEFAULT current_timestamp(),
  `member_is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`group_id`, `member_id`, `member_can_interaction`, `member_notification`, `member_join_date`, `member_is_admin`) VALUES
(5, 42, 1, 'notify', '2024-03-25 08:40:56', 2),
(5, 45, 0, 'notify', '2024-04-15 04:17:34', 1),
(5, 58, 0, 'notify', '2024-04-15 07:20:37', 1);

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

-- --------------------------------------------------------

--
-- Table structure for table `user_action_history`
--

CREATE TABLE `user_action_history` (
  `action_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_id` int(11) DEFAULT NULL,
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

--
-- Dumping data for table `user_action_history`
--

INSERT INTO `user_action_history` (`action_id`, `user_id`, `device_id`, `action_time`, `action_type`, `action_details`, `ip_address`, `location_info`, `action_duration`, `status_code`, `error_message`, `access_type`, `additional_data`) VALUES
(629, 42, NULL, '2024-03-24 11:26:10', 'account_crud', 'user is changed name', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(630, 42, NULL, '2024-03-24 11:26:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(631, 42, NULL, '2024-03-24 11:26:41', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(632, 42, NULL, '2024-03-24 11:26:53', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(633, 42, NULL, '2024-03-24 11:27:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(634, 42, NULL, '2024-03-24 11:27:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(635, 42, NULL, '2024-03-24 11:27:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(636, 42, NULL, '2024-03-24 14:39:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(637, 42, NULL, '2024-03-24 14:39:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(638, 42, NULL, '2024-03-24 14:39:13', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(639, 42, NULL, '2024-03-24 14:39:35', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(640, 42, NULL, '2024-03-24 14:40:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(641, 42, NULL, '2024-03-24 14:41:32', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(642, 42, NULL, '2024-03-24 14:42:38', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(643, 42, NULL, '2024-03-24 14:43:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(644, 42, NULL, '2024-03-24 14:45:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(645, 42, NULL, '2024-03-24 14:45:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(646, 42, NULL, '2024-03-24 14:49:45', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(647, 42, NULL, '2024-03-24 14:49:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(648, 42, NULL, '2024-03-24 15:02:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(649, 42, NULL, '2024-03-24 15:02:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(650, 42, NULL, '2024-03-24 15:02:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(651, 42, NULL, '2024-03-24 15:03:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(652, 42, NULL, '2024-03-24 15:04:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(653, 42, NULL, '2024-03-24 15:07:44', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(654, 42, NULL, '2024-03-24 15:07:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(655, 42, NULL, '2024-03-24 15:08:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(656, 42, NULL, '2024-03-24 15:08:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(657, 42, NULL, '2024-03-24 15:09:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(658, 42, NULL, '2024-03-24 15:10:16', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(659, 42, NULL, '2024-03-24 15:10:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(660, 42, NULL, '2024-03-24 15:11:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(661, 42, NULL, '2024-03-24 15:13:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(662, 42, NULL, '2024-03-24 15:14:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(663, 42, NULL, '2024-03-24 15:14:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(664, 42, NULL, '2024-03-24 15:44:45', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(665, 42, NULL, '2024-03-25 08:20:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(666, 42, NULL, '2024-03-25 08:31:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(667, 42, NULL, '2024-03-25 08:41:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(668, 42, NULL, '2024-03-25 08:54:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(669, 42, NULL, '2024-03-25 09:04:10', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(670, 42, NULL, '2024-03-25 09:04:45', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(671, 42, NULL, '2024-03-25 13:07:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(672, 42, NULL, '2024-03-25 13:14:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(673, 42, NULL, '2024-03-25 13:25:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(674, 42, NULL, '2024-03-25 13:25:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(675, 42, NULL, '2024-03-25 13:25:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(676, 42, NULL, '2024-03-25 13:26:17', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(677, 42, NULL, '2024-03-25 13:27:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(678, 42, NULL, '2024-03-25 13:27:55', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(679, 42, NULL, '2024-03-25 13:28:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(680, 42, NULL, '2024-03-25 13:28:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(681, 42, NULL, '2024-03-25 13:28:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(682, 42, NULL, '2024-03-25 13:28:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(683, 42, NULL, '2024-03-25 13:28:55', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(684, 42, NULL, '2024-03-25 13:29:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(685, 42, NULL, '2024-03-25 13:29:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(686, 42, NULL, '2024-03-25 13:30:17', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(687, 42, NULL, '2024-03-25 13:30:42', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(688, 42, NULL, '2024-03-25 13:30:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(689, 42, NULL, '2024-03-25 14:05:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(690, 42, NULL, '2024-03-25 14:05:46', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(691, 42, NULL, '2024-03-25 14:05:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(692, 42, NULL, '2024-03-25 14:06:17', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(693, 42, NULL, '2024-03-25 14:06:44', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(694, 42, NULL, '2024-03-25 14:37:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(695, 42, NULL, '2024-03-25 14:40:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(696, 42, NULL, '2024-03-25 14:40:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(697, 42, NULL, '2024-03-25 14:40:53', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(698, 42, NULL, '2024-03-25 14:40:57', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(699, 42, NULL, '2024-03-25 14:41:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(700, 42, NULL, '2024-03-25 14:44:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(701, 42, NULL, '2024-03-25 14:44:40', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(702, 42, NULL, '2024-03-25 14:44:47', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(703, 42, NULL, '2024-03-25 14:50:40', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(704, 42, NULL, '2024-03-25 14:50:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(705, 42, NULL, '2024-03-25 14:51:05', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(706, 42, NULL, '2024-03-25 14:51:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(707, 42, NULL, '2024-03-25 14:51:26', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(708, 42, NULL, '2024-03-25 14:51:37', 'account_crud', 'user is deleted image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(709, 42, NULL, '2024-03-25 14:51:41', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(710, 42, NULL, '2024-03-25 14:53:18', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(711, 42, NULL, '2024-03-25 14:53:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(712, 42, NULL, '2024-03-25 15:27:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(713, 42, NULL, '2024-03-25 15:27:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(714, 42, NULL, '2024-03-25 15:27:50', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(715, 42, NULL, '2024-03-25 15:27:57', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(716, 42, NULL, '2024-03-25 15:28:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(717, 42, NULL, '2024-03-25 15:28:35', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(718, 57, NULL, '2024-03-25 15:29:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(719, 42, NULL, '2024-03-25 15:29:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(720, 57, NULL, '2024-03-25 15:29:26', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(721, 42, NULL, '2024-03-25 15:29:26', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(722, 42, NULL, '2024-03-25 15:29:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(723, 42, NULL, '2024-03-25 15:30:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(724, 42, NULL, '2024-03-25 15:35:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(725, 42, NULL, '2024-03-25 15:35:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(726, 42, NULL, '2024-03-25 15:36:08', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(727, 42, NULL, '2024-03-25 15:36:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(728, 42, NULL, '2024-03-25 15:44:08', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(729, 42, NULL, '2024-03-25 15:55:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(730, 57, NULL, '2024-03-25 16:41:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(731, 42, NULL, '2024-03-26 06:56:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(732, 42, NULL, '2024-03-26 06:56:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(733, 42, NULL, '2024-03-26 06:57:13', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(734, 42, NULL, '2024-03-26 06:57:33', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(735, 42, NULL, '2024-03-26 06:57:59', 'account_crud', 'user is changed name', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(736, 42, NULL, '2024-03-26 06:58:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(737, 42, NULL, '2024-03-26 06:58:08', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(738, 42, NULL, '2024-03-26 06:58:18', 'account_crud', 'user is changed name', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(739, 42, NULL, '2024-03-26 06:58:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(740, 42, NULL, '2024-03-26 06:58:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(741, 42, NULL, '2024-03-26 06:59:01', 'account_crud', 'user is changed password', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(742, 42, NULL, '2024-03-26 06:59:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(743, 42, NULL, '2024-03-26 06:59:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(744, 42, NULL, '2024-03-26 06:59:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(745, 42, NULL, '2024-03-26 06:59:26', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(746, 42, NULL, '2024-03-26 06:59:47', 'account_crud', 'user is changed password', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(747, 42, NULL, '2024-03-26 06:59:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(748, 42, NULL, '2024-03-26 07:01:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(749, 42, NULL, '2024-03-26 07:01:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(750, 42, NULL, '2024-03-26 07:01:28', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(751, 42, NULL, '2024-03-26 07:01:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(752, 42, NULL, '2024-03-26 07:01:44', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(753, 42, NULL, '2024-03-26 07:01:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(754, 42, NULL, '2024-03-26 07:02:10', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(755, 57, NULL, '2024-03-27 08:53:09', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(756, 57, NULL, '2024-03-27 10:24:31', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(757, 42, NULL, '2024-03-29 12:07:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(758, 57, NULL, '2024-03-30 00:00:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(759, 42, NULL, '2024-04-05 11:42:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(760, 42, NULL, '2024-04-05 12:57:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(761, 42, NULL, '2024-04-05 13:00:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(762, 42, NULL, '2024-04-05 13:02:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(763, 42, NULL, '2024-04-05 14:35:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(764, 42, NULL, '2024-04-05 14:45:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(765, 42, NULL, '2024-04-05 14:46:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(766, 42, NULL, '2024-04-05 15:05:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(767, 42, NULL, '2024-04-05 15:42:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(768, 42, NULL, '2024-04-05 15:42:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(769, 42, NULL, '2024-04-05 15:43:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(770, 42, NULL, '2024-04-05 15:59:56', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(771, 48, NULL, '2024-04-05 16:00:40', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(772, 58, NULL, '2024-04-05 16:00:57', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(773, 58, NULL, '2024-04-05 16:01:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(774, 42, NULL, '2024-04-05 22:07:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(775, 42, NULL, '2024-04-06 02:52:12', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(776, 42, NULL, '2024-04-06 03:04:28', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(777, 42, NULL, '2024-04-07 03:44:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(778, 42, NULL, '2024-04-07 03:58:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(779, 42, NULL, '2024-04-07 04:56:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(780, 42, NULL, '2024-04-07 05:50:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(781, 42, NULL, '2024-04-07 05:51:48', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(782, 42, NULL, '2024-04-07 06:06:38', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(783, 42, NULL, '2024-04-07 06:44:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(784, 42, NULL, '2024-04-07 06:44:47', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(785, 42, NULL, '2024-04-07 07:40:19', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(786, 42, NULL, '2024-04-07 07:59:16', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(787, 42, NULL, '2024-04-07 09:47:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(788, 42, NULL, '2024-04-07 12:06:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(789, 42, NULL, '2024-04-07 19:41:42', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(790, 42, NULL, '2024-04-09 01:00:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(791, 42, NULL, '2024-04-09 01:27:16', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(792, 42, NULL, '2024-04-09 03:37:54', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(793, 42, NULL, '2024-04-09 06:52:38', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(794, 42, NULL, '2024-04-09 08:07:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(795, 42, NULL, '2024-04-09 08:59:13', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(796, 42, NULL, '2024-04-09 10:00:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(797, 42, NULL, '2024-04-11 00:56:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(798, 42, NULL, '2024-04-11 01:51:40', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(799, 42, NULL, '2024-04-11 03:03:56', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(800, 42, NULL, '2024-04-11 04:03:52', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(801, 42, NULL, '2024-04-11 04:04:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(802, 42, NULL, '2024-04-11 04:05:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(803, 42, NULL, '2024-04-11 04:06:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(804, 42, NULL, '2024-04-11 04:32:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(805, 42, NULL, '2024-04-11 04:33:35', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(806, 42, NULL, '2024-04-12 00:36:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(807, 42, NULL, '2024-04-12 00:41:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(808, 42, NULL, '2024-04-12 00:58:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(809, 42, NULL, '2024-04-12 01:20:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(810, 45, NULL, '2024-04-12 04:17:59', 'account_crud', 'user is changed name', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(811, 42, NULL, '2024-04-12 05:03:28', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(812, 42, NULL, '2024-04-12 05:14:41', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(813, 42, NULL, '2024-04-12 05:24:52', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(814, 42, NULL, '2024-04-12 05:29:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(815, 42, NULL, '2024-04-12 05:30:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(816, 42, NULL, '2024-04-12 05:38:40', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(817, 42, NULL, '2024-04-12 05:54:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(818, 42, NULL, '2024-04-12 05:57:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(819, 42, NULL, '2024-04-12 06:00:56', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(820, 42, NULL, '2024-04-12 07:45:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(821, 42, NULL, '2024-04-12 07:48:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(822, 42, NULL, '2024-04-12 07:57:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(823, 42, NULL, '2024-04-12 08:02:31', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(824, 42, NULL, '2024-04-12 08:06:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(825, 42, NULL, '2024-04-12 08:06:52', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(826, 42, NULL, '2024-04-12 09:14:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(827, 42, NULL, '2024-04-12 09:18:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(828, 42, NULL, '2024-04-12 10:12:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(829, 42, NULL, '2024-04-12 10:15:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(830, 42, NULL, '2024-04-12 10:16:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(831, 42, NULL, '2024-04-12 10:19:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(832, 42, NULL, '2024-04-12 10:20:16', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(833, 42, NULL, '2024-04-12 10:21:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(834, 42, NULL, '2024-04-12 10:23:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(835, 42, NULL, '2024-04-12 10:25:52', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(836, 42, NULL, '2024-04-12 10:27:13', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(837, 42, NULL, '2024-04-12 10:28:10', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(838, 42, NULL, '2024-04-12 10:29:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(839, 42, NULL, '2024-04-12 10:35:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(840, 42, NULL, '2024-04-12 10:39:31', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(841, 42, NULL, '2024-04-12 10:54:42', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(842, 42, NULL, '2024-04-12 10:57:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(843, 42, NULL, '2024-04-12 11:04:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(844, 42, NULL, '2024-04-12 11:19:28', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(845, 42, NULL, '2024-04-12 11:20:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(846, 42, NULL, '2024-04-12 11:21:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(847, 42, NULL, '2024-04-12 11:21:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(848, 42, NULL, '2024-04-12 11:22:08', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(849, 42, NULL, '2024-04-12 11:32:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(850, 42, NULL, '2024-04-12 11:39:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(851, 42, NULL, '2024-04-12 11:42:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(852, 42, NULL, '2024-04-12 11:47:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(853, 42, NULL, '2024-04-13 00:10:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(854, 42, NULL, '2024-04-13 00:29:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(855, 42, NULL, '2024-04-13 00:35:32', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(856, 42, NULL, '2024-04-13 00:45:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(857, 42, NULL, '2024-04-13 00:46:17', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(858, 42, NULL, '2024-04-13 00:50:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(859, 42, NULL, '2024-04-13 01:03:35', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(860, 42, NULL, '2024-04-13 01:23:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(861, 42, NULL, '2024-04-13 01:34:47', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(862, 42, NULL, '2024-04-13 01:39:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(863, 42, NULL, '2024-04-13 01:50:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(864, 42, NULL, '2024-04-13 01:52:32', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(865, 42, NULL, '2024-04-13 02:28:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(866, 42, NULL, '2024-04-13 02:29:13', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(867, 42, NULL, '2024-04-13 02:29:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(868, 42, NULL, '2024-04-13 02:33:08', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(869, 42, NULL, '2024-04-13 02:33:35', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(870, 42, NULL, '2024-04-13 02:34:53', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(871, 42, NULL, '2024-04-13 02:35:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(872, 42, NULL, '2024-04-13 02:39:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(873, 42, NULL, '2024-04-13 02:44:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(874, 42, NULL, '2024-04-13 02:46:41', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(875, 42, NULL, '2024-04-13 02:54:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(876, 42, NULL, '2024-04-13 02:56:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(877, 42, NULL, '2024-04-13 02:58:31', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(878, 42, NULL, '2024-04-13 02:58:48', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(879, 42, NULL, '2024-04-13 02:58:58', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(880, 42, NULL, '2024-04-13 03:01:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(881, 42, NULL, '2024-04-13 03:01:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(882, 42, NULL, '2024-04-13 03:01:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(883, 42, NULL, '2024-04-13 03:01:00', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(884, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(885, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(886, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(887, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(888, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(889, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(890, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(891, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(892, 42, NULL, '2024-04-13 03:01:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(893, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(894, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(895, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(896, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(897, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(898, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(899, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(900, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(901, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(902, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(903, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(904, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(905, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(906, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(907, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(908, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(909, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(910, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(911, 42, NULL, '2024-04-13 03:01:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(912, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(913, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(914, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(915, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(916, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(917, 42, NULL, '2024-04-13 03:01:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(918, 42, NULL, '2024-04-13 03:46:53', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(919, 42, NULL, '2024-04-13 03:47:13', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(920, 42, NULL, '2024-04-13 03:56:17', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(921, 42, NULL, '2024-04-13 09:19:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(922, 42, NULL, '2024-04-13 16:09:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(923, 42, NULL, '2024-04-13 16:50:58', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(924, 42, NULL, '2024-04-13 23:32:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(925, 42, NULL, '2024-04-14 00:10:24', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(926, 42, NULL, '2024-04-14 00:25:57', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(927, 42, NULL, '2024-04-14 03:56:08', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(928, 42, NULL, '2024-04-14 04:04:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(929, 42, NULL, '2024-04-14 04:07:09', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(930, 42, NULL, '2024-04-14 04:14:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(931, 42, NULL, '2024-04-14 11:10:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(932, 61, NULL, '2024-04-14 14:21:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(933, 42, NULL, '2024-04-14 16:18:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(934, 42, NULL, '2024-04-14 16:20:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(935, 42, NULL, '2024-04-14 18:49:23', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(936, 42, NULL, '2024-04-14 18:56:10', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(937, 42, NULL, '2024-04-14 18:57:14', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(938, 42, NULL, '2024-04-14 18:57:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(939, 42, NULL, '2024-04-14 18:58:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(940, 42, NULL, '2024-04-14 19:05:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(941, 42, NULL, '2024-04-14 19:05:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(942, 42, NULL, '2024-04-14 19:05:50', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(943, 42, NULL, '2024-04-14 19:16:09', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(944, 42, NULL, '2024-04-14 19:20:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(945, 42, NULL, '2024-04-14 19:24:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(946, 42, NULL, '2024-04-14 19:24:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(947, 42, NULL, '2024-04-14 19:24:33', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(948, 42, NULL, '2024-04-14 20:07:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(949, 42, NULL, '2024-04-14 20:36:04', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(950, 42, NULL, '2024-04-15 03:44:55', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(951, 42, NULL, '2024-04-15 03:48:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(952, 42, NULL, '2024-04-15 03:54:10', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(953, 42, NULL, '2024-04-15 04:20:39', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(954, 42, NULL, '2024-04-15 04:21:05', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(955, 42, NULL, '2024-04-15 04:21:27', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(956, 42, NULL, '2024-04-15 04:22:32', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(957, 42, NULL, '2024-04-15 04:26:48', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(958, 45, NULL, '2024-04-15 04:27:29', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(959, 45, NULL, '2024-04-15 04:28:26', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(960, 45, NULL, '2024-04-15 04:28:48', 'account_crud', 'user is changed image', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(961, 45, NULL, '2024-04-15 04:29:22', 'account_crud', 'user is changed name', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(962, 45, NULL, '2024-04-15 04:29:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(963, 45, NULL, '2024-04-15 04:29:42', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(964, 45, NULL, '2024-04-15 07:15:01', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(965, 45, NULL, '2024-04-15 07:17:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(966, 45, NULL, '2024-04-15 07:17:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(967, 42, NULL, '2024-04-15 07:19:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(968, 58, NULL, '2024-04-15 07:21:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(969, 58, NULL, '2024-04-15 07:21:34', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(970, 42, NULL, '2024-04-15 10:30:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(971, 58, NULL, '2024-04-15 11:06:48', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(972, 58, NULL, '2024-04-15 11:07:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(973, 58, NULL, '2024-04-15 11:07:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(974, 58, NULL, '2024-04-15 11:07:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(975, 58, NULL, '2024-04-15 11:08:21', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(976, 58, NULL, '2024-04-15 11:09:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(977, 58, NULL, '2024-04-15 11:12:19', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(978, 58, NULL, '2024-04-15 11:13:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(979, 42, NULL, '2024-04-15 11:23:42', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(980, 58, NULL, '2024-04-15 11:35:37', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(981, 42, NULL, '2024-04-15 23:58:19', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(982, 42, NULL, '2024-04-16 00:23:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(983, 42, NULL, '2024-04-16 00:26:15', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(984, 45, NULL, '2024-04-16 00:54:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(985, 42, NULL, '2024-04-16 01:28:22', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(986, 42, NULL, '2024-04-16 01:46:51', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(987, 42, NULL, '2024-04-16 02:51:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(988, 42, NULL, '2024-04-16 02:53:25', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(989, 42, NULL, '2024-04-16 02:58:28', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(990, 42, NULL, '2024-04-16 03:05:32', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(991, 42, NULL, '2024-04-16 03:05:46', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(992, 42, NULL, '2024-04-16 03:07:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(993, 45, NULL, '2024-04-16 03:57:07', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(994, 45, NULL, '2024-04-16 06:22:38', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(995, 45, NULL, '2024-04-16 10:57:02', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(996, 45, NULL, '2024-04-16 11:09:31', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(997, 42, NULL, '2024-04-16 13:41:45', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(998, 42, NULL, '2024-04-16 13:43:36', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(999, 42, NULL, '2024-04-16 13:46:20', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1000, 42, NULL, '2024-04-16 13:50:44', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1001, 42, NULL, '2024-04-16 14:00:55', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1002, 42, NULL, '2024-04-16 14:12:53', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1003, 42, NULL, '2024-04-16 14:14:18', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1004, 42, NULL, '2024-04-16 14:16:59', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1005, 42, NULL, '2024-04-16 14:18:30', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1006, 42, NULL, '2024-04-16 14:19:09', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1007, 42, NULL, '2024-04-16 14:20:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1008, 42, NULL, '2024-04-16 14:20:43', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1009, 42, NULL, '2024-04-16 14:23:49', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1010, 42, NULL, '2024-04-16 14:28:56', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1011, 42, NULL, '2024-04-16 14:37:06', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1012, 42, NULL, '2024-04-16 15:17:11', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1013, 45, NULL, '2024-04-16 16:17:57', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL),
(1014, 42, NULL, '2024-04-16 23:41:03', 'page_view', 'user is view home page', NULL, NULL, NULL, 0, NULL, 'android', NULL);

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
(23, 51, '453121', 'create_email', '2024-03-21 16:23:27'),
(24, 52, '431541', 'create_email', '2024-03-21 16:24:15'),
(26, 54, '596884', 'create_email', '2024-03-21 16:56:00'),
(27, 55, '664859', 'create_email', '2024-03-21 16:56:21'),
(28, 56, '966646', 'create_email', '2024-03-21 16:57:07'),
(30, 59, '800506', 'create_email', '2024-04-07 02:51:45');

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
  ADD KEY `activity_direction_id` (`activity_direction_id`),
  ADD KEY `activity_reply_on` (`activity_reply_on`);

--
-- Indexes for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  ADD PRIMARY KEY (`direction_id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`direction_address`,`inside_direction_id`) USING BTREE,
  ADD KEY `direction_in_direction_id` (`inside_direction_id`);

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
  ADD PRIMARY KEY (`action_id`) USING BTREE,
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
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `app_features`
--
ALTER TABLE `app_features`
  MODIFY `feature_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `group_activity`
--
ALTER TABLE `group_activity`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `group_activity_direction`
--
ALTER TABLE `group_activity_direction`
  MODIFY `direction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `group_deails`
--
ALTER TABLE `group_deails`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1015;

--
-- AUTO_INCREMENT for table `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `verification_codes`
--
ALTER TABLE `verification_codes`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  ADD CONSTRAINT `group_activity_direction_ibfk_2` FOREIGN KEY (`inside_direction_id`) REFERENCES `group_activity_direction` (`direction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
