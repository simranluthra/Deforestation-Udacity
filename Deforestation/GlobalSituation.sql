/*  Ques 1 */
/* What was the total forest area (in sq km) of the world in 1990?  */

select sum(forest_area_sqkm) from forestation 
where year = 1990 and country_name = 'World'


/* Ques 2 */
/* What was the total forest area (in sq km) of the world in 2016?  */

select sum(forest_area_sqkm) from forestation 
where year = 2016 and country_name = 'World'

/* Ques 3 */
/* What was the change (in sq km) in the forest area of the world from 1990 to 2016? */

SELECT ( (select sum(forest_area_sqkm)
from forestation where year = 1990 and country_name = 'World') - (select sum(forest_area_sqkm)
from forestation where year = 2016 and country_name = 'World')) AS change

/* Ques 4 */
/* What was the percent change in forest area of the world between 1990 and 2016? */

SELECT (((select sum(forest_area_sqkm)
from forestation where year = 1990 and country_name = 'World') - (select sum(forest_area_sqkm)
from forestation where year = 2016 and country_name = 'World'))*100) /
((select sum(forest_area_sqkm)
from forestation where year = 1990 and country_name = 'World'))
AS percentchange


/* Ques 5 */
/*  If you compare the amount of forest area lost between 1990 and 2016, 
to which country's total area in 2016 is it closest? */

select total_land_area, country_name 
from (select sum(total_area_sq_mi*2.59) 
      as total_land_area,country_name 
	  from forestation 
      where year = 2016 
      group by country_name 
      order by total_land_area desc)
      as land_area_16
where total_land_area <
(SELECT (
  (select sum(forest_area_sqkm)
	from forestation where year = 1990 and country_name = 'World') - 
  	(select sum(forest_area_sqkm)
	from forestation where year = 2016 and country_name = 'World'))) 
limit 1;