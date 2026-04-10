import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/favorites/favorites_bloc.dart';
import '../../logic/blocs/favorites/favorites_state.dart';
import '../widgets/pokemon_card.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state.favoritePokemons.isEmpty) {
          return const Center(child: Text("Aún no tienes pokémon favoritos"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: state.favoritePokemons.length,
          itemBuilder: (context, index) {
            return PokemonCard(pokemon: state.favoritePokemons[index]);
          },
        );
      },
    );
  }
}