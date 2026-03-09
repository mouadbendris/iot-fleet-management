package com.neofleet.api.repository;

import com.neofleet.api.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
    // ¡Vacío! Literalmente no hay que escribir NADA más.
}