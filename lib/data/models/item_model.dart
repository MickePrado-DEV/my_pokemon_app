class ItemModel {
  final String name;
  final String imageUrl;

  ItemModel({required this.name, required this.imageUrl});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    return ItemModel(
      name: name,
      // URL estándar de la PokeAPI para sprites de objetos
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/$name.png',
    );
  }
}