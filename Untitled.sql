CREATE OR REPLACE VIEW customer_rental_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;
WITH customer_summary_cte AS (
    SELECT 
        crs.customer_name,
        crs.email,
        crs.rental_count,
        cps.total_paid,
        ROUND(cps.total_paid / crs.rental_count, 2) AS average_payment_per_rental
    FROM customer_rental_summary crs
    JOIN customer_payment_summary cps ON crs.customer_id = cps.customer_id
)

-- Final report
SELECT * FROM customer_summary_cte;
