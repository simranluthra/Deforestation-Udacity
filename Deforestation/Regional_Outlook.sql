
/* Create a table that shows the Regions and
 their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016 */

SELECT region,year, 
(sum(forest_area_sqkm)*100)/(sum(total_area_sq_mi*2.59))
AS region_forest_area
INTO Regions_data
FROM Forestation
where year in ('1990','2016')
Group by region, year

/* Ques 1 */
/* What was the percent forest of the entire world in 2016? */

select cast((region_forest_area) as decimal(10,2))
from Regions_data
where year = 2016 and region='World'


/* Which region had the HIGHEST percent forest in 2016 */

select region, cast((region_forest_area) as decimal(10,2)) 
AS Highest_percent_forest
from Regions_data
where year = 2016
order by Highest_percent_forest  desc 
limit 1;

/* Which region had the LOWEST percent forest in 2016 */

select region, cast((region_forest_area) as decimal(10,2)) 
AS lowest_percent_forest
from Regions_data
where year = 2016
order by Highest_percent_forest  asc 
limit 1;


/* Ques 2 */
/* What was the percent forest of the entire world in 1990?  */

select cast((region_forest_area) as decimal(10,2))
from Regions_data
where year = 1990 and region='World'

/* Which region had the HIGHEST percent forest in 1990 */

select region, cast((region_forest_area) as decimal(10,2)) 
AS Highest_percent_forest
from Regions_data
where year = 1990
order by Highest_percent_forest  desc 
limit 1;

/* Which region had the LOWEST percent forest in 1990 */

select region, cast((region_forest_area) as decimal(10,2)) 
AS lowest_percent_forest
from Regions_data
where year = 1990
order by Highest_percent_forest  asc 
limit 1;



/* Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016? */

select r.region, cast((r.region_forest_area) as decimal(10,2))
AS Forest_percentage_1990, cast((d.region_forest_area) as decimal(10,2))
AS Forest_percentage_2016
from Regions_data r
INNER JOIN Regions_data d
 ON r.region = d.region
 where r.year = 1990 and d.year = 2016
 and cast((r.region_forest_area) as decimal(10,2)) > cast((d.region_forest_area) as decimal(10,2))







