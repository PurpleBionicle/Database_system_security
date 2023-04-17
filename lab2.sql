-- 0
UPDATE "Watches"
SET data_of_bying = '2022-12-12'
WHERE price =37; 

-- 1)агрегатные функции
SELECT SUM(price) as "Стоимость всех товаров", MIN(price) as "Стоимость самых дешевых часов",
MAX(price) as "Стоимость самых дорогих часов", AVG(price) as "Средняя стоимость часов в магазине"
FROM "Watches";

-- 2)c объединением таблиц
SELECT price, material.material
FROM "Watches"
INNER JOIN material
ON "Watches".id_material = material.id_material;

-- 3) с вложенным запросом
SELECT price,id_watches
FROM "Watches"
WHERE price BETWEEN 0 and 38 AND id_material= (SELECT id_material
											  FROM "material"
											  WHERE material Like 'g%')
ORDER BY id_watches;

-- 4) с коррелированным вложенным запросом.
SELECT *
FROM "Watches" w
WHERE w.price = (SELECT min(ww.price)
                 FROM "Watches" ww
                 WHERE w.id_watches = ww.id_watches)
ORDER BY w.price DESC;

-- 5)Запросы  на основании
-- данных другой таблицы.
UPDATE vendor_country 
SET country = (SELECT material 
			   FROM material 
			   WHERE vendor_country.id_country = material.id_material)
WHERE id_country = 3;

SELECT * FROM vendor_country; 

-- возврат значения
UPDATE vendor_country 
SET country = 'Italy'
WHERE id_country = 3;

SELECT * FROM vendor_country; 

-- изменение : добавление столбца согласно значаениям из другой таблицы
ALTER TABLE "Watches"
 ADD IF NOT EXISTS material TEXT;

UPDATE "Watches"
SET material = (SELECT min(mat.material)
				FROM material mat
				WHERE mat.id_material = "Watches".id_material);
				
SELECT * FROM "Watches"; 
-- возврат значений
ALTER TABLE "Watches" DROP COLUMN material;

SELECT * FROM "Watches"; 


-- 6)Подсчет каких-либо частных итогов (количество продукции каждого
-- вида, средняя зарплата по каждому отделу и т. д.).
SELECT id_country,SUM(price)
FROM "Watches"
GROUP BY id_country;

-- 7. Глобальную временную таблицу с результатами запроса к
-- базе данных, вывести на экран ее содержимое.
DROP TABLE IF EXISTS Last_buiyng;

CREATE TEMPORARY TABLE Last_buiyng
(day_ DATE);

INSERT INTO Last_buiyng 
   (day_)
SELECT data_of_bying
FROM "Watches"
ORDER BY data_of_bying DESC
limit 1;
 
 
SELECT * FROM Last_buiyng;


-- 8)представление 
DROP VIEW  IF EXISTS last_buy;
		   
CREATE VIEW last_buy AS
SELECT data_of_bying
FROM "Watches"
ORDER BY data_of_bying DESC
limit 1;

SELECT * FROM last_buy;

-- попробовать изменить данные в представлении. - НЕЛЬЗЯ ! 

-- ALTER TABLE last_buy ADD COLUMN description text;
-- SELECT * FROM last_buy;

-- Изменить основную таблицу, изменились ли данные в представлении?
UPDATE "Watches"
SET data_of_bying = '2023-10-09'
WHERE price =37; 

SELECT * FROM last_buy;





