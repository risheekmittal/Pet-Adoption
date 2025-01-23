import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pet_model.dart';
import '../bloc/pet_bloc.dart';
import 'package:confetti/confetti.dart';

class AdoptButton extends StatefulWidget {
  final Pet pet;
  final VoidCallback? onPressed;

  const AdoptButton({Key? key, required this.pet, this.onPressed}) : super(key: key);

  @override
  State<AdoptButton> createState() => _AdoptButtonState();
}

class _AdoptButtonState extends State<AdoptButton> {
  late ConfettiController _confettiController;
  bool isAdopted = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isAdopted)
          ElevatedButton(
            onPressed: () {
                widget.onPressed!();
                isAdopted = true;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Congratulations!'),
                  content: Text('You’ve adopted ${widget.pet.name}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
              context.read<PetBloc>().adoptPet(widget.pet.id);
              _confettiController.play();

            },
            child: Text('Adopt Me'),
          )
        else
          ElevatedButton(
            onPressed: null,
            child: Text('Already Adopted'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
          ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 20,
          shouldLoop: false,
        ),
      ],
    );
  }
}
