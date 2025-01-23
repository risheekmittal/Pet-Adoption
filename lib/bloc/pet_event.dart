import 'package:equatable/equatable.dart';

abstract class PetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptPetEvent extends PetEvent {
  final String petId;

  AdoptPetEvent(this.petId);

  @override
  List<Object> get props => [petId];
}
