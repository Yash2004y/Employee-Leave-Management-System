-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2023 at 02:12 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elms`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `emailId`, `pass`, `createdAt`) VALUES
(1, 'Yash Chauhan', 'yash@gmail.com', 'yash@1234', '2023-11-26 13:29:16'),
(2, 'Nikul Hirani', 'nikul@gmail.com', 'nikul@1234', '2023-11-27 08:18:24');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `deptId` int(5) NOT NULL,
  `deptName` varchar(50) NOT NULL,
  `deptShortName` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`deptId`, `deptName`, `deptShortName`, `createdAt`) VALUES
(1, 'Human Resource', 'HR', '2023-11-26 13:07:45'),
(2, 'Information Technology', 'IT', '2023-11-26 13:10:57'),
(3, 'Finance', 'FN', '2023-11-26 13:11:26'),
(4, 'Management', 'MGMT', '2023-11-26 13:11:41'),
(5, 'Marketing', 'MK', '2023-11-26 13:11:56'),
(6, 'Research', 'RS', '2023-11-26 13:12:17'),
(7, 'Sales', 'SL', '2023-11-26 13:12:38');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `eid` int(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `deptId` int(5) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `address` longtext NOT NULL,
  `mobileNo` varchar(10) NOT NULL,
  `password` varchar(50) NOT NULL,
  `regDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `img` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`eid`, `name`, `emailId`, `deptId`, `gender`, `dob`, `address`, `mobileNo`, `password`, `regDate`, `img`) VALUES
(1, 'Yash Chauhan', 'yc266014@gmail.com', 2, 'Male', '2004-08-24', '36, B/H Mer\'s Hospital, Chamunda Park Society, Limbdi, 363421', '8156060143', 'yash@1234', '2023-11-26 13:16:32', '27470333_7309693-depositphotos-bgremover.png'),
(2, 'Nikul Hirani', 'nikul2004@gmail.com', 5, 'Male', '2004-09-23', '36, B/H Mer\'s Hospital, Limbdi , 363421', '9904136220', 'nikul@1234', '2023-11-28 09:47:16', '27470334_7309681-depositphotos-bgremover.png');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` int(5) NOT NULL,
  `leaveTypeId` int(5) NOT NULL,
  `toDate` date NOT NULL,
  `fromDate` date NOT NULL,
  `description` longtext NOT NULL,
  `postingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminRemark` longtext DEFAULT NULL,
  `adminRemarkDate` date DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `isRead` int(11) NOT NULL DEFAULT 0,
  `eid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`id`, `leaveTypeId`, `toDate`, `fromDate`, `description`, `postingDate`, `adminRemark`, `adminRemarkDate`, `status`, `isRead`, `eid`) VALUES
(1, 1, '2023-11-28', '2023-11-28', 'NA', '2023-11-28 05:52:43', 'You Take Care For life', '2023-11-30', 2, 1, 1),
(2, 7, '2024-01-09', '2023-12-27', '', '2023-11-28 09:19:32', NULL, NULL, 1, 0, 1),
(3, 8, '2024-01-03', '2023-12-01', 'For Go To Foregin', '2023-11-30 04:42:39', 'Sorry, Your Leave Not Approved', '2023-11-30', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `leavetypes`
--

CREATE TABLE `leavetypes` (
  `leaveTypeId` int(5) NOT NULL,
  `leaveType` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leavetypes`
--

INSERT INTO `leavetypes` (`leaveTypeId`, `leaveType`, `description`, `createdAt`) VALUES
(1, 'Medical Leave', 'Related To Health Problems of Employee', '2023-11-26 13:18:24'),
(2, 'Casual Leave', 'Provided for urgent matters to the employees.', '2023-11-26 13:19:57'),
(3, 'Paternity Leave', 'To take care of newborns', '2023-11-26 13:20:28'),
(4, 'Adverse Weather Leave', 'In terms of extreme weather conditions', '2023-11-26 13:21:15'),
(5, 'Compensatory Leave', 'For Overtime workers', '2023-11-26 13:21:54'),
(6, 'Half-day Leave', 'This Leave For Half day Leave', '2023-11-26 13:24:07'),
(7, 'Marriage Leave', 'This Leave allows employees to get paid when they get married.', '2023-11-26 13:25:08'),
(8, 'Privilege Leave', 'The PL leave type is typically used for personal reasons. such as vacation etc', '2023-11-26 13:26:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`deptId`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`eid`),
  ADD UNIQUE KEY `emailId` (`emailId`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leavetypes`
--
ALTER TABLE `leavetypes`
  ADD PRIMARY KEY (`leaveTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `deptId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `eid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `leavetypes`
--
ALTER TABLE `leavetypes`
  MODIFY `leaveTypeId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
