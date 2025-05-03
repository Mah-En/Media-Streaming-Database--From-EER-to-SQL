### Transformation of EER to Relations

The transformation of an Enhanced Entity-Relationship (EER) diagram into relational schemas involves breaking down entities and relationships into logical tables while preserving constraints and dependencies. Below is an example from the media streaming service database.

---

### Example Transformation: User and Payment

#### Conceptual Design (EER Diagram)

In the EER diagram:
- The **User** entity includes attributes such as `UserID`, `Username`, `Password`, `Email`, `SubscriptionTier`, `SubscriptionStartDate`, and `SubscriptionEndDate`.
- The **Payment** entity contains attributes like `PaymentID`, `UserID`, `AmountPaid`, and `SubscriptionID`.
- The relationship between **User** and **Payment** is **one-to-many**, where each user can make multiple payments.

---

#### Relational Schema Transformation

##### Step 1: Map Entities
Each entity in the EER diagram is transformed into a table with the entity's attributes as columns.

1. **User Table**:
   - Primary Key: `UserID`
   - Attributes:
     - `Username` (Unique, Not Null)
     - `Password` (Not Null)
     - `Email` (Unique, Not Null)
     - `SubscriptionTier` (Values: Free, Premium)
     - `SubscriptionStartDate` (Not Null)
     - `SubscriptionEndDate` (Not Null)

2. **Payment Table**:
   - Primary Key: `PaymentID`
   - Attributes:
     - `UserID` (Foreign Key referencing `User`)
     - `AmountPaid` (Check: `> 0`)
     - `SubscriptionID` (Optional, allows linking to subscription details)

##### Step 2: Map Relationships
The **one-to-many** relationship between **User** and **Payment** is implemented using a **Foreign Key** in the `Payment` table:
- The `UserID` attribute in the `Payment` table is defined as a **Foreign Key** referencing the `UserID` column in the `User` table.
- This ensures referential integrity by requiring every `UserID` in `Payment` to match an existing `UserID` in `User`.

---

#### Resulting Relational Schemas

1. **User Table**:
   ```sql
   CREATE TABLE User (
       UserID INT PRIMARY KEY NOT NULL,
       Username VARCHAR(255) UNIQUE NOT NULL,
       Password VARCHAR(255) NOT NULL,
       Email VARCHAR(255) UNIQUE NOT NULL,
       SubscriptionTier VARCHAR(50) CHECK (SubscriptionTier IN ('Free', 'Premium')) NOT NULL,
       SubscriptionStartDate DATE NOT NULL,
       SubscriptionEndDate DATE NOT NULL CHECK (SubscriptionEndDate > SubscriptionStartDate)
   );
   ```

2. **Payment Table**:
   ```sql
   CREATE TABLE Payment (
       PaymentID INT PRIMARY KEY NOT NULL,
       UserID INT NOT NULL,
       AmountPaid DECIMAL(10,2) NOT NULL CHECK (AmountPaid > 0),
       SubscriptionID INT,
       FOREIGN KEY (UserID) REFERENCES User(UserID)
   );
   ```

---

### Other Transformations

Similarly, other entities such as **Media**, **Company**, **Comment**, and **Rating** are transformed into relational tables. Their relationships, such as **many-to-one** (e.g., Media and Company) or **many-to-many** (e.g., User and WatchLater), are modeled using foreign keys or bridge tables, maintaining integrity and enforcing constraints.

---

