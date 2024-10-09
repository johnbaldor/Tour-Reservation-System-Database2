DROP TABLE ReservedTours;
DROP TABLE Customers;
DROP TABLE Tours;
DROP TABLE Locations;
DROP TABLE Guides;

DROP SEQUENCE reservedTourIDSequence;
DROP SEQUENCE customerIDSequence;
DROP SEQUENCE tourIDSequence;
DROP SEQUENCE guideIDSequence;

CREATE TABLE Customers (
    customerID NUMBER(3),
    firstName VARCHAR2(15),
    lastName VARCHAR2(20),
    address VARCHAR2(30),
    phone NUMBER(10),
    age NUMBER(3),
    CONSTRAINT pkC PRIMARY KEY (customerID),
    CONSTRAINT uqCp UNIQUE (phone),
    CONSTRAINT nnCa CHECK (age IS NOT NULL)
);

CREATE TABLE Tours (
    tourID NUMBER(2),
    tourName VARCHAR2(25),
    description VARCHAR2(35),
    city VARCHAR2(25),
    state CHAR(2),
    vehicleType VARCHAR2(10),
    price NUMBER(5,2),
    CONSTRAINT pkT PRIMARY KEY (tourID),
    CONSTRAINT ckTv CHECK (vehicleType IN ('boat', 'bus', 'car'))
);


CREATE TABLE Locations (
    locationID CHAR(3),
    locationName VARCHAR2(40),
    locationType VARCHAR2(15),
    address VARCHAR2(40),
    tourID NUMBER(2),
    CONSTRAINT pkL PRIMARY KEY (locationID),
    CONSTRAINT fkLt FOREIGN KEY (tourID) REFERENCES Tours(tourID) ON DELETE CASCADE
);

CREATE TABLE Guides (
    guideID NUMBER(2),
    firstName VARCHAR2(15),
    lastName VARCHAR2(20),
    driverLicense NUMBER(8),
    title VARCHAR2(15),
    salary NUMBER(7,2),
    licenseType VARCHAR2(10),
    CONSTRAINT pkG PRIMARY KEY (guideID),
    CONSTRAINT uqGd UNIQUE (driverLicense),
    CONSTRAINT nnGd CHECK (driverLicense IS NOT NULL),
    CONSTRAINT ckGl CHECK (licenseType IN ('land', 'sea', 'both'))
);

CREATE TABLE ReservedTours (
    reservedTourID NUMBER(3),
    travelDate DATE,
    customerID NUMBER(3),
    tourID NUMBER(2),
    guideID NUMBER(2),
    price NUMBER(6,2),
    CONSTRAINT pkR PRIMARY KEY (reservedTourID),
    CONSTRAINT fkRc FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE SET NULL,
    CONSTRAINT fkRt FOREIGN KEY (tourID) REFERENCES Tours(tourID) ON DELETE SET NULL,
    CONSTRAINT fkRg FOREIGN KEY (guideID) REFERENCES Guides(guideID) ON DELETE SET NULL
);


CREATE SEQUENCE customerIDSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tourIDSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE guideIDSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE reservedTourIDSequence START WITH 101 INCREMENT BY 1;

INSERT INTO Guides VALUES (1, 'Emily', 'Williams', 74920983, 'Senior Guide', 24125, 'land');
INSERT INTO Guides VALUES (2, 'Ethan', 'Brown', 72930684, 'Guide', 30500, 'sea');
INSERT INTO Guides VALUES (3, 'Chloe', 'Jones', 50973848, 'Senior Guide', 27044, 'both');
INSERT INTO Guides VALUES (4, 'Ben', 'Miller', 58442323, 'Junior Guide', 32080, 'both');
INSERT INTO Guides VALUES (5, 'Mia', 'Davis', 56719583, 'Junior Guide', 49000, 'land');
INSERT INTO Guides VALUES (6, 'Noah', 'Garcia', 93291234, 'Guide', 22000, 'land');
INSERT INTO Guides VALUES (7, 'Liam', 'Rodriguez', 58799394, 'Junior Guide', 31750, 'sea');
INSERT INTO Guides VALUES (8, 'Mason', 'Wilson', 88314545, 'Senior Guide', 45000, 'land');
INSERT INTO Guides VALUES (9, 'Olivia', 'Smith', 82391452, 'Junior Guide', 25025, 'sea');
INSERT INTO Guides VALUES (10, 'Sofia', 'Johnson', 12930638, 'Guide', 47000, 'both');

INSERT INTO Customers VALUES (1, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67);
INSERT INTO Customers VALUES (2, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20);
INSERT INTO Customers VALUES (3, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29);
INSERT INTO Customers VALUES (4, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18);
INSERT INTO Customers VALUES (5, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26);
INSERT INTO Customers VALUES (6, 'Madison', 'Powell', '100 Main St.', 8915367188, 57);
INSERT INTO Customers VALUES (7, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73);
INSERT INTO Customers VALUES (8, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18);
INSERT INTO Customers VALUES (9, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22);
INSERT INTO Customers VALUES (10, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25);
INSERT INTO Customers VALUES (11, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17);
INSERT INTO Customers VALUES (12, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45);
INSERT INTO Customers VALUES (13, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68);
INSERT INTO Customers VALUES (14, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19);
INSERT INTO Customers VALUES (15, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82);

-- Insert data into Tours
INSERT INTO Tours VALUES (1, 'Alcatraz', 'Alcatraz Island', 'San Francisco', 'CA', 'boat', 75.50);
INSERT INTO Tours VALUES (2, 'Magnificent Mile', 'Tour of Michigan Ave', 'Chicago', 'IL', 'bus', 22.75);
INSERT INTO Tours VALUES (3, 'Duck Tour', 'Aquatic tour of the Charles River', 'Boston', 'MA', 'boat', 53.99);
INSERT INTO Tours VALUES (4, 'Freedom Trail', 'Historic tour of Boston', 'Boston', 'MA', 'car', 34.25);
INSERT INTO Tours VALUES (5, 'NY Museums', 'Tour of NYC Museums', 'New York', 'NY', 'bus', 160.80);

-- Insert data into Locations
INSERT INTO Locations VALUES ('AI1', 'San Francisco Pier 33', 'Historic', 'Pier 33 Alcatraz Landing', 1);
INSERT INTO Locations VALUES ('AI2', 'Alcatraz Ferry Terminal', 'Historic', 'Ferry Terminal', 1);
INSERT INTO Locations VALUES ('AI3', 'Agave Trail', 'Park', 'Alcatraz Agave Trail', 1);
INSERT INTO Locations VALUES ('MM1', 'Art Institute', 'Museum', '111 S Michigan Avenue', 2);
INSERT INTO Locations VALUES ('MM2', 'Chicago Tribune', 'Historic', '435 N Michigan Avenue', 2);
INSERT INTO Locations VALUES ('MM3', 'White Castle', 'Restaurant', 'S Wabash Avenue', 2);
INSERT INTO Locations VALUES ('DT1', 'Charles River', 'Historic', '10 Mass Avenue', 3);
INSERT INTO Locations VALUES ('DT2', 'Salt and Pepper Bridge', 'Historic', '100 Broadway', 3);
INSERT INTO Locations VALUES ('FT1', 'Boston Common', 'Park', '139 Tremont Street', 4);
INSERT INTO Locations VALUES ('FT2', 'Kings Chapel', 'Historic', '58 Tremont Street', 4);
INSERT INTO Locations VALUES ('FT3', 'Omni Parker House', 'Restaurant', '60 School Street', 4);
INSERT INTO Locations VALUES ('FT4', 'Paul Revere House', 'Historic', '19 North Square', 4);
INSERT INTO Locations VALUES ('FT5', 'Bunker Hill Monument', 'Historic', 'Monument Square', 4);
INSERT INTO Locations VALUES ('NY1', 'Metropolitan Museum of Art', 'Museum', '1000 5th Ave', 5);
INSERT INTO Locations VALUES ('NY2', 'Museum of Modern Art', 'Museum', '11 W 53rd St', 5);
INSERT INTO Locations VALUES ('NY3', 'New York Botanical Garden', 'Park', '2900 Southern Boulevard', 5);
INSERT INTO Locations VALUES ('NY4', 'New Museum', 'Museum', '235 Bowery', 5);


INSERT INTO ReservedTours VALUES (101, TO_DATE('2022-05-10', 'YYYY-MM-DD'), 1, 1, 1, NULL);
INSERT INTO ReservedTours VALUES (102, TO_DATE('2022-06-15', 'YYYY-MM-DD'), 2, 2, 2, NULL);
INSERT INTO ReservedTours VALUES (103, TO_DATE('2022-07-20', 'YYYY-MM-DD'), 3, 3, 3, NULL);
INSERT INTO ReservedTours VALUES (104, TO_DATE('2022-08-25', 'YYYY-MM-DD'), 4, 4, 4, NULL);
INSERT INTO ReservedTours VALUES (105, TO_DATE('2022-09-30', 'YYYY-MM-DD'), 5, 5, 5, NULL);
INSERT INTO ReservedTours VALUES (106, TO_DATE('2022-10-05', 'YYYY-MM-DD'), 6, 1, 6, NULL);
INSERT INTO ReservedTours VALUES (107, TO_DATE('2022-11-10', 'YYYY-MM-DD'), 7, 2, 7, NULL);
INSERT INTO ReservedTours VALUES (108, TO_DATE('2022-12-15', 'YYYY-MM-DD'), 8, 3, 8, NULL);
INSERT INTO ReservedTours VALUES (109, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 9, 4, 9, NULL);
INSERT INTO ReservedTours VALUES (110, TO_DATE('2023-02-25', 'YYYY-MM-DD'), 10, 5, 10, NULL);
INSERT INTO ReservedTours VALUES (111, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 11, 1, 1, NULL);
INSERT INTO ReservedTours VALUES (112, TO_DATE('2023-04-15', 'YYYY-MM-DD'), 12, 2, 2, NULL);
INSERT INTO ReservedTours VALUES (113, TO_DATE('2023-05-20', 'YYYY-MM-DD'), 13, 3, 3, NULL);
INSERT INTO ReservedTours VALUES (114, TO_DATE('2023-06-25', 'YYYY-MM-DD'), 14, 4, 4, NULL);
INSERT INTO ReservedTours VALUES (115, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 15, 5, 5, NULL);
