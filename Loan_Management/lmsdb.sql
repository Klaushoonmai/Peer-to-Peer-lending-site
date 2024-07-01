-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2022 at 12:37 PM
-- Server version: 8.0.21
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


--
-- Database: `lmsdb`
--
create database lmsdb;
use lmsdb;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `releaseloan` (`id` INT)  BEGIN
declare months,rpenalty,loan_id,plan_id,loanamount,i int;
declare rate float;
declare amount,penalty,amtwithpnl decimal;
declare duedate date;
SELECT ifnull(max(l.loan_id),100000)+1 into loan_id from loan_list l;
select l.amount,l.plan_id into loanamount,plan_id from loan_list l where l.id=id;
select p.months,p.perc,p.penalty into months,rate,rpenalty from loan_plan p where p.id=plan_id;

set amount=(loanamount*rate)/(months*100);
set penalty=(amount*rpenalty)/100;
set i=1;
while i<=months do
	select date_add(date(now()),INTERVAL i MONTH) into duedate;
	select loan_id;
	insert into loan_schedules(loan_id,date_due,iamount,penalty,withpenalty) 
    values(loan_id,duedate,amount,penalty,amount+penalty);
	set i=i+1;
end while;

update loan_list l set status='Released',l.loan_id=loan_id,date_released=date(now()) where l.id=id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `borrowers`
--

CREATE TABLE `borrowers` (
  `id` int NOT NULL,
  `fname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `pan` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `borrowers`
--

INSERT INTO `borrowers` (`id`, `fname`, `lname`, `phone`, `address`, `email`, `gender`, `dob`, `pan`, `date_created`) VALUES
(5, 'Kartik', 'Tyagi', '9865656566', 'Noida', 'kartik@gmail.com', 'M', NULL, 'ABCDE12345', '2024-01-01 14:02:05'),
(6, 'Anil', 'Kapoor', '9896565856', 'Faridabad', 'anilkapoor@gmail.com', 'M', NULL, 'XXXXX1234X', '2024-01-01 14:03:05'),
(8, 'Shivam', 'Panwar', '9865665656', 'Noida', 'shivam@gmail.com', 'M', NULL, 'AAAAA1234X', '2024-01-01 18:37:48');

-- --------------------------------------------------------

--
-- Table structure for table `loan_list`
--

CREATE TABLE `loan_list` (
  `id` int NOT NULL,
  `type_id` int DEFAULT NULL,
  `borrower_id` int DEFAULT NULL,
  `purpose` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `plan_id` int NOT NULL,
  `loan_id` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Unapproved',
  `date_released` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `loan_list`
--

INSERT INTO `loan_list` (`id`, `type_id`, `borrower_id`, `purpose`, `amount`, `plan_id`, `loan_id`, `status`, `date_released`, `date_created`) VALUES
(7, 1, 5, 'Test Purpose', 100000, 7, 100004, 'Released', '2021-08-01 00:00:00', '2021-08-01 15:38:00'),
(8, 3, 6, 'Test Purpose', 200000, 6, 100001, 'Released', '2021-08-01 00:00:00', '2021-08-01 15:43:19'),
(9, 1, 6, 'test', 120000, 6, 100003, 'Released', '2021-08-01 00:00:00', '2021-08-01 18:15:01'),
(10, 2, 5, 'test', 150000, 7, 100002, 'Released', '2021-08-01 00:00:00', '2021-08-01 18:19:49'),
(11, 5, 8, 'Education for higher studies', 240000, 8, 100005, 'Released', '2021-08-01 00:00:00', '2021-08-01 18:38:49');

-- --------------------------------------------------------

--
-- Table structure for table `loan_plan`
--

CREATE TABLE `loan_plan` (
  `id` int NOT NULL,
  `months` int NOT NULL,
  `perc` float NOT NULL,
  `penalty` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `loan_plan`
--

INSERT INTO `loan_plan` (`id`, `months`, `perc`, `penalty`) VALUES
(6, 12, 20, 10),
(7, 6, 10, 5),
(8, 18, 10, 20);

-- --------------------------------------------------------

--
-- Table structure for table `loan_schedules`
--

CREATE TABLE `loan_schedules` (
  `id` int NOT NULL,
  `loan_id` int NOT NULL,
  `date_due` date NOT NULL,
  `iamount` decimal(14,2) NOT NULL,
  `penalty` decimal(7,2) NOT NULL,
  `withpenalty` decimal(14,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `loan_schedules`
--

INSERT INTO `loan_schedules` (`id`, `loan_id`, `date_due`, `iamount`, `penalty`, `withpenalty`) VALUES
(44, 100001, '2023-09-01', '3333.00', '333.00', '3666.00'),
(45, 100001, '2023-10-01', '3333.00', '333.00', '3666.00'),
(46, 100001, '2023-11-01', '3333.00', '333.00', '3666.00'),
(47, 100001, '2023-12-01', '3333.00', '333.00', '3666.00'),
(48, 100001, '2024-01-01', '3333.00', '333.00', '3666.00'),
(49, 100001, '2024-02-01', '3333.00', '333.00', '3666.00'),
(50, 100001, '2024-03-01', '3333.00', '333.00', '3666.00'),
(51, 100001, '2024-04-01', '3333.00', '333.00', '3666.00'),
(52, 100001, '2024-05-01', '3333.00', '333.00', '3666.00'),
(53, 100001, '2024-06-01', '3333.00', '333.00', '3666.00'),
(54, 100001, '2024-07-01', '3333.00', '333.00', '3666.00'),
(55, 100001, '2024-08-01', '3333.00', '333.00', '3666.00'),
(86, 100002, '2024-09-01', '2500.00', '125.00', '2625.00'),
(87, 100002, '2024-10-01', '2500.00', '125.00', '2625.00'),
(88, 100002, '2024-11-01', '2500.00', '125.00', '2625.00'),
(89, 100002, '2024-12-01', '2500.00', '125.00', '2625.00'),
(90, 100002, '2024-01-01', '2500.00', '125.00', '2625.00'),
(91, 100002, '2024-02-01', '2500.00', '125.00', '2625.00'),
(92, 100003, '2024-09-01', '2000.00', '200.00', '2200.00'),
(93, 100003, '2021-10-01', '2000.00', '200.00', '2200.00'),
(94, 100003, '2021-11-01', '2000.00', '200.00', '2200.00'),
(95, 100003, '2021-12-01', '2000.00', '200.00', '2200.00'),
(96, 100003, '2022-01-01', '2000.00', '200.00', '2200.00'),
(97, 100003, '2022-02-01', '2000.00', '200.00', '2200.00'),
(98, 100003, '2022-03-01', '2000.00', '200.00', '2200.00'),
(99, 100003, '2022-04-01', '2000.00', '200.00', '2200.00'),
(100, 100003, '2022-05-01', '2000.00', '200.00', '2200.00'),
(101, 100003, '2022-06-01', '2000.00', '200.00', '2200.00'),
(102, 100003, '2022-07-01', '2000.00', '200.00', '2200.00'),
(103, 100003, '2022-08-01', '2000.00', '200.00', '2200.00'),
(104, 100004, '2021-09-01', '1667.00', '83.00', '1750.00'),
(105, 100004, '2021-10-01', '1667.00', '83.00', '1750.00'),
(106, 100004, '2021-11-01', '1667.00', '83.00', '1750.00'),
(107, 100004, '2021-12-01', '1667.00', '83.00', '1750.00'),
(108, 100004, '2022-01-01', '1667.00', '83.00', '1750.00'),
(109, 100004, '2022-02-01', '1667.00', '83.00', '1750.00'),
(110, 100005, '2021-09-01', '1333.00', '267.00', '1600.00'),
(111, 100005, '2021-10-01', '1333.00', '267.00', '1600.00'),
(112, 100005, '2021-11-01', '1333.00', '267.00', '1600.00'),
(113, 100005, '2021-12-01', '1333.00', '267.00', '1600.00'),
(114, 100005, '2022-01-01', '1333.00', '267.00', '1600.00'),
(115, 100005, '2022-02-01', '1333.00', '267.00', '1600.00'),
(116, 100005, '2022-03-01', '1333.00', '267.00', '1600.00'),
(117, 100005, '2022-04-01', '1333.00', '267.00', '1600.00'),
(118, 100005, '2022-05-01', '1333.00', '267.00', '1600.00'),
(119, 100005, '2022-06-01', '1333.00', '267.00', '1600.00'),
(120, 100005, '2022-07-01', '1333.00', '267.00', '1600.00'),
(121, 100005, '2022-08-01', '1333.00', '267.00', '1600.00'),
(122, 100005, '2022-09-01', '1333.00', '267.00', '1600.00'),
(123, 100005, '2022-10-01', '1333.00', '267.00', '1600.00'),
(124, 100005, '2022-11-01', '1333.00', '267.00', '1600.00'),
(125, 100005, '2022-12-01', '1333.00', '267.00', '1600.00'),
(126, 100005, '2023-01-01', '1333.00', '267.00', '1600.00'),
(127, 100005, '2023-02-01', '1333.00', '267.00', '1600.00');

-- --------------------------------------------------------

--
-- Table structure for table `loan_types`
--

CREATE TABLE `loan_types` (
  `id` int NOT NULL,
  `type_name` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `loan_types`
--

INSERT INTO `loan_types` (`id`, `type_name`, `description`) VALUES
(1, 'Small Business', 'Small Business Loans'),
(2, 'Mortgages', 'Mortgages'),
(3, 'Personal Loans', 'Personal Loans'),
(4, 'Home Loan', 'Loan for getting Home'),
(5, 'Education Loan', 'Loan for Education');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `loan_id` int NOT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `penalty` float NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `loan_id`, `amount`, `penalty`, `date_created`) VALUES
(5, 100001, 3333, 0, '2024-01-01 18:04:32'),
(6, 100004, 1667, 0, '2024-01-01 18:24:45'),
(7, 100003, 2000, 0, '2024-01-01 18:24:53'),
(8, 100005, 1333, 0, '2024-01-01 18:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '1=admin , 2 = staff'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `userid`, `pwd`, `role`) VALUES
(1, 'Administrator', 'admin', 'admin123', 'Admin');
(2, 'User', 'user1', 'user1', 'user123', 'Staff');
--
-- Indexes for dumped tables
--

--
-- Indexes for table `borrowers`
--
ALTER TABLE `borrowers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_list`
--
ALTER TABLE `loan_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_plan`
--
ALTER TABLE `loan_plan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_types`
--
ALTER TABLE `loan_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrowers`
--
ALTER TABLE `borrowers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `loan_list`
--
ALTER TABLE `loan_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `loan_plan`
--
ALTER TABLE `loan_plan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `loan_types`
--
ALTER TABLE `loan_types`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
