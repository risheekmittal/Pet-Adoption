import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/pet_event.dart';
import 'package:pet_adoption/bloc/pet_state.dart';
import '../models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetBloc extends Cubit<List<Pet>> {
  PetBloc() : super([]);

  void adoptPet(String petId) {
    final updatedPets = state.map((pet) {
      if (pet.id == petId) {
        pet.isAdopted = true;
        pet.adoptionDate = DateTime.now().toString(); // Store adoption date
      }
      return pet;
    }).toList();
    emit(updatedPets);  // Emit the updated pet list
    saveAdoptionState(updatedPets);
  }

  // Save the adoption state to SharedPreferences
  Future<void> saveAdoptionState(List<Pet> pets) async {
    final prefs = await SharedPreferences.getInstance();
    final adoptedPetsJson = pets
        .where((pet) => pet.isAdopted)
        .map((pet) => json.encode(pet.toJson())) // Convert pet to JSON string
        .toList();
    await prefs.setStringList('adoptedPets', adoptedPetsJson);
  }

  // Load the adoption state from SharedPreferences
  Future<void> loadAdoptionState() async {
    final prefs = await SharedPreferences.getInstance();
    final adoptedPetsJson = prefs.getStringList('adoptedPets') ?? [];

    // Deserialize the pet JSONs and update the pet list
    final List<Pet> updatedPets = state.map((pet) {
      final adoptedPetJson = adoptedPetsJson.firstWhere(
            (json) => jsonDecode(json)['id'] == pet.id,
        orElse: () => '{}',  // Return empty if not found
      );
      if (adoptedPetJson.isNotEmpty) {
        final adoptedPet = Pet.fromJson(jsonDecode(adoptedPetJson));
        pet.isAdopted = adoptedPet.isAdopted;
        pet.adoptionDate = adoptedPet.adoptionDate;
      }
      return pet;
    }).toList();

    emit(updatedPets);  // Emit the updated pet list
  }
}
