class Leader {
  final String name;
  final String gymName;
  final String badgeUrl;

  Leader({required this.name, required this.gymName, required this.badgeUrl});
}

class LeaderRepository {
  List<Leader> getLeadersByGame(String gameName) {
    // Ejemplo para juegos de Kanto (red, blue, yellow)
    if (gameName.contains('red') || gameName.contains('blue')) {
      return [
        Leader(name: "Brock", gymName: "Gimnasio Plateada", badgeUrl: "URL_MEDALLA_ROCA"),
        Leader(name: "Misty", gymName: "Gimnasio Celeste", badgeUrl: "URL_MEDALLA_CASCADA"),
      ];
    }
    return []; // Retornar otros según el juego
  }
}