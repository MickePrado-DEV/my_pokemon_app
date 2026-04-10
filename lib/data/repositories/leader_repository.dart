import '../models/leader_model.dart';

class LeaderRepository {
  List<Leader> getLeadersByGame(String gameName) {
    // Si el juego es de la primera generación
    if (gameName.contains('red') || gameName.contains('blue') || gameName.contains('yellow')) {
      return [
        Leader(
          name: "Brock",
          gymName: "Gimnasio Plateada",
          badgeName: "Medalla Roca",
          imageUrl: "https://play.pokemonshowdown.com/sprites/trainers/brock.png",
          badgeUrl: "https://archives.bulbagardenoforce.net/media/upload/thumb/d/dd/Boulder_Badge.png/50px-Boulder_Badge.png",
        ),
        Leader(
          name: "Misty",
          gymName: "Gimnasio Celeste",
          badgeName: "Medalla Cascada",
          imageUrl: "https://play.pokemonshowdown.com/sprites/trainers/misty.png",
          badgeUrl: "https://archives.bulbagardenoforce.net/media/upload/thumb/9/9c/Cascade_Badge.png/50px-Cascade_Badge.png",
        ),
        // Puedes agregar los 8 líderes aquí...
      ];
    }
    
    // Por defecto retornamos una lista vacía o de otra región
    return [];
  }
}