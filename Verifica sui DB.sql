-- Selezionare tutte le nazioni il cui nome inizia con la P e la cui
-- area è maggiore di 1000 kmq
select name, area
from countries 
where `name`regexp '^P' and area > 1000 ;

-- Selezionare le nazioni il cui national day è avvenuto più di
-- 100 anni fa
select name , national_day , country_code2 
from countries
where timestampdiff (year,`national_day`,curdate()) > 100;

-- Selezionare il nome delle regioni del continente europeo, in
-- ordine alfabeticoà
select regions.name , continents.name 
from regions 
inner join continents 
on continents.continent_id = regions.continent_id 
where continents.name like 'europe'
order by regions.name;

-- Contare quante lingue sono parlate in Italia
select count(*) as numero_di_lingue_parlate 
from languages
inner join country_languages 
on country_languages.language_id = languages.language_id 
inner join countries 
on countries.country_id = country_languages.country_id 
where countries.name like 'italy';

-- Selezionare quali nazioni non hanno un national day
select *
from countries c 
where c.national_day is null;

-- Per ogni nazione selezionare il nome, la regione e il
-- continente
select c.name as nome_nazione , r.name as nome_regione, c2.name as nome_continente
from countries c 
inner join regions r 
on r.region_id = c.region_id 
inner join continents c2 
on c2.continent_id = r.continent_id 

-- Modificare la nazione Italy, inserendo come national day il 2
-- giugno 1946
update countries set national_day = '1946-06-02'
where countries.name = 'italy';

-- Per ogni regione mostrare il valore dell'area totale
select sum(countries.area) as area_totale ,  regions.name 
from countries
inner join regions
on regions.region_id = countries.region_id 
group by regions.name 
order by area_totale;

-- Selezionare le lingue ufficiali dell'Albania
select l.`language` 
from languages l 
inner join country_languages cl 
on l.language_id = cl.language_id 
inner join countries c
on cl.country_id = c.country_id 
where c.name ='albania' and cl.official is true;

-- Selezionare il Gross domestic product (GDP) medio dello
-- United Kingdom tra il 2000 e il 2010
select avg(cs.gdp) as gdp_medio
from country_stats cs
inner join countries c 
on cs.country_id = c.country_id 
where c.name = 'united kingdom' and cs.`year` between 2000 and 2010; 

--  Selezionare tutte le nazioni in cui si parla hindi, ordinate
-- dalla più estesa alla meno estesa
select c.name ,l.`language` 
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id =cl.language_id 
where l.`language` = 'hindi';

-- Per ogni continente, selezionare il numero di nazioni con
-- area superiore ai 10.000 kmq ordinando i risultati a partire dal
-- continente che ne ha di più
select count(c2.country_id) as numero_di_nazioni 
from continents c 
inner join regions r 
on r.continent_id = c.continent_id 
inner join countries c2 
on c2.region_id = r.region_id 
group by c.continent_id 
order by numero_di_nazioni desc;
