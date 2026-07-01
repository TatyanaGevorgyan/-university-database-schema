# University Database & Query Analytics

A comprehensive relational database design and analytics project simulating a University Management System. Built using structured relational modeling, strong integrity constraints, and advanced SQL queries to manage academic data efficiently.


## Database Schema Design

The system models a real-world university environment using 6 interconnected tables:

- university— Stores university profiles with rating and metadata  
- lecturer— Faculty member details linked to universities  
- students — Student records including personal data and stipend information  
- subject — Course catalog with semester and duration details  
- subjectlectur — Junction table handling many-to-many relationships between lecturers and subjects  
- exammarks — Tracks student performance and exam results per subject  


## SQL Features & Techniques Used

### Data Integrity & Constraints,Data Analytics & Aggregation
PRIMARY KEY / FOREIGN KEY relationships ,NOT NULL constraints for mandatory fields , CHECK constraints for validation rules ,GROUP BY for structured reporting ,HAVING for filtered aggregation results  
Aggregate functions,AVG() — average performance metrics ,COUNT() — entity statistics, MIN() / MAX() — performance boundaries  

###  String & Date Manipulation
- LIKE pattern matching  
- UPPER() / LOWER() formatting  
- CONCAT() string building  
- DATEDIFF() / DATEADD() for temporal analysis  

###  Relational Operations
- Efficient INNER JOIN queries across all core tables  
- Optimized relational structure for analytical reporting  


## Project Goal

To simulate a scalable university database system capable of:
- Managing academic records efficiently  
- Supporting structured analytical queries  
- Demonstrating real-world SQL database design principles  

