-- variables to store the output
SET @titleOutput = 'The Little Prince';
SET @isbnInputOutput = '9780262033848';

CALL get_book_information(4, @titleOutput, @isbnInputOutput);


SELECT @isbnInputOutput as bookISBN;


