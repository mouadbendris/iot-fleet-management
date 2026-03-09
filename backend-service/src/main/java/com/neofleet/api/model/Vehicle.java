package com.neofleet.api.model;
import jakarta.persistence.*;

@Entity // Le dice a Java: "Oye, esto no es una clase normal, es una tabla de base de datos"
@Table(name = "vehicles") // Le decimos exactamente cómo se llama la tabla en PostgreSQL
public class Vehicle {

    @Id // Le dice que este es el identificador principal
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Le dice que el ID se genera solo (como el SERIAL en SQL)
    private Long id;

    private String vin;
    private String brand;
    private String model;

    @Column(name = "manufacture_year") // Como en SQL tiene guión bajo, le ayudamos a traducirlo
    private Integer manufactureYear;

    @Column(name = "license_plate")
    private String licensePlate;

    // 🛠️ Constructor vacío (Es obligatorio para que Spring Boot no explote)
    public Vehicle() {
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getManufactureYear() {
        return manufactureYear;
    }

    public void setManufactureYear(Integer manufactureYear) {
        this.manufactureYear = manufactureYear;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
}