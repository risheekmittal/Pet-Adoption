import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/pet_model.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Pet> _adoptedPets = [];

  @override
  void initState() {
    super.initState();
    _loadAdoptedPets();
  }

  Future<void> _loadAdoptedPets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> adoptedPetsData = prefs.getStringList('adopted_pets') ?? [];
      print("adoptedPetsData $adoptedPetsData");
      // Decode the JSON strings into Pet objects
      setState(() {
        _adoptedPets = adoptedPetsData
            .map((petData) => Pet.fromJson(json.decode(petData)))
            .toList();
      });
    } catch (e) {
      debugPrint('Error loading adopted pets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopted Pets History'),
      ),
      body: _adoptedPets.isEmpty
          ? const Center(
        child: Text(
          'No pets have been adopted yet!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _adoptedPets.length,
        itemBuilder: (context, index) {
          final pet = _adoptedPets[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(pet.imageUrl),
              ),
              title: Text(
                pet.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Adopted on: ${pet.adoptionDate ?? "Unknown date"}',
              ),
            ),
          );
        },
      ),
    );
  }
}
