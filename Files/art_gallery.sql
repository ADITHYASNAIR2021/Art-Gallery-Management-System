-- Specify the database to use
USE art_gallery;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;

-- Procedures
DELIMITER $$
DROP PROCEDURE IF EXISTS `display`$$
CREATE PROCEDURE `display` ()
BEGIN
    SELECT Cu.custid, gid, artid, fname, lname, dob, address, Co.PHONE
    FROM CUSTOMER Cu
    JOIN contacts Co ON Cu.custid = Co.CUSTID;
END$$

DROP PROCEDURE IF EXISTS `GetAge`$$
CREATE PROCEDURE `GetAge` ()
BEGIN 
    SELECT *, YEAR(CURRENT_DATE()) - YEAR(DOB) AS age FROM CUSTOMER;
END$$

DELIMITER ;

-- Table structure for table `artist`
-- Table structure for table `artist`
DROP TABLE IF EXISTS `artist`;
CREATE TABLE `artist` (
    `artistid` VARCHAR(20) NOT NULL,
    `gid` VARCHAR(20) DEFAULT NULL,
    `custid` VARCHAR(20) DEFAULT NULL,
    `eid` VARCHAR(20) DEFAULT NULL,
    `fname1` VARCHAR(25) DEFAULT NULL,
    `lname1` VARCHAR(25) DEFAULT NULL,
    `birthplace` VARCHAR(25) DEFAULT NULL,
    `style` VARCHAR(25) DEFAULT NULL,
    PRIMARY KEY (`artistid`),
    KEY `fk_gid` (`gid`),
    KEY `fk_custid` (`custid`),
    KEY `fk_eid` (`eid`),
    CONSTRAINT `fk_artist_gallery` FOREIGN KEY (`gid`) REFERENCES `gallery` (`gid`),
    CONSTRAINT `fk_artist_customer` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`),
    CONSTRAINT `fk_artist_exhibition` FOREIGN KEY (`eid`) REFERENCES `exhibition` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Dumping data for table `artist`
INSERT INTO `artist` (`artistid`, `gid`, `custid`, `eid`, `fname1`, `lname1`, `birthplace`, `style`) VALUES
('ART1', 'MM123', 'AT2000', 'AD22', 'Georgia', 'O Keeffe', 'USA', 'Oil on Canvas'),
('ART2', 'TLM123', 'AR1998', 'AD55', 'Pablo', 'Picasso', 'Spain', 'Analytic Cubism'),
('ART3', 'BM123', 'AD1998', 'AD88', 'Rembrandt', 'van Rijn', 'Netherlands', 'Oil Painting'),
('ART4', 'JG123', 'AM1994', 'AD00', 'Theodore', 'Chasseriau', 'France', 'Oil Painting'),
('ART5', 'NG123', 'PM1996', 'AD11', 'Leonardo', 'da Vinci', 'Italy', 'High Renaissance'),
('ART7', 'MM126', 'AR2022', 'H123', 'Mind', 'Hunter', 'Kathmandu', 'Oil Painting');

-- Table structure for table `artwork`
DROP TABLE IF EXISTS `artwork`;
CREATE TABLE `artwork` (
    `artid` VARCHAR(20) NOT NULL,
    `title` VARCHAR(50) DEFAULT NULL,
    `year` VARCHAR(4) DEFAULT NULL,
    `type_of_art` VARCHAR(20) DEFAULT NULL,
    `price` DECIMAL(15, 2) DEFAULT NULL,
    `eid` VARCHAR(20) DEFAULT NULL,
    `gid` VARCHAR(20) DEFAULT NULL,
    `artistid` VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (`artid`),
    KEY `eid` (`eid`),
    KEY `gid` (`gid`),
    KEY `artistid` (`artistid`),
    FOREIGN KEY (`eid`) REFERENCES `exhibition`(`eid`),
    FOREIGN KEY (`gid`) REFERENCES `gallery`(`gid`),
    FOREIGN KEY (`artistid`) REFERENCES `artist`(`artistid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `artwork`
INSERT INTO `artwork` (`artid`, `title`, `year`, `type_of_art`, `price`, `eid`, `gid`, `artistid`) VALUES
('AW12', 'Mona Lisa', '1503', 'Painting', '1000000000.00', 'G123', 'NG123', 'AD11'),
('AW34', 'Poppies', '1873', 'Painting', '15000000.00', 'H123', 'MM123', 'AD22'),
('AW56', 'Guernica', '1937', 'Painting', '25000000.00', 'I123', 'TLM123', 'AD55'),
('AW78', 'The Night Watch', '1642', 'Painting', '9000000.00', 'J123', 'BM123', 'AD88'),
('AW90', 'Two Sisters', '2010', 'Sculpture', '200000.00', 'K123', 'JG123', 'AD00'),
('a111', 'ttt', '2018', 'tyse', '2000000000.00', 'E11', 'G11', 'ar1');

-- Table structure for table `contacts`
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
    `CUSTID` VARCHAR(20) DEFAULT NULL,
    `PHONE` VARCHAR(12) DEFAULT NULL,
    KEY `CUSTID` (`CUSTID`),
    FOREIGN KEY (`CUSTID`) REFERENCES `customer`(`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `contacts`
INSERT INTO `contacts` (`CUSTID`, `PHONE`) VALUES
('AT2000', '9456805776'),
('AR1998', '8073271337'),
('AD1998', '9980904736'),
('AM1994', '7737564076'),
('PM1996', '8002391707'),
('AR2022', '800239170'),
('AR2025', '8002391707');

-- Table structure for table `customer`
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
    `custid` VARCHAR(20) NOT NULL,
    `gid` VARCHAR(20) DEFAULT NULL,
    `artworkid` VARCHAR(20) DEFAULT NULL,
    `fname` VARCHAR(25) DEFAULT NULL,
    `lname` VARCHAR(25) DEFAULT NULL,
    `dob` DATE DEFAULT NULL,
    `address` VARCHAR(25) DEFAULT NULL,
    PRIMARY KEY (`custid`),
    KEY `gid` (`gid`),
    KEY `artworkid` (`artworkid`),
    FOREIGN KEY (`gid`) REFERENCES `gallery`(`gid`),
    FOREIGN KEY (`artworkid`) REFERENCES `artwork`(`artid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `customer`
INSERT INTO `customer` (`custid`, `gid`, `artworkid`, `fname`, `lname`, `dob`, `address`) VALUES
('AT2000', 'MM123', 'AW12', 'Akshay', 'Thakur', '2000-04-16', 'New York'),
('AR1998', 'TLM123', 'AW34', 'Ashutosh', 'Ranjan', '1998-02-04', 'Paris'),
('AD1998', 'BM123', 'AW56', 'Ayush', 'Dhar', '1998-09-28', 'London'),
('AM1994', 'JG123', 'AW78', 'Avanish', 'Mehta', '1994-10-05', 'Mumbai'),
('PM1996', 'NG123', 'AW56', 'Prashant', 'Mehta', '1996-06-18', 'Washington'),
('AR2022', 'MM126', 'AW56', 'Aashu', 'Demo', '2022-05-10', 'Delhi'),
('AR2025', 'MM126', 'AW78', 'Aashut', 'Demo0', '2022-05-10', 'Delhi');

-- Table structure for table `exhibition`
DROP TABLE IF EXISTS `exhibition`;
CREATE TABLE `exhibition` (
    `eid` VARCHAR(20) NOT NULL,
    `gid` VARCHAR(20) DEFAULT NULL,
    `startdate` DATE DEFAULT NULL,
    `enddate` DATE DEFAULT NULL,
    PRIMARY KEY (`eid`),
    KEY `gid` (`gid`),
    FOREIGN KEY (`gid`) REFERENCES `gallery`(`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `exhibition`
INSERT INTO `exhibition` (`eid`, `gid`, `startdate`, `enddate`) VALUES
('H123', 'BM123', '2018-12-21', '2019-01-05'),
('I123', 'MM123', '2019-01-25', '2019-02-05'),
('G123', 'NG123', '2018-12-01', '2018-12-15'),
('J123', 'TLM123', '2018-12-15', '2019-01-15'),
('K123', 'JG123', '2019-03-09', '2019-03-27');

-- Table structure for table `gallery`
DROP TABLE IF EXISTS `gallery`;
CREATE TABLE `gallery` (
    `gid` VARCHAR(26) NOT NULL,
    `gname` VARCHAR(50) DEFAULT NULL,
    `location` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `gallery`
INSERT INTO `gallery` (`gid`, `gname`, `location`) VALUES
('MM126', 'MY GALLERY', 'Patna'),
('s123', 'ASHUTOSH', 'Patna'),
('NG123', 'NATIONAL GALLERY', 'Washington'),
('BM123', 'BRITISH MUSEUM', 'London'),
('JG123', 'JAHANGIR GALLERY', 'Mumbai'),
('TLM123', 'THE LOUVRE MUSEUM', 'Paris'),
('MM123', 'METROPOLITAN MUSEUM', 'New York');

-- Triggers `gallery`
DROP TRIGGER IF EXISTS `UPPERCASE`;
DELIMITER $$
CREATE TRIGGER `UPPERCASE` BEFORE INSERT ON `gallery`
FOR EACH ROW
BEGIN
    SET NEW.gname = UPPER(NEW.gname);
END$$
DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
