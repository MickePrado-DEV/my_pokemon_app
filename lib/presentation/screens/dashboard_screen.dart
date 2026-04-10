import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/game/game_bloc.dart';
import '../../logic/blocs/game/game_state.dart';
import '../../logic/blocs/pokemon/pokemon_bloc.dart';
import '../../logic/blocs/pokemon/pokemon_event.dart';
import '../../logic/blocs/pokemon/pokemon_state.dart';
import '../widgets/pokemon_card.dart'; // Importa el widget que creamos

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ... (tu lógica de BottomNavigationBar anterior se mantiene)

  @override
  Widget build(BuildContext context) {
    // 1. BlocListener escucha los cambios en GameBloc
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameLoaded) {
          // Si el juego cambia, disparamos la carga de Pokémon
          context.read<PokemonBloc>().add(FetchPokemonsEvent(state.selectedGame));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GameLoaded) return Text("Juego: ${state.selectedGame}");
              return const Text("Cargando...");
            },
          ),
          backgroundColor: Colors.red,
        ),
        drawer: const Drawer(), // (tu lógica de Drawer anterior se mantiene)
        
        // 2. BlocBuilder construye el GridView basado en PokemonBloc
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columnas
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1, // Proporción de la tarjeta
                ),
                itemCount: state.pokemons.length,
                itemBuilder: (context, index) {
                  return PokemonCard(pokemon: state.pokemons[index]);
                },
              );
            } else if (state is PokemonError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("Selecciona un juego en el menú"));
          },
        ),
        
        // ... (tu lógica de Pokébola y BottomNavigationBar anterior se mantiene)
      ),
    );
  }
}