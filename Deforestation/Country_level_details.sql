/* Ques 1 */
/* Which country saw the largest amount increase in forest area from 1990 to 2016? */

select fa.country_name, fa.forest_area_sqkm
AS Forest_area_1990, faa.forest_area_sqkm
AS Forest_area_2016, faa.forest_area_sqkm- fa.forest_area_sqkm 
AS difference
from forest_area fa
INNER JOIN forest_area faa
 ON fa.country_name = faa.country_name
 where fa.year = 1990 and faa.year = 2016
 and fa.forest_area_sqkm < faa.forest_area_sqkm
 order by difference desc
limit 1;


/* Which country saw the 2nd largest increase over this time period?  */

select fa.country_name, fa.forest_area_sqkm
AS Forest_area_1990, faa.forest_area_sqkm
AS Forest_area_2016, faa.forest_area_sqkm- fa.forest_area_sqkm 
AS difference
from forest_area fa
INNER JOIN forest_area faa
 ON fa.country_name = faa.country_name
 where fa.year = 1990 and faa.year = 2016
 and fa.forest_area_sqkm < faa.forest_area_sqkm
 order by difference desc
limit 2
offset 1;


/* Ques 2 */

/* Which country saw the largest percent increase in forest area from 1990 to 2016?  */

select fa.country_name, fa.Forest
AS Forest_percentarea_1990, faa.Forest
AS Forest_percentarea_2016,
cast((faa.Forest) as decimal(10,2)) - cast((fa.Forest) as decimal(10,2))
AS difference
from Forestation fa
INNER JOIN Forestation faa
 ON fa.country_name = faa.country_name
 where fa.year = 1990 and faa.year = 2016
 and fa.Forest < faa.Forest
 order by difference desc
limit 1;


/* 2 largest countries in total land area*/

select country_name, sum(total_area_sq_mi*2.59) 
as total_land_area from Forestation
where total_area_sq_mi is not null and country_name != 'World'
and year=2016
group by  country_name
order by total_land_area desc
limit 2;


/*  Que3 */

/* Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? */

select fa.country_name, fa.region, fa.forest_area_sqkm- faa.forest_area_sqkm 
AS difference
from Forestation fa
INNER JOIN Forestation faa
 ON fa.country_name = faa.country_name
 where fa.year = 1990 and faa.year = 2016
 and fa.forest_area_sqkm > faa.forest_area_sqkm
 and fa.country_name != 'World'
 order by difference desc
limit 5;


/* Ques 4 */
/* Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? */

select fa.country_name, fa.region,
cast((fa.Forest) as decimal(10,2)) - cast((faa.Forest) as decimal(10,2))
AS difference
from Forestation fa
INNER JOIN Forestation faa
 ON fa.country_name = faa.country_name
 where fa.year = 1990 and faa.year = 2016
 and fa.Forest > faa.Forest
 order by difference desc
limit 5;


/* Ques - 5 */
/*  If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016? */

select t.range, count(*)
from (
  select 
  case  
    when Forest between 0 and 25 then ' 0- 25'
    when Forest between 25 and 50 then '25-50'
  	when Forest between 50 and 75 then '50-75'
    else '75-100' end as range
  from Forestation where year = 2016 and Forest IS NOT NULL) t
group by t.range 
order by t.range, count desc 
limit 1;

/* Que - 6 */
/* List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016. */
select country_name, region, Forest
from Forestation
where Forest>75 and year = 2016

/* Que - 7 */
/* How many countries had a percent forestation higher than the United States in 2016? */

select country_name 
from Forestation 
where year = 2016 and country_name != 'United States' and Forest >
(select Forest from Forestation
where country_name = 'United States' and year = 2016)