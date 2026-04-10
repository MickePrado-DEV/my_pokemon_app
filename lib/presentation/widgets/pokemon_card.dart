import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/data/models/pokemon_model.dart';
import 'package:my_pokemon_app/logic/blocs/favorites/favorites_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/favorites/favorites_event.dart';
import 'package:my_pokemon_app/logic/blocs/favorites/favorites_state.dart';


class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Usamos CachedNetworkImage para cachear las imágenes
            // (Necesitarás agregar 'cached_network_image: ^3.3.0' al pubspec.yaml)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                pokemon.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ), 
      ),
      Positioned(
          top: 5,
          right: 5,
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              final isFavorite = state.favoritePokemons.any((p) => p.id == pokemon.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context.read<FavoritesBloc>().add(ToggleFavoriteEvent(pokemon));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}