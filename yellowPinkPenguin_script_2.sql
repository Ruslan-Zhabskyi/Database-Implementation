USE yellowpinkpenguin;

/*Query views*/
SELECT * FROM revenuePerMonth;
SELECT * FROM tier1Accounts;
SELECT * FROM adPerformanceStatisticOnPlatform;
SELECT * FROM adPerformanceStatisticOffPlatform;
SELECT * FROM billingAccManager;
SELECT * FROM topInfluencers;
SELECT * FROM adsToEnqueueForReview;

/*Query tables created as part of triggers set up*/
UPDATE User SET emailAddress = 'new_email@example.com' WHERE userID = 1; /* creates trigger input for user_previous_emails table*/
SELECT * FROM user_previous_emails;
SELECT * FROM followers_count;

/*Other frequently used queries for the database*/

/*Return image ads performance on partner's platforms for the 3rd quarter*/
SELECT
	ad.adID AS 'Ad Id',
	ad.status AS 'Ad Status',
	camp.campaignID AS 'Campaign Id',
	acc.adAccountID AS 'Ad Account Id',
	p.name AS 'Publisher Name',
	SUM(h.adImpressions) AS 'Ad Impressions',
	SUM(h.adClicks) AS 'Ad Clicks',
	ROUND((SUM(h.adClicks) / SUM(h.adImpressions) * 100), 2) AS 'Click-Through Rate'
FROM Ad ad LEFT JOIN AdCampaign camp ON ad.campaignID = camp.campaignID 
	LEFT JOIN AdAccount acc ON acc.adAccountID = camp.adAccountID
	LEFT JOIN hosts h ON ad.adID = h.adID
	LEFT JOIN Publisher p ON p.publisherID = h.publisherID
WHERE 
	ad.imageID IS NOT NULL 
	AND ad.status = 'Active'
	AND h.dateOfInteraction BETWEEN '2023-07-01' AND '2023-09-30'
GROUP BY 
	ad.adID,
	ad.status,
	ad.type,
	camp.campaignID,
	acc.adAccountID,
	p.name    
ORDER BY SUM(h.adImpressions) DESC;
    

/*Return number of users in Ukraine*/
SELECT 
	count(userID) AS 'Number of Users'
FROM User 
WHERE accountLocation IN 
  (SELECT accountLocation 
   FROM User 
   WHERE accountLocation LIKE "%Ukraine%");

/*Return accounts where Ad Account - Billing country mismatch is present*/
SELECT
	a.adAccountID AS 'Ad Account Id',
	a.country AS 'Ad Account Country',
	b.country AS 'Billing Account Country'
FROM AdAccount a JOIN BillingAccount b ON a.billingAccountID = b.billingAccountID
WHERE a.country <> b.country;

/*Bellow average transactions*/
SELECT 
    transactionNumber AS 'Transaction Number',
    transactionAmount AS 'Transaction Amount',
    DATE_FORMAT(transactionDate, "%b %d, %Y") AS 'Transaction Date'
FROM Transaction
WHERE transactionAmount < (SELECT AVG(transactionAmount) FROM Transaction)
ORDER BY transactionDate, transactionAmount;

/*User Interests on the platform*/
SELECT interests AS 'Interests',
ROUND((COUNT(userID) / (SELECT COUNT(DISTINCT userID) FROM UserInterests)) * 100, 2) AS 'Percentage of Users'
FROM UserInterests
GROUP BY interests
ORDER BY COUNT(userID) DESC;

/*Transactions summary for a Billing Accounts in Ukraine and Ireland*/
SELECT 
	companyName AS 'Company Name',
	paymentMethod AS 'Payment Method',
	COUNT(transactionNumber) AS 'Number of Transactions',
	SUM(transactionAmount) AS 'Total Spent',
	ROUND(AVG(transactionAmount), 2) AS 'Average Transaction Amount',
	MIN(transactionDate) AS 'First Transaction',
	MAX(transactionDate) AS 'Last Transaction'
FROM billingAccount b JOIN Transaction t ON b.billingAccountId = t.billingAccountId
WHERE country IN ('Ireland', 'Ukraine')
	AND status = 'Active'
GROUP BY companyName, paymentMethod
HAVING COUNT(transactionNumber) >=1
ORDER BY COUNT(transactionNumber) DESC;



