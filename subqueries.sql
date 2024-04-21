﻿USE librarydb;

-- with non-correlated subqueries result
UPDATE books
SET price = price * 1.10
WHERE publisher_id = (
    SELECT id
    FROM publishers
    WHERE name_pub = 'Penguin Random House'
);
SELECT price FROM books;

-- IN with non-correlated subqueries result
DELETE loans
WHERE id IN (
    SELECT id
    FROM loans
    WHERE due_date < CURDATE() AND return_date IS NULL
);

SELECT id from loans;


-- NOT IN with non-correlated subqueries result
SELECT name
FROM customers
WHERE id NOT IN (
    SELECT DISTINCT customer_id
    FROM loans
);


-- EXISTS with non-correlated subqueries result
UPDATE books
SET price = price * 1.15
WHERE EXISTS (
    SELECT 1
    FROM books_authors
             INNER JOIN authors ON books_authors.author_id = authors.id
    WHERE books_authors.book_id = books.id
      AND authors.name_au = 'Stephen King'
);

SELECT price from books;

-- NOT EXISTS with non-correlated subqueries result (delete customers who didn't borrow anything)
DELETE FROM customers
WHERE NOT EXISTS (
    SELECT 1
    FROM loans
    WHERE loans.customer_id = customers.id
);

-- = with correlated subqueries result (prices of books with same genres)
UPDATE books b
    JOIN (
    SELECT genre_id, AVG(price) AS avg_price
    FROM books
    GROUP BY genre_id
    ) AS avg_prices ON b.genre_id = avg_prices.genre_id
    SET b.price = avg_prices.avg_price;


-- IN with correlated subqueries result (retrieves book IDs loans where return date is NULL)
DELETE FROM loans
WHERE book_id IN (
    SELECT book_id
    FROM (
             SELECT book_id
             FROM loans
             WHERE return_date IS NOT NULL
         ) AS subquery

);


-- NOT IN with correlated subqueries result (reduce price of most recent books in each genre)
UPDATE books
SET price = price * 0.9
WHERE id NOT IN (
    SELECT id
    FROM (
             SELECT b.id
             FROM books b
                      JOIN (
                 SELECT genre_id, MAX(release_year) AS max_release_year
                 FROM books
                 GROUP BY genre_id
             ) AS latest_editions ON b.genre_id = latest_editions.genre_id
                 AND b.release_year = latest_editions.max_release_year
         ) AS subquery
);

# EXISTS with correlated subqueries result
UPDATE books
SET price = price * 1.1
WHERE EXISTS (
    SELECT 1
    FROM books_authors
             INNER JOIN authors ON books_authors.author_id = authors.id
    WHERE books_authors.book_id = books.id
      AND authors.name_au = 'Stephen King'
);

# NOT EXISTS with correlated subqueries result
DELETE FROM customers
WHERE NOT EXISTS (
    SELECT 1
    FROM loans
    WHERE loans.customer_id = customers.id
);





-- (for idea brainstorming for queries used Internet)