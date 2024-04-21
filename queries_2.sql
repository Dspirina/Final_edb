SELECT
    b.title AS book_title,
    COUNT(*) AS total_rentals
FROM
    loans l
        JOIN
    books b ON l.book_id = b.id
WHERE
    YEAR(l.loan_date) = 2023
GROUP BY
    b.title
ORDER BY
    total_rentals DESC;

SELECT DISTINCT a.name_au
FROM authors a
         JOIN books_authors ba ON a.id = ba.author_id
         JOIN books b ON ba.book_id = b.id
WHERE (
          SELECT COUNT(*)
          FROM books_authors
          WHERE author_id = a.id
      ) = 1
  AND (
          SELECT COUNT(*)
          FROM books
          WHERE publisher_id = b.publisher_id
      ) = 1;




SELECT
    title,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM loans
            WHERE book_id = b.id AND return_date IS NULL
        ) THEN 'Not Available'
        ELSE CONCAT('Available from ', (
            SELECT DATE_ADD(MIN(return_date), INTERVAL 1 DAY)
            FROM loans
            WHERE book_id = b.id AND return_date > CURDATE()
        ))
        END AS availability
FROM
    books b;