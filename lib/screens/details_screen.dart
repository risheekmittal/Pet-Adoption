import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/adopt_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pet_model.dart';

class DetailsScreen extends StatefulWidget {
  final Pet pet;
  const DetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Pet pet;
  bool _isAdopted = false;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
    _checkIfAdopted();
  }

  void _checkIfAdopted() async {
    final prefs = await SharedPreferences.getInstance();
    final adoptedPets = prefs.getStringList('adopted_pets') ?? [];

    setState(() {
      // Check if the pet is in the adopted pets list
      _isAdopted = adoptedPets.any((adoptedPet) {
        final adoptedPetData = json.decode(adoptedPet);
        return adoptedPetData['id'] == pet.id;
      });
    });
  }


  void _adoptPet() {
    print("adopted");
    setState(() {
      _isAdopted = true;
      pet.isAdopted = true;
      pet.adoptionDate = DateTime.now().toIso8601String();
      // Save pet adoption status in SharedPreferences
      _savePetAdoptionStatus(pet);
    });}

  void _savePetAdoptionStatus(Pet pet) async {
    final prefs = await SharedPreferences.getInstance();
    final adoptedPets = prefs.getStringList('adopted_pets') ?? [];

    // await prefs.setStringList('adoptedPets', adoptedPets);
    adoptedPets.add(json.encode(pet.toJson()));
    prefs.setStringList('adopted_pets', adoptedPets);

    // Navigator.pop(context, true);
    final result = prefs.getStringList('adopted_pets');
    print("result $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: Hero(
              tag: widget.pet.id,
              child: Image.network(
                widget.pet.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                margin: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.pet.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Age: ${widget.pet.age}', style: TextStyle(fontSize: 18)),
                      Text('Breed: ${widget.pet.breed}', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      Text('Price: \$${widget.pet.price}', style: TextStyle(fontSize: 20, color: Colors.green)),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AdoptButton(
                pet: pet,
                onPressed: _isAdopted ? null : _adoptPet, // Disable button if already adopted
              ),
            ),
          ),
        ],
      ),

    );
  }
}
