/* View */
CREATE VIEW Forestation AS
SELECT f.country_code,f.year,f.country_name,f.forest_area_sqkm,
l.total_area_sq_mi,r.region,r.income_group, 
((f.forest_area_sqkm * 100 ) / (l.total_area_sq_mi * 2.59)) AS Forest
FROM forest_area f
INNER JOIN land_area l ON f.country_code = l.country_code AND
f.year = l.year
INNER JOIN regions r ON
r.country_code = f.country_code