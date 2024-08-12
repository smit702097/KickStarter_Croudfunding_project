#group 4 ~ sumit


#Total Number of Projects
select count(ProjectID) as "Total Number of Projects" from projects;


#Total Number of Projects based on outcome
select state, count(projectID) as "Total Number of Projects"
from projects
group by state;

#Total number of projects based on location
select country, count(ProjectID) as "Total Number of Projects"
from projects
group by country;

#Total number of projects based on Category
select category_id,count(ProjectID)  as "Total Number of Projects"
from projects
group by category_id;

#Total number of project created by year, Quarter, Month
select year(FROM_UNIXTIME(created_at)) AS Year ,
concat("Q",quarter(FROM_UNIXTIME(created_at))) AS Quarter,
Month(FROM_UNIXTIME(created_at)) AS Month,
count(projectID) as "Total Number of Projects" from projects
group by Year,Quarter,Month;

#Successful Project based on:

#Amount Raised
select concat(Round(sum(CASE 
WHEN state = 'successful' THEN pledged
ELSE 0
END)  / 1000000000 ,2),"B") as AmountRaised 
from projects;

#Number of Backers
select count(backers_count) "Number of Backers" from projects 
where state = "successful";

#Avg no. of Days taken
select avg(datediff(FROM_UNIXTIME(successful_at),FROM_UNIXTIME(created_at))) "Avg. days Taken"
from projects
where state = "successful";

#Top successful projects based on no. of backers
select name, backers_count from projects
order by 2 desc
limit 10;

#Top successful projects based on Amount Raised
select name, 
case 
when state = "successful" then pledged
else 0
end as AmountRaised
from projects
order by 2 desc
limit 10;

#percentage of successful projects overall
select concat((sum(case when state = "successful" 
then 1 else 0 end)/ count(*)) * 100,"%") as percentage_successful
from projects;

#Percentage of successful projects by category  #doubtful
select category_id ,concat((sum(case when state = "successful" 
then 1 else 0 end)/ count(*)) * 100,"%") as percentage_successful 
from projects
group by category_id;

#percentage of succesfulproject by year, Quarter, month
select year(FROM_UNIXTIME(created_at)) AS Year ,
concat("Q",quarter(FROM_UNIXTIME(created_at))) AS Quarter,
Month(FROM_UNIXTIME(created_at)) AS Month,
concat((sum(case when state = "successful" 
then 1 else 0 end)/ count(*)) * 100,"%") as percentage_successful
from projects
group by Year,Quarter,Month;

#percentage of successful projects by goal range

select 
case 
when goal < 2501 then "0-2500"
when goal < 5001 then "0-5000"
when goal < 10001 then "0-10000"
when goal < 20001 then "0-20000"
when goal < 50001 then "0-50000"
when goal < 100001 then "0-100000"
when goal < 200001 then "0-200000"
when goal > 200000 then "200001+"  
end as GoalRange,
concat((sum(case when state = "successful" 
then 1 else 0 end)/ count(*)) * 100,"%") as percentage_successful
from projects
group by goalrange

