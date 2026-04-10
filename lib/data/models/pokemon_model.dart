class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Extraemos el ID de la URL (ej: "https://pokeapi.co/api/v2/pokemon/1/")
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[url.split('/').length - 2]);
    
    return Pokemon(
      id: id,
      name: json['name'],
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}