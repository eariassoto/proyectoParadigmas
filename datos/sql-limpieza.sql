SELECT * FROM 'datos-precipitacion';
-- vemos que hay datos con -1

SELECT COUNT(*) FROM 'datos-precipitacion'; -- 7254 tuplas

SELECT COUNT(*) FROM 'datos-precipitacion'
WHERE precipitacion = '-1';                     -- 714 tuplas nulas

DROP TABLE "datos-precipitacion-limpios";
CREATE TABLE "datos-precipitacion-limpios" (
	"ano"  NOT NULL , 
	"mes"  NOT NULL , 
	"dia"  NOT NULL , 
	"precipitacion" , 
	PRIMARY KEY ("ano", "mes", "dia")
);

-- copiamos solo los valores no nulos a la nueva tabla
INSERT INTO 'datos-precipitacion-limpios'
	SELECT * FROM 'datos-precipitacion'
	WHERE precipitacion != '-1';
	
SELECT * FROM 'datos-atmosfericos'; 
-- vemos que hay datos en -1

SELECT COUNT(*) FROM 'datos-atmosfericos'; -- 3272 tuplas

DROP TABLE 'datos-atmosfericos-limpios';
CREATE TABLE "datos-atmosfericos-limpios" (
	"Ano"  NOT NULL , 
	"Mes"  NOT NULL , 
	"Dia"  NOT NULL , 
	"Showalter" , 
	"Lifted" , 
	"LiftVT" , 
	"SWEAT" , 
	"K" , 
	"CrossTotals" , 
	"VerticalTotals" , 
	"TotalTotals" , 
	"CAPE" , 
	"CAPEVT" , 
	"CI" , 
	"CIVT" , 
	"BRN" , 
	"BRNCAPV" , 
	"TempLCL" , 
	"PressLCL" , 
	"MeanPT" , 
	"MeanMR" , 
	"Thick" , 
	"PrecipWater" , 
	PRIMARY KEY ("Ano", "Mes", "Dia")
);

INSERT INTO 'datos-atmosfericos-limpios'
	SELECT "Ano" , 	"Mes", 	"Dia" , 	"Showalter" , 	"Lifted" ,	"LiftVT" , 	"SWEAT" , 	"K" , 	"CrossTotals" , 	"VerticalTotals" , 	"TotalTotals" , 
	"CAPE" , 	"CAPEVT" , 	"CI" , 	"CIVT" , 	"BRN" , 	"BRNCAPV" ,	"TempLCL" , 	"PressLCL"  ,	"MeanPT" , 	"MeanMR" , 	"Thick" , 	"PrecipWater"  
	FROM 'datos-atmosfericos';
	
SELECT * FROM 'datos-atmosfericos-limpios';
	
DELETE FROM 'datos-atmosfericos-limpios' WHERE Showalter = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE Lifted = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE LiftVT = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE SWEAT = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE K = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE CrossTotals = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE VerticalTotals = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE TotalTotals = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE CAPE = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE CAPEVT = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE CI = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE CIVT = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE BRN = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE BRNCAPV = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE TempLCL = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE PressLCL = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE MEANPT = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE MEANMR = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE Thick = '-1';
DELETE FROM 'datos-atmosfericos-limpios' WHERE PrecipWater = '-1';

SELECT COUNT(*) FROM 'datos-atmosfericos-limpios'; --2938 tuplas

--- datos en comun
DROP TABLE "datos-precipitacion-finales";
CREATE TABLE "datos-precipitacion-finales" (
	"ano"  NOT NULL , 
	"mes"  NOT NULL , 
	"dia"  NOT NULL , 
	"precipitacion" , 
	PRIMARY KEY ("ano", "mes", "dia")
);

INSERT INTO 'datos-precipitacion-finales'
	SELECT p.ano, p.mes, p.dia, p.precipitacion FROM 'datos-atmosfericos-limpios' AS a JOIN 'datos-precipitacion-limpios' AS p
	ON(a.ano = p.ano AND a.mes = p.mes AND a.dia = p.dia)
	ORDER BY p.ano, p.mes, p.dia;

DROP TABLE "datos-atmosfericos-finales";
CREATE TABLE "datos-atmosfericos-finales" (
	"Ano"  NOT NULL , 
	"Mes"  NOT NULL , 
	"Dia"  NOT NULL , 
	"Showalter" , 
	"Lifted" , 
	"LiftVT" , 
	"SWEAT" , 
	"K" , 
	"CrossTotals" , 
	"VerticalTotals" , 
	"TotalTotals" , 
	"CAPE" , 
	"CAPEVT" , 
	"CI" , 
	"CIVT" , 
	"BRN" , 
	"BRNCAPV" , 
	"TempLCL" , 
	"PressLCL" , 
	"MeanPT" , 
	"MeanMR" , 
	"Thick" , 
	"PrecipWater" , 
	PRIMARY KEY ("Ano", "Mes", "Dia")
);

INSERT INTO 'datos-atmosfericos-finales'
	SELECT a.Ano , 	a.Mes, 	a.Dia , a.Showalter , 	a.Lifted ,	a.LiftVT , 	a.SWEAT , 	a.K , 	a.CrossTotals , 	a.VerticalTotals , 	a.TotalTotals , 
	a.CAPE, 	a.CAPEVT , 	a.CI , 	a.CIVT , 	a.BRN, 	a.BRNCAPV ,	a.TempLCL, 	a.PressLCL ,	a.MeanPT , 	a.MeanMR , 	a.Thick , 	a.PrecipWater
	FROM 'datos-atmosfericos-limpios' AS a JOIN 'datos-precipitacion-limpios' AS p
	ON(a.ano = p.ano AND a.mes = p.mes AND a.dia = p.dia)
	ORDER BY p.ano, p.mes, p.dia;
	
SELECT COUNT(*) FROM 'datos-atmosfericos-finales';
SELECT COUNT(*) FROM 'datos-precipitacion-finales';
-- 2651 tuplas utiles