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



SELECT authors.name, COUNT(loans.book_id) AS books_rented
FROM loans
         JOIN books ON loans.book_id = books.id
         JOIN authors ON books.id = authors.id
WHERE YEAR(loans.loan_date) = 2023
GROUP BY authors.name
ORDER BY books_rented DESC;