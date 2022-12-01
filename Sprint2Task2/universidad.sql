#1-Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
#El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT p.nombre AS pn, p.apellido1 AS pa1, p.apellido2 AS pa2 FROM persona AS p WHERE p.tipo = "alumno" ORDER BY pa1, pa2, pn;
#2-Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT p.nombre AS pn, p.apellido1 AS pa1, p.apellido2 AS pa2 FROM persona AS p WHERE p.tipo = "alumno" AND p.telefono IS NULL;
#3-Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona AS p WHERE p.tipo = "alumno" AND p.fecha_nacimiento >= '1999-01-01' AND p.fecha_nacimiento <= '1999-12-31';
#4-Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona AS p WHERE p.tipo = "profesor" AND p.nif LIKE "%K";
#5-Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura AS a  JOIN grado AS g ON g.id = a.id_grado WHERE g.id = 7 AND a.cuatrimestre = 1 AND a.curso = 3;
/*6-Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT p.nombre AS pn, p.apellido1 AS pa1, p.apellido2 AS pa2, d.nombre FROM persona AS p JOIN profesor AS pr ON p.id = pr.id_profesor JOIN departamento AS d ON d.id = pr.id_departamento ORDER BY pa1 , pa2 , pn;
#7-Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura AS a JOIN alumno_se_matricula_asignatura AS ama ON ama.id_alumno = a.id JOIN curso_escolar AS ce ON ama.id_curso_escolar = ce.id JOIN persona AS p ON ama.id_asignatura = p.id  WHERE p.nif = "26902806M";
#8-Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM persona AS p JOIN asignatura AS a ON p.id = a.id_profesor JOIN grado AS g ON g.id = a.id_grado JOIN profesor AS pr ON p.id = pr.id_profesor JOIN departamento AS d ON  d.id = pr.id_departamento WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)";
#9-Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.nombre AS pn, p.apellido1 AS pa1, p.apellido2 AS pa2 FROM persona AS p JOIN alumno_se_matricula_asignatura AS ama ON ama.id_alumno = p.id JOIN asignatura AS a ON ama.id_asignatura = a.id JOIN curso_escolar AS ce ON ama.id_curso_escolar = ce.id WHERE ce.anyo_inicio = '2018' AND ce.anyo_fin = '2019';
/*10-Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
SELECT d.nombre AS dn, p.apellido1 AS pa1, p.apellido2 AS pa2, p.nombre AS pn FROM persona AS p LEFT JOIN profesor AS pr ON p.id = pr.id_profesor LEFT JOIN departamento AS d ON d.id = pr.id_departamento ORDER BY dn ASC, pa1 ASC, pa2 ASC, pn ASC;
#11-Retorna un llistat amb els professors/es que no estan associats a un departament
SELECT p.id, p.nombre, p.apellido1, p.apellido2 FROM persona AS p LEFT JOIN profesor AS pr ON p.id = pr.id_profesor LEFT JOIN departamento AS d ON d.id = pr.id_departamento WHERE p.tipo = "profesor" AND d.nombre IS NULL;
#12-Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.id, d.nombre FROM persona AS p LEFT JOIN profesor AS pr ON p.id = pr.id_profesor RIGHT JOIN departamento AS d ON d.id = pr.id_departamento WHERE pr.id_departamento IS NULL;
#13-Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.id, p.nombre, p.apellido1, p.apellido2 FROM persona AS p LEFT JOIN asignatura AS a ON p.id = a.id_profesor WHERE p.tipo = "profesor" AND a.id_profesor IS NULL;
#14-Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.id, a.nombre FROM persona AS p RIGHT JOIN asignatura AS a ON p.id = a.id_profesor WHERE a.id_profesor IS NULL;
#15-Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.id, d.nombre FROM departamento AS d LEFT JOIN profesor AS pr On d.id = pr.id_departamento LEFT JOIN asignatura AS a On pr.id_profesor = a.id_profesor LEFT JOIN curso_escolar AS ce ON a.curso = ce.id WHERE ce.id IS NULL;
#16-Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(p.tipo) FROM persona AS p WHERE p.tipo  = "alumno";
#17-Calcula quants alumnes van néixer en 1999.
SELECT COUNT(p.tipo) FROM persona AS p WHERE p.tipo  = "alumno" AND p.fecha_nacimiento >= '1999-01-01' AND p.fecha_nacimiento <= '1999-12-31';
/*18-Calcula quants professors/es hi ha en cada departament. 
El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/
SELECT d.nombre, COUNT(pr.id_profesor) AS cpr FROM profesor AS pr JOIN departamento AS d On pr.id_departamento = d.id GROUP BY pr.id_departamento ORDER BY cpr DESC;
/*19-Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.*/
SELECT d.nombre, COUNT(pr.id_profesor) AS cpr FROM profesor AS pr RIGHT JOIN departamento AS d On pr.id_departamento = d.id GROUP BY d.id;
/*20-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT g.nombre, COUNT(a.id) AS na FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.id ORDER BY na DESC;
/*21-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, 
dels graus que tinguin més de 40 assignatures associades.*/
SELECT g.nombre, COUNT(a.id) AS na FROM grado AS g JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.id HAVING na > 40 ;
/*22-Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT g.nombre, a.tipo, SUM(a.creditos) FROM grado g JOIN asignatura AS a ON a.id_grado = g.id GROUP BY g.nombre, a.tipo;
/*23-Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.*/
SELECT ce.anyo_inicio, SUM(p.id) totalAlumnes FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno JOIN curso_escolar ce ON ce.id = ama.id_curso_escolar GROUP BY ce.id;
/*24-Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a.El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) suma_asignatures FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id ORDER BY suma_asignatures DESC;
#25-Retorna totes les dades de l'alumne/a més jove.*/
SELECT * FROM persona p ORDER BY p.fecha_nacimiento DESC LIMIT 1;
#26- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.id, p.nombre FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento LEFT JOIN asignatura a ON  p.id = a.id_profesor WHERE a.id IS NULL;




