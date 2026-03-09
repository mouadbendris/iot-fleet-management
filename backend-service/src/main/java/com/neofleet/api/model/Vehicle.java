package com.neofleet.api.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "vehicles")
public class Vehicle {

    @Id
    private UUID id; // Tu script usa UUID, no Long

    @Column(name = "plate_number")
    private String plateNumber;

    private String model;

    @Column(name = "image_url")
    private String imageUrl;

    private String status;

    @Column(name = "battery_capacity_kwh")
    private Integer batteryCapacityKwh;

    @Column(name = "last_battery")
    private Integer lastBattery;

    // Constructor vacío obligatorio
    public Vehicle() {}

    // --- GETTERS Y SETTERS (Importante: Genéralos de nuevo si puedes o usa estos) ---
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getBatteryCapacityKwh() { return batteryCapacityKwh; }
    public void setBatteryCapacityKwh(Integer batteryCapacityKwh) { this.batteryCapacityKwh = batteryCapacityKwh; }

    public Integer getLastBattery() { return lastBattery; }
    public void setLastBattery(Integer lastBattery) { this.lastBattery = lastBattery; }
}