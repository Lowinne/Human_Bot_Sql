CREATE VIEW ALL_WORKERS AS
SELECT last_name AS lastname,
       first_name AS firstname,
       age,
       first_day AS start_date 
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
UNION ALL
SELECT last_name AS lastname,
       first_name AS firstname,
       NULL AS age,
 start_date
FROM WORKERS_FACTORY_2
WHERE end_date IS NULL
ORDER BY start_date DESC;


CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT lastname,
       firstname,
       age,
       start_date,
       DATEDIFF(CURRENT_DATE, start_date) AS days_elapsed
FROM ALL_WORKERS;


CREATE VIEW BEST_SUPPLIERS AS
SELECT s.name,
       SUM(sb.quantity) AS total_pieces_delivered
FROM SUPPLIERS s
JOIN SUPPLIERS_BRING_TO_FACTORY_1 sb ON s.supplier_id = sb.supplier_id
GROUP BY s.name
HAVING SUM(sb.quantity) > 1000
ORDER BY total_pieces_delivered DESC;


CREATE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id,
       r.model,
       f.main_location AS assembly_factory
FROM ROBOTS r
JOIN ROBOTS_FROM_FACTORY rf ON r.id = rf.robot_id
JOIN FACTORIES f ON rf.factory_id = f.id;


