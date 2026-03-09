package com.neofleet.api.repository;

import com.neofleet.api.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, UUID> {
    // ¡Vacío! Literalmente no hay que escribir NADA más.
}