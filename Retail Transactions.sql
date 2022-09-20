--- Title :-        Retail Transactions
--- Created by :-   Hardi Jain & Vinit Sangoi
--- Date :-         20-09-2022
--- Tool used:-     PostgreSQL

/*
Description :- 
		• This is a Retail Transations SQL Project. This database contains 1 tables retail.
		• Retail table has 9000 rows.
		• In this project, Hardi Jain & Vinit Sangoi worked together.
		
Approach :- 
		• Understanding the dataset
		• Creating business questions
		• Analysing through SQL queries
*/



--- Q1) Create a table named 'retail' with appropriate data types for columns

Create table retail
(  
	transaction_date 	date,
	transaction_hour 	time,
	location_state 		varchar,
	location_city 		varchar,
	rewards_number 		varchar,
	rewards_member 		varchar,
	num_of_items 		integer,
	coupon_flag 		varchar,
	discount_amt 		decimal,
	order_amt 			decimal
);


--- Q2) Import data from csv file 'Retail Transactions.csv' attached in resources to 'Retail' table

Copy retail from '/Applications/PostgreSQL 14/Resources/Project/Retail Transactions.csv' CSV header;

SELECT * From retail;


--- Q3) Get an output with a total Order amount month wise sorted by months in a descening order

SELECT 	 Extract(month from transaction_date) as Month, sum(order_amt)
FROM 	 retail
GROUP BY Month
ORDER BY Month desc;


--- Q4) Get an output with a total Order amount month wise sorted by ordered amount highest to lowest

SELECT 	 Extract(month from transaction_date) as Month, sum(order_amt)
FROM 	 retail
GROUP BY Month
ORDER BY sum(order_amt) desc;


--- Q5) Get an output which represents maxium ordered amount

SELECT 	Max(sales)
FROM    (SELECT Extract(month from transaction_date) as Month, sum(order_amt) as Sales
      	 FROM retail
         GROUP BY Month
         ORDER BY sum(order_amt) desc) as Maxsales;
	  
	  
--- Q6) Get the min order amount(Method : View)

CREATE VIEW MINSales as 
SELECT 	 Extract(month from transaction_date) as Month, sum(order_amt) as Sales
FROM 	 retail
GROUP BY Month
ORDER BY SUM(order_amt) desc;


SELECT 	MIN(Sales)
FROM 	Minsales;


--- Q7) Get the min order amount(Method : Subquery)

SELECT 	Min(sales)
FROM 	(SELECT Extract(month from transaction_date) as Month, sum(order_amt) as Sales
      	 FROM retail
     	 GROUP BY Month
     	 ORDER BY sum(order_amt) desc) as Minsales;
	
	
--- Q8) Get an output presenting total Order amount for each city from high to low

SELECT   location_city, sum(order_amt) as sales
FROM 	 Retail
GROUP BY location_city
ORDER BY sales desc;


--- Q9) Get an output presenting total Order amount for each state from high to low

SELECT   location_state, sum(order_amt) as sales
FROM 	 Retail
GROUP BY location_state
ORDER BY sales desc;


--- Q10)Get an output presenting total Order amount for each made by company in every hour

SELECT 	 extract( hour from transaction_hour) as hours,sum(order_amt) as sales
FROM 	 retail
GROUP BY hours
Order by sales desc;


--- Q11) Get an output presenting Count of rewards which were genuine

SELECT 	COUNT(rewards_number)
FROM 	retail
WHERE 	rewards_member = 'TRUE';


--- Q12) Get an output presenting Count of rewards which were fake

SELECT 	COUNT(rewards_number)
FROM 	retail
WHERE 	rewards_member = 'FALSE';


--- Q13) Give an output which represents total, max, min, avg Discount given to Customers in each city

SELECT 	 location_city, sum(discount_amt),Round(AVG(discount_amt),2),min(discount_amt),max(discount_amt)
FROM 	 retail
GROUP BY location_city
ORDER BY sum(discount_amt) desc;


--- Q14) Calculate the Discount % given to Customers in each city. */

SELECT 	 location_city, round(sum(discount_amt) * 100 /Sum(order_amt),2) as Discount_perc
FROM 	 retail
GROUP BY location_city
ORDER BY Discount_perc desc;


--- Q15) Give an output which represents total, max, min, avg Ordered Amount by Customers in each city

SELECT 	 location_city, sum(order_amt),AVG(order_amt),min(order_amt),max(order_amt)
FROM 	 retail
GROUP BY location_city
ORDER BY SUM(order_amt) desc;


--- Q16) Give an output which represents total, max, min, avg No.of Orders by Customers in each city

SELECT location_city, sum(num_of_items),round(AVG(num_of_items),2),min(num_of_items),max(num_of_items)
FROM retail
GROUP BY location_city
ORDER BY sum(num_of_items) desc;


--- Q17) Give an output for total sales of a state with the maximum city

SELECT location_state,location_city, sum(order_amt) as Sales
FROM retail
GROUP BY  location_state,location_city
ORDER BY location_state,sum(order_amt) desc;

