USE librarydb;


-- Task 1 (in, out, inout parameters):

CREATE PROCEDURE get_book_information (
    IN bookID INT,
    OUT bookTitle VARCHAR(255),
    INOUT bookISBN VARCHAR(17)
)
BEGIN
    DECLARE bookEdition VARCHAR(255);
    DECLARE bookReleaseYear YEAR;
    DECLARE bookPrice DECIMAL(10, 2);

    -- Retrieve book information based on bookID
SELECT title, edition, release_year, price INTO bookTitle, bookEdition, bookReleaseYear, bookPrice
FROM books
WHERE id = bookID;

-- Update the book ISBN 
IF bookISBN IS NOT NULL AND bookISBN != (SELECT isbn FROM books WHERE id = bookID) THEN
UPDATE books SET isbn = bookISBN WHERE id = bookID;
END IF;

    -- Setting "out" parameter for book title
    SET bookTitle = CONCAT('Title: ', bookTitle);

    -- Showing the information
SELECT CONCAT('Edition: ', bookEdition) AS BookEdition,
       CONCAT('Release Year: ', bookReleaseYear) AS ReleaseYear,
       CONCAT('Price: $', bookPrice) AS Price;
END;