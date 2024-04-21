CREATE TABLE publishers (
                            id INTEGER AUTO_INCREMENT PRIMARY KEY,
                            name_pub VARCHAR(255) NOT NULL,
                            address VARCHAR(255),
                            phone VARCHAR(25) NOT NULL,
                            website VARCHAR(255),
                            INDEX idx_name_pub (name_pub),
                            INDEX idx_phone (phone)
);

CREATE TABLE genres (
                        id INTEGER AUTO_INCREMENT PRIMARY KEY,
                        genre_name VARCHAR(255) NOT NULL,
                        description TEXT,
                        INDEX idx_genre_name (genre_name)
);

CREATE TABLE authors (
                         id INTEGER AUTO_INCREMENT PRIMARY KEY,
                         name_au VARCHAR(255) NOT NULL,
                         datebirth DATE NOT NULL,
                         nationality VARCHAR(255) NOT NULL,
                         biography TEXT NOT NULL,
                         INDEX idx_name_au (name_au),
                         INDEX idx_nationality (nationality)
);

CREATE TABLE books (
                       id INTEGER AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       isbn VARCHAR(17),
                       edition VARCHAR(255) NOT NULL,
                       release_year YEAR NOT NULL,
                       price DECIMAL(10, 2) NOT NULL,
                       publisher_id INTEGER,
                       genre_id INTEGER,
                       FOREIGN KEY (publisher_id) REFERENCES publishers(id),
                       FOREIGN KEY (genre_id) REFERENCES genres(id),
                       INDEX idx_title (title),
                       INDEX idx_isbn (isbn),
                       INDEX idx_release_year (release_year)
);

CREATE TABLE customers (
                           id INTEGER AUTO_INCREMENT PRIMARY KEY,
                           name_cus VARCHAR(255) NOT NULL,
                           address VARCHAR(255),
                           phone VARCHAR(25) NOT NULL,
                           email VARCHAR(255) NOT NULL,
                           pas VARCHAR(25) NOT NULL,
                           INDEX idx_name_cus (name_cus),
                           INDEX idx_email (email),
                           INDEX idx_phone (phone)
);

CREATE TABLE loans (
                       id INTEGER AUTO_INCREMENT PRIMARY KEY,
                       customer_id INTEGER,
                       book_id INTEGER NOT NULL,
                       loan_date DATE NOT NULL,
                       due_date DATE NOT NULL,
                       return_date DATE,
                       FOREIGN KEY (customer_id) REFERENCES customers(id),
                       FOREIGN KEY (book_id) REFERENCES books(id),
                       INDEX idx_loan_date (loan_date),
                       INDEX idx_due_date (due_date),
                       INDEX idx_return_date (return_date)
);

CREATE TABLE books_genres (
                              book_id INTEGER,
                              genre_id INTEGER,
                              FOREIGN KEY (book_id) REFERENCES books(id),
                              FOREIGN KEY (genre_id) REFERENCES genres(id),
                              PRIMARY KEY (book_id, genre_id),
                              INDEX idx_book_id (book_id),
                              INDEX idx_genre_id (genre_id)
);

CREATE TABLE books_authors (
                               book_id INTEGER,
                               author_id INTEGER,
                               FOREIGN KEY (book_id) REFERENCES books(id),
                               FOREIGN KEY (author_id) REFERENCES authors(id),
                               PRIMARY KEY (book_id, author_id),
                               INDEX idx_book_id (book_id),
                               INDEX idx_author_id (author_id)
);



INSERT INTO authors (name_au, datebirth, nationality, biography)
VALUES
    ('F. Scott Fitzgerald', '1896-09-24', 'American', 'F. Scott Fitzgerald was an American novelist and short-story writer, famous for his depictions of the Jazz Age (the 1920s). His most famous novel, "The Great Gatsby", is considered a literary classic and a portrayal of the American Dream.'),
    ('Harper Lee', '1926-04-28', 'American', 'Harper Lee was an American novelist, best known for her Pulitzer Prize-winning novel "To Kill a Mockingbird" (1960). The novel deals with the issues of racial injustice and moral growth in the American South.'),
    ('J.D. Salinger', '1919-01-01', 'American', 'J.D. Salinger was an American writer known for his novel "The Catcher in the Rye" (1951), a classic of 20th-century literature. He was reclusive and avoided publicity, shunning interviews and public appearances.'),
    ('Thomas H. Cormen', '1956-05-19', 'American', 'Thomas H. Cormen is a computer scientist and co-author of the book "Introduction to Algorithms", widely used in computer science courses. He is also a professor at Dartmouth College.'),
    ('Abraham Silberschatz', '1952-10-23', 'Israeli-American', 'Abraham Silberschatz is an Israeli-American computer scientist known for his work on database systems. He is the co-author of "Database System Concepts", a widely used textbook in database courses.'),
    ('Donald E. Knuth', '1938-01-10', 'American', 'Donald E. Knuth is an American computer scientist known for his work in algorithms and mathematics. He is the author of the multi-volume work "The Art of Computer Programming", a seminal work in the field of computer science.'),
    ('William Strunk Jr.', '1869-07-01', 'American', 'William Strunk Jr. was an American professor of English at Cornell University. He is best known as the author of "The Elements of Style", a guide to English usage and composition.'),
    ('Stephen King', '1947-09-21', 'American', 'Stephen King is an American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels. His books have sold more than 350 million copies, and many have been adapted into films, television series, miniseries, and comic books.'),
    ('Anne Lamott', '1954-04-10', 'American', 'Anne Lamott is an American novelist and non-fiction writer. Her works include "Bird by Bird: Some Instructions on Writing and Life", a book on the art of writing and life.');

INSERT INTO customers (name_cus, address, phone, email, pas)
VALUES
    ('John Doe', '123 Main St, Anytown, USA', '+1234567890', 'john@example.com', 'password123'),
    ('Jane Doe', '456 Elm St, Anycity, USA', '+1987654321', 'jane@example.com', 'password456'),
    ('Alice Johnson', '789 Oak St, Anyville, USA', '+1122334455', 'alice@example.com', 'password789'),
    ('Bob Brown', '101 Pine St, Anytown, USA', '+1555666777', 'bob@example.com', 'passwordabc'),
    ('Emily Davis', '222 Cedar St, Anycity, USA', '+1444333222', 'emily@example.com', 'passworddef'),
    ('Michael Wilson', '333 Maple St, Anyville, USA', '+1999888777', 'michael@example.com', 'passwordghi'),
    ('Sarah Taylor', '444 Walnut St, Anytown, USA', '+1777666555', 'sarah@example.com', 'passwordjkl'),
    ('David Martinez', '555 Birch St, Anycity, USA', '+1888999000', 'david@example.com', 'passwordmno'),
    ('Jessica Anderson', '666 Cherry St, Anyville, USA', '+1666777888', 'jessica@example.com', 'passwordpqr');

SELECT * FROM customers;

INSERT INTO books (title, isbn, edition, release_year, price)
VALUES
    ('The Great Gatsby', '9780743273565', '1st Edition', 1925, 10.99),
    ('To Kill a Mockingbird', '9780061120084', '2nd Edition', 1960, 12.50),
    ('The Catcher in the Rye', '9780316769488', '1st Edition', 1951, 9.99),
    ('Introduction to Algorithms', '9780262033848', '4th Edition', 2009, 80.00),
    ('Database System Concepts', '9780073523323', '7th Edition', 2019, 120.00),
    ('The Art of Computer Programming', '9780201896831', '1st Edition', 1968, 99.99),
    ('The Elements of Style', '9780205309023', '4th Edition', 1999, 8.99),
    ('On Writing: A Memoir of the Craft', '9781439156810', '1st Edition', 2000, 14.95),
    ('Bird by Bird: Some Instructions on Writing and Life', '9780385480017', '1st Edition', 1995, 15.00);

SELECT * FROM books;

INSERT INTO loans (customer_id, book_id, loan_date, due_date, return_date)
VALUES
    (1, 1, '2023-01-01', '2023-01-15', '2023-01-10'),
    (2, 2, '2023-02-05', '2023-02-20', NULL),
    (3, 3, '2023-03-10', '2023-03-25', NULL),
    (4, 4, '2023-04-15', '2023-04-30', NULL),
    (5, 5, '2023-05-20', '2023-06-04', NULL),
    (6, 6, '2023-06-25', '2023-07-10', '2023-07-05'),
    (7, 7, '2023-07-30', '2023-08-14', NULL),
    (8, 8, '2023-08-05', '2023-08-20', NULL),
    (9, 9, '2023-09-10', '2023-09-25', NULL);
SELECT * FROM loans;

INSERT INTO genres (genre_name, description)
VALUES
    ('Fiction', 'Fiction genre typically involves imaginative or invented stories, often set in the real world or a fictional universe.'),
    ('Computer Science', 'Computer Science genre focuses on the theoretical foundations of computation and practical techniques for their implementation and application in computer systems.'),
    ('Writing', 'Writing genre encompasses various forms of written expression, including novels, essays, poetry, and non-fiction works, emphasizing creativity, communication, and storytelling.'),
    ('Mystery', 'Mystery genre involves the investigation of a crime, often by a detective or amateur sleuth, with the goal of uncovering hidden clues and solving the puzzle.'),
    ('Science Fiction', 'Science Fiction genre explores speculative or futuristic concepts, often incorporating advanced technology, space exploration, and alternative realities.'),
    ('Fantasy', 'Fantasy genre features magical or supernatural elements, often set in imaginary worlds with mythical creatures and epic quests.'),
    ('Romance', 'Romance genre focuses on romantic relationships, often featuring themes of love, passion, and emotional connections between characters.'),
    ('Thriller', 'Thriller genre delivers intense excitement, suspense, and danger, often involving high-stakes situations, fast-paced action, and unexpected plot twists.'),
    ('Horror', 'Horror genre aims to evoke fear, terror, or disgust in readers, often through supernatural or psychological elements, and exploring themes of the macabre and the unknown.'),
    ('Poetry', 'Poetry genre emphasizes rhythm, sound, and imagery, conveying emotions, ideas, and experiences through the use of carefully crafted language and verse forms.'),
    ('Biography', 'Biography genre tells the life story of a real person, often focusing on significant events, achievements, and personal experiences, providing insights into their character and contributions.'),
    ('Comedy', 'Comedy genre aims to entertain and amuse, often through humor, satire, and wit, exploring funny situations, absurdities, and human follies with a lighthearted tone and comedic timing.');

SELECT * FROM genres;

INSERT INTO publishers (name_pub, address, phone, website)
VALUES
    ('Penguin Random House', '1745 Broadway, New York, NY 10019, USA', '+1 212-782-9000', 'https://www.penguinrandomhouse.com/'),
    ('HarperCollins Publishers', '195 Broadway, New York, NY 10007, USA', '+1 212-207-7000', 'https://www.harpercollins.com/'),
    ('Pearson Education', '80 Strand, London, WC2R 0RL, United Kingdom', '+44 20 7010 2000', 'https://www.pearson.com/'),
    ('McGraw Hill', '1221 Avenue of the Americas, New York, NY 10020, USA', '+1 212-512-2000', 'https://www.mheducation.com/'),
    ('OReilly Media', '1005 Gravenstein Hwy N, Sebastopol, CA 95472, USA', '+1 707-827-7000', 'https://www.oreilly.com/'),
    ('Cambridge University Press', '32 Avenue of the Americas, New York, NY 10013, USA', '+1 212-924-3900', 'https://www.cambridge.org/'),
    ('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA', '+1 212-698-7000', 'https://www.simonandschuster.com/'),
    ('Hachette Livre', '58 Rue Jean Bleuzen, 92170 Vanves, France', '+33 1 43 92 30 00', 'https://www.hachette.fr/'),
    ('Macmillan Publishers', '120 Broadway, New York, NY 10271, USA', '+1 646-307-5151', 'https://us.macmillan.com/'),
    ('Scholastic Corporation', '557 Broadway, New York, NY 10012, USA', '+1 212-343-6100', 'https://www.scholastic.com/');

SELECT * FROM publishers;

SELECT * FROM books_genres;

SELECT * FROM books_authors;

SHOW INDEX FROM publishers;