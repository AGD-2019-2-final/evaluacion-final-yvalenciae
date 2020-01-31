-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

file = FOREACH u GENERATE $3,ToDate($3,'yyyy-MM-dd');
file = FOREACH file GENERATE $0, GetYear($1);
file = GROUP file BY $1;
file = FOREACH file GENERATE $0, COUNT(file);
STORE file INTO 'output' USING PigStorage(',');
