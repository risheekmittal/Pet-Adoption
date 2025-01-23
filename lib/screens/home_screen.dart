import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add Bloc import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_adoption/models/pet_model.dart';
import '../widgets/pet_card.dart';
import 'package:http/http.dart' as http;
import 'history_screen.dart';
import '../bloc/pet_bloc.dart'; // Import PetBloc

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  // Load pets from API and SharedPreferences
  void _loadPets() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    // Fetch adopted pets from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> adoptedPetsData = prefs.getStringList('adopted_pets') ?? [];
    print(adoptedPetsData);

    // Example pets - Replace with real API call or data
    const apiUrl = 'https://dog.ceo/api/breeds/image/random';

    List<Pet> pets = [];
    List<String> petNames = ['Bella', 'Max', 'Charlie', 'Luna', 'Lucy', 'Cooper', 'Milo', 'Daisy', 'Buddy', 'Sadie'];

    for (int i = 0; i < 20; i++) {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        pets.add(Pet(
          id: 'pet_$i',
          name: petNames[i % petNames.length],
          age: 2 + (i % 5),
          price: 50 + (i * 10).toDouble(),
          imageUrl: data['message'],
          breed: '',
        ));
      } else {
        print('Failed to load pet image');
      }
    }

    // Load adopted status and update pet adoption state
    List<Pet> updatedPets = pets.map((pet) {
      // Decode each string in adoptedPetsData into a Pet object
      List<Pet> adoptedPetsList = adoptedPetsData
          .map((adoptedPetJson) => Pet.fromJson(json.decode(adoptedPetJson)))
          .toList();

      // Check if the pet's id exists in the list of adopted pets
      bool isAdopted = adoptedPetsList.any((adoptedPet) {
        return adoptedPet.id == pet.id;
      });

      // Update the pet's adoption status
      pet.isAdopted = isAdopted;

      return pet;
    }).toList();

    // Dispatch the new list of pets to the PetBloc
    context.read<PetBloc>().emit(updatedPets);
    setState(() {
      _isLoading = false; // End loading
    });
  }

  // Filter pets by search query
  void _filterPets() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adoption'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to the HistoryScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loader when loading
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a pet',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _filterPets(),
            ),
          ),
          Expanded(
            child: BlocBuilder<PetBloc, List<Pet>>(
              builder: (context, pets) {
                final filteredPets = pets
                    .where((pet) => pet.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                    .toList();
                print(pets);

                return ListView.builder(
                  itemCount: filteredPets.length,
                  itemBuilder: (context, index) {
                    final pet = filteredPets[index];
                    return PetCard(pet: pet);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Filter dialog to show different sorting options
  void _showFilterDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Pets'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Price: Low to High'),
                onTap: () {
                  context.read<PetBloc>().state.sort((a, b) => a.price.compareTo(b.price));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Price: High to Low'),
                onTap: () {
                  context.read<PetBloc>().state.sort((a, b) => b.price.compareTo(a.price));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Adopted Pets Only'),
                onTap: () {
                  context.read<PetBloc>().emit(
                    context.read<PetBloc>().state.where((pet) => pet.isAdopted).toList(),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
