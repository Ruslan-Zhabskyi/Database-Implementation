DROP SCHEMA IF EXISTS yellowpinkpenguin;

CREATE SCHEMA IF NOT EXISTS yellowpinkpenguin;

USE yellowpinkpenguin;

drop table if exists User;
drop table if exists UserInterests;
drop table if exists administers;
drop table if exists manages;
drop table if exists follows;
drop table if exists AdAccount ;
drop table if exists BillingAccount;
drop table if exists BillingAccPhones;
drop table if exists BillingAccEmails;
drop table if exists Transaction;
drop table if exists AdCampaign;
drop table if exists AdCampaignTargetedCountries;
drop table if exists Ad;
drop table if exists targets;
drop table if exists Publisher;
drop table if exists hosts;

/* Schema */
create table User(
userID INT PRIMARY KEY AUTO_INCREMENT, 
firstName VARCHAR(20) NOT NULL,
lastName VARCHAR(20) NOT NULL,
phoneNumber VARCHAR(20) NOT NULL,
emailAddress VARCHAR(255) NOT NULL,
dateOfBirth DATE NOT NULL,
accountLocation VARCHAR(40) NOT NULL
);

create table UserInterests(
interests VARCHAR(20) NOT NULL, 
userID INT NOT NULL,
PRIMARY KEY (interests, userID),
FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table follows(
userID INT NOT NULL,
followerID INT NOT NULL,
PRIMARY KEY (userID, followerID),
FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (followerID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table BillingAccount(
billingAccountID INT PRIMARY KEY AUTO_INCREMENT, 
paymentMethod VARCHAR(20) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL,
postalCode VARCHAR(20) NOT NULL,
companyName VARCHAR(255) NOT NULL,
firstName VARCHAR(20) NOT NULL,
lastName VARCHAR(20) NOT NULL,
creationDate DATE NOT NULL,
status VARCHAR(20) NOT NULL
);

create table AdAccount(
adAccountID INT PRIMARY KEY AUTO_INCREMENT, 
street VARCHAR(50) NOT NULL,
city VARCHAR(20) NOT NULL,
country VARCHAR(20) NOT NULL,
postalCode VARCHAR(20) NOT NULL,
creationDate DATE NOT NULL,
status VARCHAR(20) NOT NULL,
billingAccountID INT NOT NULL,
FOREIGN KEY (billingAccountID) REFERENCES BillingAccount(billingAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table administers(
userID INT NOT NULL,
adAccountID INT NOT NULL,
accessLevel VARCHAR(20) NOT NULL,
PRIMARY KEY (userID, adAccountID),
FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (adAccountID) REFERENCES AdAccount(adAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table manages(
userID INT NOT NULL,
billingAccountID INT NOT NULL,
accessLevel VARCHAR(20) NOT NULL,
PRIMARY KEY (userID, billingAccountID),
FOREIGN KEY (userID) REFERENCES User(userID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (billingAccountID) REFERENCES BillingAccount(billingAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table BillingAccPhones(
phoneNumber VARCHAR(20) NOT NULL,
billingAccountID INT NOT NULL,
PRIMARY KEY (phoneNumber, billingAccountID),
FOREIGN KEY (billingAccountID) REFERENCES BillingAccount(billingAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table BillingAccEmails(
email VARCHAR(255 ) NOT NULL,
billingAccountID INT NOT NULL,
PRIMARY KEY (email, billingAccountID),
FOREIGN KEY (billingAccountID) REFERENCES BillingAccount(billingAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Transaction(
transactionNumber VARCHAR(255) NOT NULL,
transactionDate DATE NOT NULL,
transactionAmount INT NOT NULL,
description VARCHAR(500),
billingAccountID INT NOT NULL,
PRIMARY KEY (transactionNumber, billingAccountID),
FOREIGN KEY (billingAccountID) REFERENCES BillingAccount(billingAccountID) ON UPDATE CASCADE ON DELETE NO ACTION
);

create table AdCampaign(
campaignID INT PRIMARY KEY AUTO_INCREMENT,
budget INT NOT NULL,
marketingObjective VARCHAR(50) NOT NULL,
bidStrategy VARCHAR(50) NOT NULL,
startDate DATE NOT NULL,
endDate DATE,
status VARCHAR(20) NOT NULL,
adAccountID INT NOT NULL,
FOREIGN KEY (adAccountID) REFERENCES AdAccount(adAccountID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table AdCampaignTargetedCountries(
targetedCountries VARCHAR(25) NOT NULL,
campaignID INT NOT NULL,
PRIMARY KEY (targetedCountries, campaignID),
FOREIGN KEY (campaignID) REFERENCES  AdCampaign(campaignID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Ad(
adID INT PRIMARY KEY AUTO_INCREMENT,
creationDate DATE NOT NULL,
status VARCHAR(20) NOT NULL,
title VARCHAR(50) NOT NULL,
finalURL VARCHAR(250) NOT NULL,
type VARCHAR(50) NOT NULL,
bodyText VARCHAR(250),
imageID VARCHAR(255),
videoID VARCHAR(255),
campaignID INT NOT NULL,
FOREIGN KEY (campaignID) REFERENCES  AdCampaign(campaignID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table targets(
adID INT NOT NULL,
userID INT NOT NULL,
adImpressions BIGINT,
adClicks BIGINT,
PRIMARY KEY (adID, userID),
FOREIGN KEY (adID) REFERENCES  Ad(adID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (userID) REFERENCES  User(userID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Publisher(
publisherID INT PRIMARY KEY AUTO_INCREMENT,
platformType VARCHAR(50) NOT NULL,
name VARCHAR(250) NOT NULL,
startDate DATE NOT NULL,
status VARCHAR(20) NOT NULL
);

create table hosts(
publisherID INT NOT NULL,
adID INT NOT NULL,
adImpressions BIGINT,
adClicks BIGINT,
dateOfInteraction DATE,
PRIMARY KEY (publisherID, adID, dateOfInteraction),
FOREIGN KEY (publisherID) REFERENCES  Publisher(publisherID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (adID) REFERENCES  Ad(adID) ON UPDATE CASCADE ON DELETE CASCADE
);


/*******Triggers********/

/* Trigger 1: track of previous user emails */

CREATE TABLE user_previous_emails (
    id INT AUTO_INCREMENT PRIMARY KEY,
	userID INT NOT NULL, 
	emailAddress VARCHAR(255) NOT NULL,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER before_userEmail_update 
    BEFORE UPDATE ON User
    FOR EACH ROW 
BEGIN
    INSERT INTO user_previous_emails
    SET action = 'update',
        userID = OLD.userID,
	    emailAddress = OLD.emailAddress,
        changedate = NOW(); 
END $$
DELIMITER ;

/* Trigger 2: limit Billing Account phone numbers to 3 */
DELIMITER $$
CREATE TRIGGER before_phone_number_insert 
BEFORE INSERT ON BillingAccPhones 
FOR EACH ROW 
BEGIN
    DECLARE phoneCount INT;
    SET phoneCount = (SELECT COUNT(phoneNumber) FROM BillingAccPhones WHERE billingAccountID = NEW.billingAccountID);
/* USED CHAT GPT TO WRITE NEXT 4 LINES OF THE SCRIPT */
    IF phoneCount >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number limit (3) reached for the billing account.';
    END IF;
END $$
DELIMITER ;

/* Trigger 3: limit Billing Account emails to 3 */
DELIMITER $$
CREATE TRIGGER before_email_insert 
BEFORE INSERT ON BillingAccEmails 
FOR EACH ROW 
BEGIN
    DECLARE emailCount INT;
    SET emailCount = (SELECT COUNT(email) FROM BillingAccEmails WHERE billingAccountID = NEW.billingAccountID);

    IF emailCount >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email limit (3) reached for the billing account.';
    END IF;
END $$
DELIMITER ;

/* Trigger 3: limit Ad Campaign targetted countries to 195 */
DELIMITER $$
CREATE TRIGGER before_targetCountry_insert  
BEFORE INSERT ON AdCampaignTargetedCountries 
FOR EACH ROW 
BEGIN
    DECLARE targetedCountriesCount INT;
    SET targetedCountriesCount = (SELECT COUNT(targetedCountries) FROM AdCampaignTargetedCountries WHERE campaignID = NEW.campaignID);

    IF targetedCountriesCount >= 195 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Targetted countries limit (195) reached for the Ad Campaign.';
    END IF;
END $$
DELIMITER ;

/* Trigger 4: limit User Interests to 10 */
DELIMITER $$
CREATE TRIGGER before_userInterest_insert  
BEFORE INSERT ON UserInterests 
FOR EACH ROW 
BEGIN
    DECLARE interestsCount INT;
    SET interestsCount = (SELECT COUNT(interests) FROM UserInterests WHERE userID = NEW.userID);

    IF interestsCount >= 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User interests limit (10) reached for the user.';
    END IF;
END $$
DELIMITER ;

/* Trigger 5: to keep count of followers for each user */
create table followers_count (
  userID int primary key,
  count bigint unsigned
);

DELIMITER $$
CREATE TRIGGER after_follower_insert
AFTER INSERT ON follows
FOR EACH ROW 
BEGIN
    INSERT INTO followers_count (userID, count)
    VALUES (NEW.userID, 1)
    ON DUPLICATE KEY UPDATE count = count + 1;
END $$
DELIMITER ;


/* Data */
INSERT INTO User (firstName, lastName, phoneNumber, emailAddress, dateOfBirth, accountLocation)
VALUES
  ('John', 'Redmond', '0871238992', 'jredmond@gmail.com', '2000-01-22', 'Dublin, Ireland'),
  ('Alice', 'Smith', '0854567890', 'asmith@example.com', '1995-03-15', 'London, UK'),
  ('Bob', 'Johnson', '0869876543', 'bjohnson@gmail.com', '1988-07-10', 'New York, USA'),
  ('Jane', 'Doe', '0833333333', 'jdoe@example.com', '1992-11-05', 'Los Angeles, USA'),
  ('David', 'Brown', '0898765432', 'dbrown@gmail.com', '1998-04-30', 'Sydney, Australia'),
  ('Eva', 'Anderson', '0856789012', 'eanderson@example.com', '1990-09-18', 'Berlin, Germany'),
  ('Michael', 'Taylor', '0812345678', 'mtaylor@example.com', '1993-06-25', 'Paris, France'),
  ('Sophie', 'Miller', '0845678901', 'smiller@gmail.com', '1985-12-03', 'Toronto, Canada'),
  ('Tom', 'Clark', '0887654321', 'tclark@example.com', '1996-08-20', 'Tokyo, Japan'),
  ('Laura', 'White', '0865432109', 'lwhite@gmail.com', '1987-02-14', 'Rome, Italy'),
  ('Ryan', 'Baker', '0890123456', 'rbaker@example.com', '1994-10-08', 'Barcelona, Spain'),
  ('Olivia', 'Carter', '0876543210', 'ocarter@gmail.com', '1997-05-12', 'Mumbai, India'),
  ('William', 'Ward', '0832109876', 'wward@example.com', '1989-11-28', 'Beijing, China'),
  ('Emma', 'Hill', '0810987654', 'ehill@gmail.com', '1991-07-19', 'Kyiv, Ukraine'),
  ('Charlie', 'Martin', '0887654321', 'cmartin@example.com', '1999-04-02', 'Cape Town, South Africa'),
  ('Ava', 'Wright', '0865432109', 'awright@gmail.com', '1996-03-27', 'Rio de Janeiro, Brazil'),
  ('Daniel', 'Turner', '0890123456', 'dturner@example.com', '1992-12-15', 'Seoul, South Korea'),
  ('Natalie', 'Williams', '0871234501', 'nwilliams@example.com', '1994-08-17', 'New York, USA'),
  ('Jack', 'Harrison', '0856789012', 'jharrison@gmail.com', '1986-05-22', 'London, UK'),
  ('Sophia', 'Walker', '0865432109', 'swalker@example.com', '1990-02-10', 'Los Angeles, USA'),
  ('Matthew', 'Cooper', '0812345678', 'mcooper@gmail.com', '1997-11-28', 'Sydney, Australia'),
  ('Emma', 'Barnes', '0898765432', 'ebarnes@example.com', '1991-04-15', 'Tokyo, Japan'),
  ('Liam', 'Wright', '0832109876', 'lwright@gmail.com', '1995-10-08', 'Paris, France'),
  ('Ava', 'Collins', '0810987654', 'acollins@example.com', '1999-03-27', 'Toronto, Canada'),
  ('Noah', 'Parker', '0887654321', 'nparker@gmail.com', '1993-12-15', 'Barcelona, Spain'),
  ('Isabella', 'Evans', '0845678901', 'ievans@example.com', '1998-07-19', 'Kyiv, Ukraine'),
  ('Mason', 'Howard', '0869876543', 'mhoward@gmail.com', '1996-09-18', 'Kyiv, Ukraine');

INSERT INTO UserInterests (interests, userID)
VALUES
  ('Science', 1),
  ('Science', 2),
  ('Science', 3),
  ('Science', 4),
  ('Travel', 5),
  ('Travel', 6),
  ('Travel', 7),
  ('Travel', 8),
  ('Football', 9),
  ('Football', 10),
  ('Football', 11),
  ('Football', 12),
  ('Football', 13),
  ('Football', 14),
  ('Finance', 15),
  ('Football', 16),
  ('Finance', 17),
  ('Art', 1),
  ('Finance', 10),
  ('Languages', 11),
  ('Languages', 12),
  ('Music', 13),
  ('Music', 14),
  ('Music', 15),
  ('Science', 16),
  ('Science', 17),
  ('Literature', 1),
  ('Literature', 2),
  ('Literature', 3),
  ('Literature', 4),
  ('Literature', 5),
  ('Literature', 6),
  ('IT', 7),
  ('IT', 8),
  ('IT', 9),
  ('IT', 10),
  ('IT', 11),
  ('Comedy', 12),
  ('Comedy', 13),
  ('Comedy', 14),
  ('Politics', 15),
  ('Politics', 16),
  ('Politics', 17);
  
  
INSERT INTO follows (userID, followerID)
VALUES
  (1, 2), (1, 3), (1, 4), 
  (1, 5), (1, 6), (1, 7), 
  (1, 8), (1, 9), (1, 10), 
  (1, 11), (1, 12), (1, 13), 
  (1, 14), (1, 15), (1, 16), 
  (1, 17),
  (2, 1), (2, 3), (2, 5),
  (3, 1), (3, 2), (3, 4),
  (4, 1), (4, 2), (4, 5),
  (5, 1), (5, 4),
  (6, 5), (6, 7), (6, 8),
  (7, 6),
  (8, 6), (8, 11), (8, 12),
  (9, 7), (9, 13), (9, 14),
  (10, 7), (10, 15), (10, 16),
  (11, 8), (11, 12), (11, 17),
  (12, 8), (12, 11), (12, 14),
  (13, 9), (13, 14), (13, 17),
  (14, 9), (14, 13), (14, 16),
  (15, 10), (15, 16), (16, 6), 
  (16, 7), (16, 8), (16, 9),
  (16, 15), (16, 14), (16, 17),
  (17, 11), (17, 15), (17, 16);
  
INSERT INTO BillingAccount (paymentMethod, street, city, country, postalCode, companyName,firstName,lastName,creationDate, status)
VALUES  
 ('bank transfer', '7 Marine Cove', 'Dublin', 'Ireland', 'K13BB20', 'Rodger and son', 'Rodger', 'Buttler', '2023-11-12', 'Active'),
 ('credit card', 'High Street', 'London', 'United Kingdom', 'SW1A1AA', 'Fish and Chips', 'Ben', 'Buttler', '2023-01-12', 'Disabled'),
 ('bank transfer', '2 Waterside', 'Malahide', 'Ireland', 'K3GB10', 'Private', 'Lisa', 'Redmond', '2023-04-12', 'Deleted'),
 ('credit card', '10 Seaside', 'Dublin', 'Ireland', 'K12AB34', 'TechHub', 'Alex', 'Smith', '2023-07-12', 'Active'),
 ('bank transfer', '5 Hilltop', 'Cork', 'Ireland', 'K5CD56', 'Global Services', 'Laura', 'Jones', '2023-02-28', 'Active'),
 ('credit card', '8 Green Lane', 'Galway', 'Ireland', 'K8EF78', 'Gourmet Delights', 'Michael', 'Miller', '2023-05-15', 'Disabled'),
 ('bank transfer', '3 Riverside', 'Limerick', 'Ireland', 'K3GH45', 'Health Solutions', 'Sophie', 'Taylor', '2023-09-20', 'Active'),
 ('credit card', '12 Ocean View', 'Wexford', 'Ireland', 'K12IJ67', 'Travel Bliss', 'Ethan', 'Wilson', '2023-03-01', 'Active'),
 ('bank transfer', 'Sydney Opera House', 'Sydney', 'Australia', '2000', 'Book Haven', 'Olivia', 'Brown', '2023-06-10', 'Disabled'),
 ('credit card', '4 Sunrise Ave', 'Kilkenny', 'Ireland', 'K4MN89', 'Fashion Hub', 'Daniel', 'Hill', '2023-10-05', 'Active'),
 ('bank transfer', '9 Meadow Lane', 'Drogheda', 'Ireland', 'K9OP23', 'Tech Innovators', 'Ava', 'Garcia', '2023-12-15', 'Disabled'),
 ('credit card', '11 Mountain View', 'Sligo', 'Ireland', 'K11QR45', 'Fitness Junction', 'Liam', 'Woods', '2023-08-08', 'Active'),
 ('bank transfer', '15 Lakeside', 'Tralee', 'Ireland', 'K15ST67', 'Art Gallery', 'Isabella', 'Lee', '2023-04-05', 'Active'),
 ('credit card', '14 Park Lane', 'Ennis', 'Ireland', 'K14UV89', 'Home Decor', 'Mason', 'Hayes', '2023-01-18', 'Disabled'),
 ('bank transfer', '18 Meadow View', 'Carlow', 'Ireland', 'K18WX23', 'Pet Paradise', 'Noah', 'Fisher', '2023-11-30', 'Active'),
 ('credit card', '20 Pine Street', 'Dundalk', 'Ireland', 'K20YZ45', 'Music Haven', 'Emily', 'Baker', '2023-06-22', 'Active'),
 ('bank transfer','Rialto Bridge', 'Venice', 'Italy', '30125', 'Green Thumb', 'Jackson', 'Jones', '2023-09-12', 'Disabled'),
 ('credit card', 'Acropolis of Athens', 'Athens', 'Greece', '105 58', 'Toy Emporium', 'Emma', 'Morgan', '2023-02-14', 'Active');
 
INSERT INTO AdAccount (street, city, country, postalCode, creationDate, status, billingAccountID) 
VALUES
 ('Main Street', 'Dublin', 'Ireland', 'D01ABC', '2023-11-12', 'Active', 10),
 ('High Street', 'London', 'United Kingdom', 'SW1A1AA', '2023-01-12', 'Disabled', 3),
 ('Broadway', 'New York', 'United States', '10001', '2023-04-12', 'Disabled', 2),
 ('La Rambla', 'Barcelona', 'Spain', '08001', '2023-07-12', 'Active', 4),
 ('Champs-Élysées', 'Paris', 'France', '75008', '2023-02-28', 'Active', 5),
 ('Alexanderplatz', 'Berlin', 'Germany', '10178', '2023-05-15', 'Disabled', 6),
 ('Piazza San Marco', 'Venice', 'Italy', '30124', '2023-09-20', 'Active', 7),
 ('Maidan Nezalezhnosti', 'Kyiv', 'Ukraine', '09100', '2023-03-01', 'Active', 8),
 ('Sydney Opera House', 'Sydney', 'Australia', '2000', '2023-06-10', 'Disabled', 9),
 ('Copacabana Beach', 'Rio de Janeiro', 'Brazil', '22070-011', '2023-10-05', 'Active', 1),
 ('Table Mountain', 'Cape Town', 'South Africa', '8001', '2023-12-15', 'Disabled', 11),
 ('Taj Mahal', 'Agra', 'India', '282001', '2023-08-08', 'Active', 12),
 ('Golden Gate Bridge', 'San Francisco', 'United States', '94123', '2023-04-05', 'Active', 14),
 ('Petronas Towers', 'Kuala Lumpur', 'Malaysia', '50088', '2023-01-18', 'Disabled', 13),
 ('Machu Picchu', 'Cusco', 'Peru', '08002', '2023-11-30', 'Active', 15),
 ('Tokyo Tower', 'Tokyo', 'Japan', '105-0011', '2023-06-22', 'Active', 16),
 ('Acropolis of Athens', 'Athens', 'Greece', '105 58', '2023-09-12', 'Disabled', 18),
 ('Rialto Bridge', 'Venice', 'Italy', '30125', '2023-02-14', 'Active', 17);
 
 
INSERT INTO administers (userID, adAccountID, accessLevel)
VALUES
  (27, 1, 'Manager'),
  (27, 2, 'Manager'),
  (27, 3, 'Manager'),
  (20, 3, 'Edit'), 
  (2, 3, 'View'),
  (2, 4, 'Manager'),
  (1, 5, 'Manager'),
  (1, 6, 'Manager'),
  (8, 7, 'Manager'),
  (24, 8, 'Manager'),
  (1, 9, 'Manager'),
  (25, 10, 'Manager'),
  (19, 11, 'Manager'),
  (12, 12, 'Manager'),
  (2, 13, 'Manager'),
  (15, 14, 'Manager'),
  (22, 15, 'Manager'),
  (23, 16, 'Manager'),
  (13, 17, 'Manager'),
  (13, 18, 'Edit'),
  (10, 18, 'Manager');
  
INSERT INTO manages (userID, billingAccountID, accessLevel)
VALUES
(27, 1, 'Manager'),
(27, 2, 'Edit'),
(2, 2, 'Manager'),
(8, 3, 'Manager'),
(20, 3, 'View'),
(2, 4, 'Manager'),
(27, 4, 'Edit'),
(1, 5, 'Manager'),
(7, 5, 'View'),
(5, 6, 'Manager'),
(6, 7, 'Manager'),
(17, 8, 'Manager'),
(27, 9, 'Manager'),
(22, 10, 'Manager'),
(3, 11, 'Manager'),
(19, 12, 'Manager'),
(24, 13, 'Manager'),
(26, 14, 'Manager'),
(10, 15, 'Manager'),
(23, 16, 'Manager'),
(10, 17, 'Manager'),
(11, 18, 'Manager');


INSERT INTO BillingAccPhones (phoneNumber, billingAccountID)
VALUES
('0897778888', 9),
('0868889999', 10),
('0874445555', 11),
('0891234567', 12),
('0869876543', 13),
('0873456789', 14),
('0898765432', 15),
('0861112233', 16),
('0873334444', 17),
('0895556666', 18),
('0867778888', 1),
('0878889999', 2),
('0894445555', 3),
('0863334444', 4),
('0875556666', 5),
('0897778888', 6),
('0868889999', 7),
('0874445555', 8),
('0891234567', 9),
('0869876543', 10),
('0873456789', 11),
('0898765432', 12),
('0861112233', 13),
('0873334444', 14),
('0895556666', 15),
('0867778888', 16),
('0878889999', 17),
('0894445555', 18),
('0863334444', 1),
('0875556666', 2),
('0897778888', 3),
('0868889999', 4),
('0874445555', 5),
('0891234567', 6),
('0869876543', 7),
('0873456789', 8),
('0898765432', 9),
('0861112233', 10),
('0873334444', 11),
('0895556666', 12),
('0867778888', 13),
('0878889999', 14);

INSERT INTO BillingAccEmails (email, billingAccountID)
VALUES
('john.doe@gmail.com', 1),
('alice.smith@yahoo.com', 2),
('david.jones@companydomain.com', 3),
('emma.wilson@gmail.com', 4),
('michael.brown@yahoo.com', 5),
('olivia.white@companydomain.com', 6),
('william.jackson@gmail.com', 7),
('sophia.anderson@yahoo.com', 8),
('james.miller@companydomain.com', 9),
('mia.davis@gmail.com', 10),
('benjamin.moore@yahoo.com', 11),
('emily.taylor@companydomain.com', 12),
('henry.hill@gmail.com', 13),
('ava.ward@yahoo.com', 14),
('grace.robinson@companydomain.com', 15),
('ethan.baker@gmail.com', 16),
('chloe.cook@yahoo.com', 17),
('daniel.turner@companydomain.com', 18),
('lily.bell@gmail.com', 8),
('logan.carter@yahoo.com', 9),
('madison.evans@companydomain.com', 10),
('noah.hall@gmail.com', 11),
('zoey.martin@yahoo.com', 12),
('liam.cooper@companydomain.com', 13),
('mia.watson@gmail.com', 14),
('amelia.harrison@yahoo.com', 15),
('jack.king@companydomain.com', 1),
('emily.hughes@gmail.com', 2),
('lucas.ross@yahoo.com', 3),
('ava.fisher@companydomain.com', 4),
('aiden.hayes@gmail.com', 5),
('harper.perry@yahoo.com', 6),
('oliver.stone@companydomain.com', 7),
('sophia.ford@gmail.com', 1),
('max.wells@yahoo.com', 2),
('scarlett.dixon@companydomain.com', 3),
('finn.warren@gmail.com', 4),
('evelyn.knight@yahoo.com', 5),
('leo.graham@companydomain.com', 6),
('abigail.richards@gmail.com', 7);

INSERT INTO Transaction (transactionNumber, transactionDate, transactionAmount, description, billingAccountID) 
VALUES
('T123', '2023-01-15', 100, 'Online service', 1),
('T124', '2023-02-20', 150, 'Ads', 1),
('T125', '2023-03-10', 80, 'YellowPinkPenguin', 1),
('T126', '2023-04-05', 200, 'Online advertising', 1),
('T12', '2023-01-15', 100, 'Online service', 1),
('T24', '2023-02-20', 150, 'Ads', 1),
('T15', '2023-03-10', 80, 'YellowPinkPenguin', 1),
('T300', '2023-04-05', 200, 'Online advertising', 1),
('T302', '2023-05-12', 120, 'Online service', 1),
('T128', '2023-01-18', 90, 'Ads', 2),
('T129', '2023-02-25', 130, 'Online advertising', 2),
('T130', '2023-03-15', 75, 'Online service', 2),
('T131', '2023-04-08', 180, 'Ads', 2),
('T132', '2023-05-16', 110, 'Online service', 2),
('T133', '2023-01-20', 120, 'YellowPinkPenguin', 3),
('T134', '2023-02-28', 160, 'Online service', 3),
('T135', '2023-03-20', 85, 'Online advertising', 3),
('T136', '2023-04-10', 220, 'Ads', 3),
('T137', '2023-05-18', 130, 'Online advertising', 3),
('T138', '2023-01-22', 110, 'Online service', 4),
('T139', '2023-02-27', 140, 'Ads', 5),
('T140', '2023-03-25', 95, 'Online advertising', 6),
('T141', '2023-04-12', 240, 'Online service', 7),
('T142', '2023-05-22', 140, 'Ads', 8),
('T143', '2023-01-25', 130, 'Online advertising', 5),
('T144', '2023-02-26', 120, 'Online service', 14),
('T145', '2023-03-28', 105, 'Ads', 15),
('T146', '2023-04-15', 260, 'Online service', 16),
('T147', '2023-05-25', 150, 'Online advertising', 17);

INSERT INTO AdCampaign (budget, marketingObjective, bidStrategy, startDate, endDate, status, adAccountID)
VALUES
(1000, 'Increase brand awareness', 'CPC', '2023-01-01', '2023-01-31', 'Active', 1),
(1500, 'Increase sales', 'vCPM', '2023-02-01', '2023-02-28', 'Paused', 2),
(800, 'Increase leads', 'CPV', '2023-03-01', '2023-03-31', 'Active', 3),
(1200, 'Improve conversion rate', 'CPC', '2023-04-01', '2023-04-30', 'Deleted', 4),
(2000, 'Increase brand awareness', 'vCPM', '2023-05-01', '2023-05-31', 'Active', 5),
(900, 'Increase sales', 'CPV', '2023-06-01', '2023-06-30', 'Paused', 6),
(1600, 'Improve conversion rate', 'CPC', '2023-07-01', '2023-07-31', 'Active', 7),
(1000, 'Increase brand awareness', 'CPC', '2023-08-01', NULL, 'Active', 8),
(1200, 'Increase sales', 'vCPM', '2023-09-01', NULL, 'Paused', 9),
(800, 'Increase leads', 'CPV', '2023-10-01', NULL, 'Active', 10),
(1500, 'Improve conversion rate', 'CPC', '2023-11-01', NULL, 'Deleted', 11),
(1800, 'Increase brand awareness', 'vCPM', '2023-12-01', NULL, 'Active', 12),
(1000, 'Increase sales', 'CPV', '2024-01-01', NULL, 'Paused', 13),
(1400, 'Improve conversion rate', 'CPC', '2024-02-01', NULL, 'Active', 14),
(1200, 'Increase sales', 'CPC', '2023-08-01', '2023-08-31', 'Paused', 1),
(900, 'Increase brand awareness', 'vCPM', '2023-09-01', '2023-09-30', 'Active', 1),
(1500, 'Increase leads', 'CPV', '2023-10-01', '2023-10-31', 'Active', 1),
(1000, 'Improve conversion rate', 'CPC', '2023-08-31', '2023-08-31', 'Active', 2),
(1100, 'Increase brand awareness', 'vCPM', '2023-09-01', '2023-09-30', 'Paused', 2),
(1300, 'Increase sales', 'CPV', '2023-10-01', '2023-10-31', 'Active', 2),
(800, 'Increase leads', 'CPC', '2023-08-01', NULL, 'Active', 3),
(1200, 'Increase brand awareness', 'vCPM', '2023-09-01', '2023-09-30', 'Paused', 3),
(1000, 'Improve conversion rate', 'CPV', '2023-10-01', '2023-10-31', 'Active', 3);

INSERT INTO AdCampaignTargetedCountries (targetedCountries, campaignID)
VALUES
('Ireland', 1),
('Ireland', 2),
('Ireland', 3),
('Ukraine', 4),
('Ukraine', 5),
('Ukraine', 6),
('Ukraine', 7),
('Ukraine', 8),
('Ukraine', 9),
('Ukraine', 10),
('Ukraine', 11),
('Ukraine', 12),
('Germany', 13),
('Germany', 14),
('Germany', 15),
('Germany', 16),
('Germany', 17),
('Germany', 18),
('Germany', 19),
('Germany', 20),
('Poland', 21),
('Ukraine', 22),
('Italy', 23),
('Ukraine', 1),
('Ukraine', 2),
('Ukraine', 3),
('Poland', 1),
('Poland', 2),
('Poland', 3),
('Lithuania', 12),
('Estonia', 13),
('Latvia', 14);

INSERT INTO Ad (creationDate, status, title, finalURL, type, bodyText, imageID, videoID, campaignID)
VALUES
('2023-01-01', 'Active', 'Ad Title 1', 'https://example.com/1', 'image', NULL, 'IMG001', NULL, 1),
('2023-02-01', 'Paused', 'Ad Title 2', 'https://example.com/2', 'video', NULL, NULL, 'VID001', 1),
('2023-03-01', 'Active', 'Ad Title 3', 'https://example.com/3', 'image', NULL, 'IMG002', NULL, 2),
('2023-04-01', 'Deleted', 'Ad Title 4', 'https://example.com/4', 'video', NULL, NULL, 'VID002', 2),
('2023-05-01', 'Active', 'Ad Title 5', 'https://example.com/5', 'text', 'This is the body text for Ad 5', NULL, NULL, 3),
('2023-06-01', 'Paused', 'Ad Title 6', 'https://example.com/6', 'text', 'This is the body text for Ad 6', NULL, NULL, 3),
('2023-07-01', 'Active', 'Ad Title 7', 'https://example.com/7', 'image', NULL, 'IMG111', NULL, 4),
('2023-01-01', 'Active', 'Ad Title 1', 'https://productstore1.com', 'image', NULL, 'IMG021', NULL, 5),
('2023-02-01', 'Paused', 'Ad Title 2', 'https://serviceprovider2.com', 'video', NULL, NULL, 'VID001', 6),
('2023-03-01', 'Active', 'Ad Title 3', 'https://onlineshop3.com', 'image', NULL, 'IMG101', NULL, 7),
('2023-04-01', 'Deleted', 'Ad Title 4', 'https://techcompany4.com', 'video', NULL, NULL, 'VID201', 8),
('2023-05-01', 'Active', 'Ad Title 5', 'https://blogsite5.com', 'text', 'This is the body text for Ad 5 promoting Sertraline', NULL, NULL, 9),
('2023-06-01', 'Paused', 'Ad Title 6', 'https://videogaming6.com', 'video', 'This is the body text for Ad 6', NULL, NULL, 10),
('2022-07-01', 'Active', 'Ad Title 7', 'https://travelagency7.com', 'image', NULL, 'IMG001', NULL, 11),
('2023-08-01', 'Active', 'Ad Title 8', 'https://coffeeshop8.com', 'text', 'This is the body text for Ad 8', NULL, NULL, 12),
('2023-09-01', 'Paused', 'Ad Title 9', 'https://fashionstore9.com', 'image', NULL, 'IMG818', NULL, 13),
('2023-10-01', 'Active', 'Ad Title 10', 'https://musicstreaming10.com', 'video', NULL, NULL, 'VID701', 14);

INSERT INTO targets (adID, userID, adImpressions, adClicks)
VALUES
(1, 1, 89, 5),
(2, 2, 70, 5),
(3, 3, 27, 3),
(4, 4, 85, 3),
(5, 5, 66, 4),
(6, 6, 86, 5),
(7, 7, 25, 13),
(8, 8, 70, 1),
(9, 9, 35, 11),
(10, 10, 96, 0),
(11, 11, 78, 12),
(12, 12, 71, 3),
(13, 13, 82, 17),
(14, 14, 21, 4),
(15, 15, 87, 12),
(16, 16, 60, 14),
(17, 17, 79, 8),
(1, 18, 88, 16),
(2, 19, 60, 9),
(3, 20, 24, 13),
(4, 21, 90, 9),
(5, 22, 97, 0),
(6, 23, 48, 17),
(7, 24, 70, 16),
(8, 25, 77, 14),
(9, 2, 15, 13),
(10, 3, 31, 16),
(11, 4, 65, 17),
(12, 5, 26, 17),
(13, 6, 86, 9),
(14, 7, 34, 8),
(15, 8, 83, 14),
(16, 9, 32, 16),
(17, 10, 100, 17),
(1, 11, 19, 17),
(2, 12, 23, 12),
(3, 13, 76, 17),
(4, 14, 34, 0),
(5, 15, 16, 5),
(6, 16, 76, 0),
(7, 17, 67, 3),
(8, 18, 72, 12),
(9, 19, 67, 7),
(10, 20, 50, 9),
(11, 21, 48, 6),
(12, 3, 59, 16),
(13, 4, 38, 12),
(14, 5, 13, 15),
(15, 6, 83, 5),
(16, 7, 42, 16),
(17, 8, 26, 9),
(1, 9, 43, 7),
(2, 10, 28, 0),
(3, 11, 56, 16),
(4, 12, 11, 14),
(5, 13, 70, 17);


INSERT INTO Publisher (platformType, name, startDate, status)
VALUES
  ('Display Network', 'Google', '2023-09-04', 'Active'),
  ('Social Media', 'Facebook', '2022-02-04', 'Active'),
  ('Social Media', 'Instagram', '2023-10-06', 'Active'),
  ('Video Sharing', 'YouTube', '2023-02-14', 'Active'),
  ('Email Service', 'Gmail', '2023-04-01', 'Active'),
  ('Maps & Navigation', 'Google Maps', '2023-02-08', 'Active'),
  ('Video Streaming', 'Netflix', '2023-08-29', 'Active'),
  ('Microblogging', 'Twitter', '2023-03-21', 'Active'),
  ('Professional Network', 'LinkedIn', '2023-05-05', 'Active'),
  ('E-commerce', 'Amazon', '2023-07-05', 'Active'),
  ('Display Network', 'WSJ', '2023-07-05', 'Disabled');

INSERT INTO hosts (publisherID, adID, adImpressions, adClicks, dateOfInteraction)
VALUES  
(1, 1, 1000, 5, '2023-09-04'),
(1, 1, 1099, 100, '2023-10-04'),
(2, 2, 3000, 200, '2023-09-04'),
(3, 3, 27, 3, '2023-09-04'),
(4, 4, 85, 3, '2023-09-04'),
(5, 5, 66, 4, '2023-09-04'),
(6, 6, 86, 5, '2023-09-05'),
(7, 7, 25, 13, '2023-09-06'),
(8, 8, 70, 1, '2023-09-07'),
(9, 9, 35, 11, '2023-09-08'),
(10, 10, 96, 0, '2023-09-09'),
(11, 11, 78, 12, '2023-09-10'),
(1, 12, 71, 3, '2023-09-11'),
(2, 13, 82, 17, '2023-09-12'),
(3, 14, 21, 4, '2023-09-13'),
(4, 15, 87, 12, '2023-09-14'),
(5, 16, 60, 14, '2023-09-15'),
(6, 17, 79, 8, '2023-09-16'),
(7, 1, 88, 16, '2023-09-17'),
(8, 2, 60, 9, '2023-09-18'),
(9, 3, 24, 13, '2023-09-13'),
(10, 4, 90, 0, '2023-09-14'),
(11, 5, 97, 17, '2023-09-15'),
(2, 7, 70, 14, '2023-09-17'),
(3, 8, 77, 9, '2023-09-18'),
(4, 9, 15, 13, '2023-09-15'),
(5, 10, 31, 16, '2023-09-16'),
(6, 11, 65, 17, '2023-09-17'),
(7, 12, 26, 0, '2023-09-18'),
(8, 13, 86, 5, '2023-10-19'),
(9, 14, 34, 0, '2023-10-20'),
(6, 15, 83, 3, '2023-10-21'),
(7, 16, 32, 16, '2023-10-22'),
(8, 17, 100, 12, '2023-10-23'),
(6, 1, 19, 15, '2023-10-24'),
(7, 2, 23, 17, '2023-10-25'),
(8, 3, 76, 9, '2023-10-26'),
(1, 4, 34, 8, '2023-10-26'),
(1, 5, 16, 14, '2023-10-26'),
(1, 6, 76, 16, '2023-10-26'),
(1, 7, 67, 17, '2023-11-18'),
(1, 8, 72, 17, '2023-11-18'),
(1, 9, 67, 16, '2023-11-18'),
(1, 10, 50, 0, '2023-10-18'),
(1, 11, 48, 5, '2023-10-19'),
(1, 12, 59, 16, '2023-10-20'),
(5, 13, 38, 14, '2023-10-21'),
(5, 14, 13, 7, '2023-10-22'),
(5, 15, 83, 9, '2023-10-23'),
(5, 16, 42, 6, '2023-10-24');

/* Indexes */
create index userAccountLocationInd on User(accountLocation);
create index billingAccountPaymentMethodInd on BillingAccount(paymentMethod);
create index adAccountCountryInd on AdAccount(country);
create index administersAccessLevelInd on administers(accessLevel);
create index managesAccessLevelInd on manages(accessLevel);
create index transactionTransactionDateInd on Transaction(transactionDate);
create index AdCampaignMarketingObjectiveInd on AdCampaign(marketingObjective);
create index AdTypeInd on Ad(Type);
create index publisherPlatformTypeInt on Publisher(platformType);

/* Views */

CREATE OR REPLACE VIEW revenuePerMonth AS
    SELECT
		DATE_FORMAT(transactionDate, '%m-%Y') AS date,
		SUM(transactionAmount) AS total
    FROM Transaction
	GROUP BY DATE_FORMAT(transactionDate, '%m-%Y')
    ORDER BY date DESC;
    
CREATE OR REPLACE VIEW tier1Accounts AS
  SELECT
		b.billingAccountID,
		companyName,
		CURDATE()-creationDate AS accountAgeDays,
		SUM(transactionAmount) AS totalSpend,
		status
    FROM Transaction t LEFT JOIN billingAccount b ON t.billingAccountID = b.billingAccountID
    WHERE DATE_FORMAT(transactionDate, '%Y') = 2023
		AND status = 'Active'
	GROUP BY b.billingAccountID
    HAVING totalSpend >= 1000
    ORDER BY totalSpend DESC;
    
CREATE OR REPLACE VIEW adPerformanceStatisticOnPlatform AS
    SELECT
		ad.adID,
		ad.status,
		ad.type,
		camp.campaignID,
		acc.adAccountID,
		SUM(t.adImpressions) as adImpressions,
		SUM(t.adClicks) as adClicks,
		ROUND((SUM(t.adClicks) / SUM(t.adImpressions) * 100), 2) AS clickRate
    FROM Ad ad LEFT JOIN AdCampaign camp ON ad.campaignID = camp.campaignID 
		LEFT JOIN AdAccount acc ON acc.adAccountID = camp.adAccountID
		LEFT JOIN targets t ON ad.adID = t.adID
    GROUP BY 
		ad.adID,
		ad.status,
		ad.type,
		camp.campaignID,
		acc.adAccountID;
    
CREATE OR REPLACE VIEW adPerformanceStatisticOffPlatform AS
    SELECT
		ad.adID,
		ad.status,
		ad.type,
		camp.campaignID,
		acc.adAccountID,
		p.name AS publisherName,
		SUM(h.adImpressions) as adImpressions,
		SUM(h.adClicks) as adClicks,
		ROUND((SUM(h.adClicks) / SUM(h.adImpressions) * 100), 2) AS clickRate
    FROM Ad ad LEFT JOIN AdCampaign camp ON ad.campaignID = camp.campaignID 
		LEFT JOIN AdAccount acc ON acc.adAccountID = camp.adAccountID
		LEFT JOIN hosts h ON ad.adID = h.adID
		LEFT JOIN Publisher p ON p.publisherID = h.publisherID
    GROUP BY 
		ad.adID,
		ad.status,
		ad.type,
		camp.campaignID,
		acc.adAccountID,
		p.name;
    
CREATE OR REPLACE VIEW billingAccManager AS
	SELECT 
		CONCAT(u.firstName, " ", u.lastName) AS fullName,
		u.emailAddress AS email,
		b.companyName,
		b.billingAccountID,
		m.accessLevel
	FROM User u RIGHT JOIN manages m ON u.userID = m.userID JOIN BillingAccount b ON b.billingAccountID = m.billingAccountID
	WHERE accessLevel = 'Manager'
	ORDER BY u.firstName, u.lastName;
    
CREATE OR REPLACE VIEW topInfluencers AS    
	SELECT 
		CONCAT(u.firstName, " ", u.lastName) AS fullName,
		u.emailAddress AS email,
		u.accountLocation,
		TIMESTAMPDIFF(YEAR, u.dateOfBirth, CURDATE()) AS age,
		count AS numberOfFollowers
	FROM User u RIGHT JOIN followers_count f ON u.userID = f.userID
    ORDER BY numberOfFollowers DESC
    LIMIT 5;

CREATE OR REPLACE VIEW adsToEnqueueForReview AS     
	SELECT *
	FROM Ad
    WHERE status IN ('Active', 'Paused')
    AND bodyText LIKE '%sertraline%' OR bodyText LIKE '%Risperidone%';
    
/* Users */
drop user if exists DataScientist;
drop user if exists SecurityEngineer;
drop user if exists Accountant;
drop user if exists Sales;
drop user if exists CustomerSupport;
drop user if exists ContentReviewer;
  
create user DataScientist identified by 'DataSecret';
create user SecurityEngineer identified by 'SecuritySecret';
create user Accountant identified by 'AccountantSecret';
create user Sales identified by 'SalesSecret';
create user CustomerSupport identified by 'SupportSecret';
create user ContentReviewer identified by 'ReviewerSecret';

grant all on yellowpinkpenguin.* to DataScientist with grant option;

grant update, select on yellowpinkpenguin.* to SecurityEngineer;

grant insert, update, select on yellowpinkpenguin.BillingAccount to Accountant;
grant insert, update, select on yellowpinkpenguin.BillingAccEmails to Accountant;
grant insert, update, select on yellowpinkpenguin.BillingAccPhones to Accountant;
grant insert, update, delete, select on yellowpinkpenguin.Transaction to Accountant;
grant select on yellowpinkpenguin.revenuePerMonth to Accountant;
grant select on yellowpinkpenguin.billingAccManager to Accountant;

grant select on yellowpinkpenguin.adPerformanceStatisticOnPlatform to CustomerSupport;
grant select on yellowpinkpenguin.adPerformanceStatisticOffPlatform to CustomerSupport;
grant select on yellowpinkpenguin.Ad to CustomerSupport;
grant select on yellowpinkpenguin.AdCampaign to CustomerSupport;
grant select on yellowpinkpenguin.AdAccount to CustomerSupport;
grant select(firstName, lastName, phoneNumber, emailAddress) on yellowpinkpenguin.User to CustomerSupport;
grant update(firstName, lastName) on yellowpinkpenguin.User to CustomerSupport;
grant select on yellowpinkpenguin.manages to CustomerSupport;
grant select on yellowpinkpenguin.administers to CustomerSupport;
grant update(accessLevel) on yellowpinkpenguin.manages to CustomerSupport;
grant update(accessLevel) on yellowpinkpenguin.administers to CustomerSupport;

grant select on yellowpinkpenguin.revenuePerMonth to Sales;
grant select on yellowpinkpenguin.tier1Accounts to Sales;
grant select on yellowpinkpenguin.topInfluencers to Sales;

grant select on yellowpinkpenguin.adsToEnqueueForReview to ContentReviewer;
grant update, select on yellowpinkpenguin.Ad to ContentReviewer;
