import 'package:flutter/material.dart';
import 'package:pet_adoption/models/pet_model.dart';
import '../screens/details_screen.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(pet: pet),
          ),
        );
      },
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          child: ListTile(
            leading: Hero(
              tag: pet.id,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(30),
                child: Image.network(pet.imageUrl,
                  width: 100, // Fixed width for image
                  height: 200, // Fixed height for image
                  fit: BoxFit.cover, // Crop the image to fit the given size
                ),
              ),
            ),
            title: Text(
              pet.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              pet.isAdopted ? 'Already Adopted' : 'Available for \$${pet.price}',
              style: TextStyle(
                color: pet.isAdopted ? Colors.grey : Colors.green,
              ),
            ),
            trailing: Icon(
              pet.isAdopted ? Icons.check_circle : Icons.arrow_forward,
              color: pet.isAdopted ? Colors.grey : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
