## Report on Normalization of Database Schema

Normalization is a critical process in database design that ensures data is organized efficiently and minimizes redundancy. In this report, I will detail the steps undertaken to normalize the schema for a media streaming service, bringing it into compliance with the **First Normal Form (1NF)** and **Second Normal Form (2NF)**. 

The process involved analyzing the schema for multivalued attributes, composite keys, and partial dependencies. Each issue was addressed to ensure the database adheres to the principles of normalization.



### First Normal Form (1NF)
**Objective:** Eliminate multivalued attributes or repeating groups to ensure atomicity.

#### Issues Identified:
1. **Media Table**: 
   - Columns such as `Actors` and `Producers` stored multiple values in a single cell, violating 1NF.

#### Steps Taken:
1. **Decomposition of the Media Table**:
   - The `Actors` and `Producers` columns were moved to separate tables to ensure each cell contains atomic values.

**Updated Schema:**
- **Media Table:**
  ```sql
  CREATE TABLE Media (
      MediaID INT PRIMARY KEY NOT NULL,
      Title VARCHAR(255) NOT NULL,
      Type VARCHAR(50) NOT NULL CHECK (Type IN ('Series', 'Movie')),
      Genre VARCHAR(100) NOT NULL,
      ProductionYear YEAR NOT NULL,
      Director VARCHAR(255) NOT NULL
  );
  ```

- **MediaActor Table:**
  ```sql
  CREATE TABLE MediaActor (
      MediaID INT NOT NULL,
      Actor VARCHAR(255) NOT NULL,
      PRIMARY KEY (MediaID, Actor),
      FOREIGN KEY (MediaID) REFERENCES Media(MediaID)
  );
  ```

- **MediaProducer Table:**
  ```sql
  CREATE TABLE MediaProducer (
      MediaID INT NOT NULL,
      Producer VARCHAR(255) NOT NULL,
      PRIMARY KEY (MediaID, Producer),
      FOREIGN KEY (MediaID) REFERENCES Media(MediaID)
  );
  ```

#### Outcome:
- The database now adheres to 1NF, ensuring all columns contain atomic values without multivalued attributes.



### Second Normal Form (2NF)
**Objective:** Ensure all non-prime attributes are fully functionally dependent on the entire primary key.

#### Issues Identified:
1. **Payment Table:**
   - `SubscriptionID` was not fully dependent on the primary key `PaymentID`. It is related to the `UserID`.

2. **Media Table:**
   - `AverageRatingScore` was a derived value and did not depend directly on the primary key.

#### Steps Taken:
1. **Decomposition of the Payment Table:**
   - Created a new `Subscription` table to separate subscription details from payment information.

2. **Removal of Derived Attributes:**
   - `AverageRatingScore` was removed from the `Media` table as it could be dynamically calculated from the `Rating` table.

**Updated Schema:**
- **Payment Table:**
  ```sql
  CREATE TABLE Payment (
      PaymentID INT PRIMARY KEY NOT NULL,
      UserID INT NOT NULL,
      AmountPaid DECIMAL(10,2) NOT NULL CHECK (AmountPaid > 0),
      FOREIGN KEY (UserID) REFERENCES User(UserID)
  );
  ```

- **Subscription Table:**
  ```sql
  CREATE TABLE Subscription (
      SubscriptionID INT PRIMARY KEY NOT NULL,
      UserID INT NOT NULL,
      Tier VARCHAR(50) NOT NULL CHECK (Tier IN ('Free', 'Premium')),
      StartDate DATE NOT NULL,
      EndDate DATE NOT NULL CHECK (StartDate < EndDate),
      FOREIGN KEY (UserID) REFERENCES User(UserID)
  );
  ```

- **Media Table:**
  ```sql
  CREATE TABLE Media (
      MediaID INT PRIMARY KEY NOT NULL,
      Title VARCHAR(255) NOT NULL,
      Type VARCHAR(50) NOT NULL CHECK (Type IN ('Series', 'Movie')),
      Genre VARCHAR(100) NOT NULL,
      ProductionYear YEAR NOT NULL,
      Director VARCHAR(255) NOT NULL
  );
  ```

#### Outcome:
- The schema now adheres to 2NF. All non-prime attributes are fully functionally dependent on their respective primary keys.



The schema was successfully normalized to comply with 1NF and 2NF. Multivalued attributes were removed, and all partial dependencies were eliminated. This ensures that the database design minimizes redundancy and supports efficient data storage and retrieval.

The normalization process is essential for maintaining data integrity and avoiding anomalies in future database operations. Further normalization to the Third Normal Form (3NF) can be pursued if necessary to address transitive dependencies.

