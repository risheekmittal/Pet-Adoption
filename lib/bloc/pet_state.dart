import 'package:equatable/equatable.dart';
import '../models/pet_model.dart';

abstract class PetState extends Equatable {
  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {}

class PetAdopted extends PetState {
  final Pet pet;

  PetAdopted(this.pet);

  @override
  List<Object> get props => [pet];
}
