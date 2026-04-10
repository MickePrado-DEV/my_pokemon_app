import '../../../data/models/pokemon_model.dart';

class TeamState {
  final List<Pokemon> myTeam;
  final String? errorMessage; // Para avisar si ya hay 6

  TeamState({required this.myTeam, this.errorMessage});
}