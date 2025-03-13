CREATE TABLE `alresultdetails` (
  `id` int(11) NOT NULL,
  `alResultId` varchar(50) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL
);

CREATE TABLE `alresults` (
  `id` varchar(50) NOT NULL,
  `school` varchar(255) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `indexNumber` varchar(20) DEFAULT NULL,
  `zScore` varchar(10) DEFAULT NULL,
  `studentId` varchar(50) DEFAULT NULL
);

CREATE TABLE `emergencycontact` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `studentId` varchar(50) DEFAULT NULL
);

CREATE TABLE `olresultdetails` (
  `id` int(11) NOT NULL,
  `olResultId` varchar(50) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL
);

CREATE TABLE `olresults` (
  `id` varchar(50) NOT NULL,
  `school` varchar(255) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `indexNumber` varchar(20) DEFAULT NULL,
  `studentId` varchar(50) DEFAULT NULL
);

CREATE TABLE `otherqualifications` (
  `id` int(11) NOT NULL,
  `course` varchar(255) DEFAULT NULL,
  `nvqLevel` varchar(10) DEFAULT NULL,
  `institute` varchar(255) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `studentId` varchar(50) DEFAULT NULL
);

CREATE TABLE `referees` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `studentId` varchar(50) DEFAULT NULL
);

CREATE TABLE `student` (
  `id` varchar(50) NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `nameWithInitials` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `gramaSevaka` varchar(100) DEFAULT NULL,
  `nic` varchar(20) DEFAULT NULL
);

ALTER TABLE `alresultdetails`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `alresults`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `emergencycontact`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `olresultdetails`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `olresults`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `otherqualifications`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `referees`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `alresultdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `emergencycontact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `olresultdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `otherqualifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `referees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
