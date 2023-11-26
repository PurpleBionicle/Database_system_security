INSERT INTO "Watches" (price,data_of_bying , id_material, id_country , id_watches)
VALUES (2000,'2008-11-11',3,2,7);

SELECT * FROM "Watches";
DELETE FROM "Watches" WHERE price>1001;

SELECT * FROM "Watches";

UPDATE "Watches"
SET price = 10
WHERE id_country=5;

SELECT * FROM "Watches";

SELECT price,id_watches
FROM "Watches"
WHERE price BETWEEN 0 and 38 AND id_material= (SELECT id_material
											  FROM "material"
											  WHERE material Like 'g%')
ORDER BY id_watches;