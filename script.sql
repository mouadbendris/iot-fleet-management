-- ==============================================================================
-- FLEET MANAGEMENT SYSTEM - FAILSAFE SCRIPT (Spring Boot Ready)
-- ==============================================================================

-- ==========================================
-- PART 1: SCHEMA (No DB-side UUID generation)
-- ==========================================

CREATE TABLE users (
    id              UUID PRIMARY KEY,
    email           VARCHAR(255) UNIQUE NOT NULL,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    driving_license VARCHAR(50) UNIQUE NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at      TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vehicles (
    id                   UUID PRIMARY KEY,
    plate_number         VARCHAR(20) UNIQUE NOT NULL,
    model                VARCHAR(100) NOT NULL,
    image_url            VARCHAR(500),
    status               VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',
    battery_capacity_kwh INTEGER NOT NULL,
    current_trip_id      UUID,             
    last_latitude        DOUBLE PRECISION,
    last_longitude       DOUBLE PRECISION,
    last_battery         INTEGER,
    last_telemetry_time  TIMESTAMPTZ,      
    created_at           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trips (
    id              UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    vehicle_id      UUID NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'IN_PROGRESS',
    start_time      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time        TIMESTAMPTZ,
    start_battery   INTEGER,
    end_battery     INTEGER,
    total_cost      DECIMAL(10, 2),
    CONSTRAINT fk_trip_user FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_trip_vehicle FOREIGN KEY(vehicle_id) REFERENCES vehicles(id)
);

ALTER TABLE vehicles ADD CONSTRAINT fk_current_trip FOREIGN KEY (current_trip_id) REFERENCES trips(id) ON DELETE SET NULL;

CREATE TABLE telemetry (
    id              UUID PRIMARY KEY,
    vehicle_id      UUID NOT NULL,
    timestamp       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    latitude        DOUBLE PRECISION NOT NULL,
    longitude       DOUBLE PRECISION NOT NULL,
    speed           DOUBLE PRECISION DEFAULT 0,
    battery_level   INTEGER NOT NULL,
    engine_status   VARCHAR(20),
    doors_locked    BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_telemetry_vehicle FOREIGN KEY(vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE
);

CREATE INDEX idx_telemetry_vehicle_time ON telemetry(vehicle_id, timestamp DESC);

CREATE TABLE alerts (
    id              UUID PRIMARY KEY,
    vehicle_id      UUID NOT NULL,
    type            VARCHAR(50) NOT NULL,
    message         TEXT,
    is_resolved     BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alert_vehicle FOREIGN KEY(vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE
);

-- ==========================================
-- PART 2: STATIC MOCK DATA
-- ==========================================

-- 1. Insert Users with static UUIDs
INSERT INTO users (id, email, first_name, last_name, driving_license, status) 
VALUES 
('11111111-1111-1111-1111-111111111111', 'carlos.dev@email.com', 'Carlos', 'Garcia', 'B-12345678', 'ACTIVE'),
('22222222-2222-2222-2222-222222222222', 'anna.smith@email.com', 'Anna', 'Smith', 'B-87654321', 'ACTIVE');

-- 2. Insert Vehicles with static UUIDs
INSERT INTO vehicles (id, plate_number, model, image_url, status, battery_capacity_kwh, last_latitude, last_longitude, last_battery) 
VALUES 
('aaaa1111-aaaa-1111-aaaa-1111aaaa1111', '1111-ABC', 'Seat Leon e-Hybrid', 'https://example.com/leon.jpg', 'AVAILABLE', 55, 41.5830, 1.6174, 100), 
('bbbb2222-bbbb-2222-bbbb-2222bbbb2222', '2222-XYZ', 'Cupra Born', 'https://example.com/cupra.jpg', 'IN_USE', 58, 41.3851, 2.1734, 78),          
('cccc3333-cccc-3333-cccc-3333cccc3333', '3333-MNO', 'Seat Ibiza', 'https://example.com/ibiza.jpg', 'MAINTENANCE', 40, 41.3880, 2.1700, 12);     

-- 3. Create a Trip
INSERT INTO trips (id, user_id, vehicle_id, status, start_battery)
VALUES 
('99999999-9999-9999-9999-999999999999', '22222222-2222-2222-2222-222222222222', 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222', 'IN_PROGRESS', 80);

-- 4. Update the Vehicle Cache
UPDATE vehicles SET current_trip_id = '99999999-9999-9999-9999-999999999999' WHERE id = 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222';

-- 5. Insert Telemetry
INSERT INTO telemetry (id, vehicle_id, latitude, longitude, speed, battery_level, doors_locked)
VALUES 
('77777777-7777-7777-7777-777777777771', 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222', 41.3840, 2.1730, 45, 80, true),
('77777777-7777-7777-7777-777777777772', 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222', 41.3845, 2.1732, 50, 79, true);

-- 6. Insert Alert
INSERT INTO alerts (id, vehicle_id, type, message, is_resolved)
VALUES 
('88888888-8888-8888-8888-888888888888', 'cccc3333-cccc-3333-cccc-3333cccc3333', 'LOW_BATTERY', 'Battery dropped below 15%', false);