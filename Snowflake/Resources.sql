USE DATABASE airbnb;

CREATE OR REPLACE FILE FORMAT staging.csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;


CREATE OR REPLACE STAGE staging.snowstage
FILE_FORMAT = staging.csv_format
URL='s3://ayan-dbt-airbnb/';
    

COPY INTO staging.bookings
FROM @snowstage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = 'your_access_key', aws_secret_key = 'your_secret_key');

COPY INTO staging.hosts
FROM @snowstage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = 'your_access_key', aws_secret_key = 'your_secret_key');

COPY INTO staging.listings
FROM @snowstage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = 'your_access_key', aws_secret_key = 'your_secret_key');