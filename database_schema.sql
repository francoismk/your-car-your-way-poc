CREATE TABLE Agency (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE Customer (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE,
    address TEXT,
    preferences TEXT
);

CREATE TABLE Vehicle (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    agency_id UUID NOT NULL,
    FOREIGN KEY (agency_id) REFERENCES Agency(id) ON DELETE CASCADE
);

CREATE TABLE Payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP NOT NULL,
    method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE Reservation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    customer_id UUID NOT NULL,
    vehicle_id UUID NOT NULL,
    agency_id UUID NOT NULL,
    payment_id UUID NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(id) ON DELETE CASCADE,
    FOREIGN KEY (agency_id) REFERENCES Agency(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES Payment(id) ON DELETE CASCADE
);

CREATE TABLE Notification (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    date TIMESTAMP NOT NULL,
    customer_id UUID NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE
);

CREATE TABLE Agent (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_online BOOLEAN DEFAULT FALSE,
    is_available BOOLEAN DEFAULT TRUE,
    agency_id UUID NOT NULL,
    FOREIGN KEY (agency_id) REFERENCES Agency(id) ON DELETE CASCADE
);

CREATE TABLE CustomerSupport (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    date TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    customer_id UUID NOT NULL,
    agent_id UUID,
    FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES Agent(id) ON DELETE SET NULL
);
