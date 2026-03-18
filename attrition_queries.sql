/* 1. CÁLCULO DE TOTALES Y ATTRITION RATE
Sirve para validar los KPIs principales del encabezado del dashboard.
*/
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100, 2) AS attrition_rate
FROM HR_Data;

/* 2. RELACIÓN ENTRE OVERTIME Y SATISFACCIÓN
Esta consulta demuestra el hallazgo principal: ¿el Overtime afecta la satisfacción?
*/
SELECT 
    OverTime,
    JobSatisfaction,
    COUNT(*) AS employee_count
FROM HR_Data
GROUP BY OverTime, JobSatisfaction
ORDER BY OverTime, JobSatisfaction DESC;

/* 3. IMPACTO DE LA DISTANCIA AL HOGAR
Segmentamos la distancia para ver dónde empieza el riesgo de renuncia.
*/
SELECT 
    CASE 
        WHEN DistanceFromHome <= 5 THEN 'Short'
        WHEN DistanceFromHome <= 15 THEN 'Medium'
        ELSE 'Long' 
    END AS distance_range,
    COUNT(*) AS attrition_count
FROM HR_Data
WHERE Attrition = 'Yes'
GROUP BY 1;