SELECT * FROM 'datos-precipitacion-72202';
-- vemos que hay datos con -1

SELECT COUNT(*) FROM 'datos-precipitacion-72202'; 

DELETE FROM 'datos-precipitacion-72202'
WHERE precipitacion = '-1';                  

SELECT AVG(precipitacion), MAX(precipitacion), MIN(precipitacion) FROM 'datos-precipitacion-72202';

SELECT * FROM 'datos-atmosfericos-72202';

SELECT COUNT(*) FROM 'datos-atmosfericos-72202';

DELETE FROM 'datos-atmosfericos-72202'
WHERE Showalter = '-1' OR Lifted = '-1' OR SWEAT = '-1' OR K = '-1' OR CrossTotals = '-1' OR VerticalTotals = '-1' OR
TotalTotals = '-1' OR CAPE = '-1' OR ConvectiveInhibition = '-1' OR BulkRichardson = '-1' OR PrecipitableWater = '-1';

SELECT da.ano, da.mes, da.dia, da.Showalter, da.Lifted, da.SWEAT, da.K, da.CrossTotals, da.VerticalTotals, da.TotalTotals, da.CAPE,
da.ConvectiveInhibition, da.BulkRichardson, da.PrecipitableWater, dp.precipitacion FROM 'datos-atmosfericos-72202' da, 'datos-precipitacion-72202' dp 
WHERE da.ano = dp.ano AND da.mes = dp.mes AND da.dia = dp.dia;

CREATE TABLE "datos-finales-72202" (
	`ano`	TEXT,
	`mes`	TEXT,
	`dia`	TEXT,
	`Showalter`	TEXT,
	`Lifted`	TEXT,
	`SWEAT`	TEXT,
	`K`	TEXT,
	`CrossTotals`	TEXT,
	`VerticalTotals`	TEXT,
	`TotalTotals`	TEXT,
	`CAPE`	TEXT,
	`ConvectiveInhibition`	TEXT,
	`BulkRichardson`	TEXT,
	`PrecipitableWater`	TEXT,
	`Precipitacion`	TEXT
);

INSERT INTO 'datos-finales-72202'
	SELECT da.ano, da.mes, da.dia, da.Showalter, da.Lifted, da.SWEAT, da.K, da.CrossTotals, da.VerticalTotals, da.TotalTotals, da.CAPE,
	da.ConvectiveInhibition, da.BulkRichardson, da.PrecipitableWater, dp.precipitacion FROM 'datos-atmosfericos-72202' da, 'datos-precipitacion-72202' dp 
	WHERE da.ano = dp.ano AND da.mes = dp.mes AND da.dia = dp.dia;
	
SELECT COUNT(*) FROM 'datos-finales-72202';