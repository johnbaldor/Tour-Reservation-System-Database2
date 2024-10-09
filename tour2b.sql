SELECT 
    g.title AS GuideLevel,
    COUNT(*) AS Mismatches
FROM 
    ReservedTours rt
JOIN 
    Tours t ON rt.tourID = t.tourID
JOIN 
    Guides g ON rt.guideID = g.guideID
WHERE 
    (t.vehicleType = 'boat' AND g.licenseType NOT IN ('sea', 'both')) OR
    (t.vehicleType = 'bus' AND g.licenseType NOT IN ('land', 'both')) OR
    (t.vehicleType = 'car' AND g.licenseType NOT IN ('land', 'both'))
GROUP BY 
    g.title;
    
/*Using natural joins automatically join tables with columns of the same name.
in a problem where we need to compare the vehicle type for a tour with the license type of a guide,
natural joins would add more columns because of shared column names beyond just tourID and guideID. The unintended join 
conditions would break the comparison between vehicle type and license type. so we use explicit join conditions to 
accurately define the relationships between tables.
*/

UPDATE ReservedTours rt
SET price = (
    SELECT t.price
    FROM Tours t
    WHERE rt.tourID = t.tourID
);



SELECT 
    c.firstName,
    c.lastName,
    TO_CHAR(SUM(rt.price), '9999990.00') AS TotalLandPrice
FROM 
    Customers c
JOIN 
    ReservedTours rt ON c.customerID = rt.customerID
JOIN 
    Tours t ON rt.tourID = t.tourID
WHERE 
    t.vehicleType IN ('bus', 'car')
GROUP BY 
    c.firstName, c.lastName
ORDER BY 
    TotalLandPrice DESC, c.lastName, c.firstName;

    
    
   
SELECT 
    t.vehicleType,
    l.locationType,
    COUNT(*) AS Places
FROM 
    Locations l
JOIN 
    Tours t ON l.tourID = t.tourID
GROUP BY 
    t.vehicleType, l.locationType
HAVING 
    COUNT(*) > 1;
    
    
    
    
SELECT 
    g.firstName || ' ' || g.lastName AS GuideName,
    TO_CHAR(SUM(rt.price * 1.10), '999,999,990.00') AS TotalRevenue
FROM 
    Guides g
JOIN 
    ReservedTours rt ON g.guideID = rt.guideID
GROUP BY 
    g.firstName, g.lastName;


