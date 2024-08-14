-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2024 at 03:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `deposit`
--

CREATE TABLE `deposit` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `account_type` varchar(50) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deposited_amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deposit`
--

INSERT INTO `deposit` (`id`, `name`, `account_number`, `account_type`, `transaction_type`, `created_at`, `deposited_amount`) VALUES
(1, 'Abdul hanan', 'B2754215209', 'business', 'Deposit', '2024-08-02 09:46:25', 10000),
(2, 'Abdul hanan', 'B2754215209', 'business', 'Deposit', '2024-08-02 09:46:45', 10000),
(3, 'Abdul hanan', 'B2754215209', 'business', 'Withdraw', '2024-08-02 09:47:04', 20000),
(4, 'Abdul hanan', 'B2754215209', 'business', 'Deposit', '2024-08-05 02:27:24', 120000),
(5, 'Abdul hanan', 'B2754215209', 'business', 'Withdraw', '2024-08-05 02:27:59', 1200);

-- --------------------------------------------------------

--
-- Table structure for table `recurring_payments`
--

CREATE TABLE `recurring_payments` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `setup_datetime` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recurring_payments`
--

INSERT INTO `recurring_payments` (`id`, `payment_type`, `details`, `amount`, `setup_datetime`, `created_at`) VALUES
(1, 'Subscription', 'Monthly Mobile Package ', 800.00, '2024-07-22 03:22:00', '2024-07-22 10:17:52'),
(2, 'Utility Bill', 'mdifjeoif', 1200.00, '2024-07-31 03:22:00', '2024-07-22 10:22:16'),
(3, 'Other', ' x zn znjnsn jasn,jsn,', 2300.00, '2024-08-14 03:00:00', '2024-08-02 10:00:31');

-- --------------------------------------------------------

--
-- Table structure for table `service_requests`
--

CREATE TABLE `service_requests` (
  `id` int(11) NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `additional_details` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_requests`
--

INSERT INTO `service_requests` (`id`, `service_type`, `additional_details`, `created_at`) VALUES
(1, 'Checkbook', 'Hello i want checkbook within 15 days', '2024-07-22 08:03:22'),
(2, 'Debit Card', 'I want visa card which has limit of 120k per day', '2024-07-22 08:04:52'),
(3, 'Credit Card', 'ffyty', '2024-07-23 11:29:28'),
(4, 'Debit Card', 'hbkkj', '2024-07-23 11:29:44'),
(5, 'Checkbook', 'i want checkbook within 15 days', '2024-07-23 11:31:04'),
(6, 'Checkbook', '	i want checkbook within 15 days', '2024-07-23 11:31:38'),
(7, 'Checkbook', 'i want the checkbook', '2024-07-25 08:19:19'),
(8, 'Debit Card', 'thusnbh', '2024-08-02 09:59:29');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `sender_account` varchar(20) NOT NULL,
  `recipient_account` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('Deposit','Withdraw','Transfer') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `sender_account`, `recipient_account`, `amount`, `transaction_type`, `created_at`) VALUES
(1, 'B8444932665', 'P8107314754', 600.00, 'Transfer', '2024-07-22 06:13:19'),
(2, 'B8444932665', 'P8107314754', 400.00, 'Transfer', '2024-07-22 06:36:58'),
(3, 'P8107314754', 'P8107314754', 20000.00, 'Transfer', '2024-07-23 10:52:44'),
(4, 'P8107314754', 'B8444932665', 20000.00, 'Transfer', '2024-07-23 10:58:39'),
(5, 'P8107314754', 'B8444932665', 8000.00, 'Transfer', '2024-07-23 11:21:33'),
(6, 'B2754215209', 'P4323055489', 20000.00, 'Transfer', '2024-08-02 09:51:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `father_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `balance` double NOT NULL DEFAULT 0,
  `account_type` varchar(50) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `father_name`, `address`, `mobile_number`, `email`, `password`, `balance`, `account_type`, `account_number`, `bank_name`, `created_at`) VALUES
(1, 'Abdul hanan', 'M Ilyas ', 'mohallah haiderabad khushab', '3240356159', 'abdulhanaaan123@gmail.com', '$2y$10$t6vurQS5TaC/rMO9pBBrc.JipSPXJL1A6GBxP.KS/fRbyvyWTeVXC', 168800, 'business', 'B2754215209', 'United Bank', '2024-08-02 09:44:00'),
(2, 'ubaid Ul Rehman', 'M Khalil', 'mohallah haiderabad khushab', '3021651249', 'pierrec071@gmail.com', '$2y$10$fLypEKXQdPiZhvmqIggCh.bJaSU5EXynd5ro152jCyfVvcRv/b8zK', 40000, 'personal', 'P4323055489', 'United Bank', '2024-08-02 09:50:17'),
(3, 'John Doe', '', '', '', 'test@example.com', '', 1000, 'Savings', '123456789', '', '2024-08-02 10:59:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deposit`
--
ALTER TABLE `deposit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recurring_payments`
--
ALTER TABLE `recurring_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `account_number` (`account_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deposit`
--
ALTER TABLE `deposit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `recurring_payments`
--
ALTER TABLE `recurring_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service_requests`
--
ALTER TABLE `service_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
