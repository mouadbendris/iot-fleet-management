package com.neofleet.api.controller;

import com.neofleet.api.model.Vehicle;
import com.neofleet.api.repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController // Le dice a Java: "Escucha peticiones de internet"
@RequestMapping("/api/vehicles") // La URL por la que van a entrar
public class VehicleController {

    // Traemos nuestra capa de persistencia (El buscador mágico)
    @Autowired
    private VehicleRepository vehicleRepository;

    // Cuando alguien entre por internet con un GET, ejecutamos esto:
    @GetMapping
    public List<Vehicle> getAllVehicles() {
        // Usamos la magia de JPA para devolver todos los coches de la base de datos
        return vehicleRepository.findAll();
    }
}