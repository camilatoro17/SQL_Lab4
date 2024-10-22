/*
    Lab 5 - ERD to SQL conversion script
    
    Name: Camila Toro Suarez
 */
 
-- Set your search path to include your username and public, 
-- but *not* in this script.

-- Windows psql needs the following line uncommented
-- \encoding utf-8

-- Add other environment changes here (pager, etc.)

-- Add the SQL for each step that needs SQL after the appropriate comment 
-- below. You may not need to do every single step, depending on your
-- model.

/*
   Step 1: Regular entities
 */

-- client table
CREATE TABLE client (
   client_id SERIAL PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100),
   phone VARCHAR(20)
);

-- service provider table
CREATE TABLE service_provider (
   provider_id SERIAL PRIMARY KEY,
   name VARCHAR(100),
   contact_info VARCHAR(150),
   average_rating INTEGER,
   email VARCHAR(100),
   phone VARCHAR(20)
);

CREATE TABLE service (
   service_id SERIAL PRIMARY KEY,
   name VARCHAR(100),
   locations TEXT[]
);

/*
   Step 2: Weak entities
 */

/*
   Step 3: 1:1 Relationships
 */

/*
   Step 4: 1:N Relationships
 */

-- contract - 1:N btwn client and service_provider
CREATE TABLE contract (
    contract_id SERIAL PRIMARY KEY,
    client_id INTEGER,
    provider_id INTEGER,
    total_charge NUMERIC,
    prepaid_amount NUMERIC,
    balance_due NUMERIC GENERATED ALWAYS AS (total_charge - prepaid_amount) STORED,
    creation_time TIMESTAMP,
    description TEXT,
    start_date DATE,
    end_date DATE,
    confirmation_code VARCHAR(20),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (provider_id) REFERENCES service_provider(provider_id)
);

-- employee - 1:N with service_provider
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    provider_id INTEGER,
    name VARCHAR(100),
    FOREIGN KEY (provider_id) REFERENCES service_provider(provider_id)
);

/*
   Step 5: N:M Relationships
 */

-- service provider can offer multiple services and services can be offered by multiple providers
CREATE TABLE service_provider_service (
   provider_id INTEGER REFERENCES service_provider(provider_id),
   service_id INTEGER REFERENCES service(service_id),
   PRIMARY KEY (provider_id, service_id)
);


/*
   Step 6: Multi-valued attributes
 */

/*
   Step 7: N-ary Relationships
 */

-- review has relationships to client and provider
CREATE TABLE review (
    review_id SERIAL,
    client_id INTEGER,
    provider_id INTEGER,
    rating INTEGER,
    comments TEXT,
    PRIMARY KEY (review_id, client_id),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (provider_id) REFERENCES service_provider(provider_id)
);
