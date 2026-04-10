import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/presentation/screens/team_screen.dart';
import '../../logic/blocs/game/game_bloc.dart';
import '../../logic/blocs/game/game_state.dart';
import '../../logic/blocs/pokemon/pokemon_bloc.dart';
import '../../logic/blocs/pokemon/pokemon_event.dart';
import '../../logic/blocs/pokemon/pokemon_state.dart';
import '../widgets/pokemon_card.dart';
import '../tabs/favorites_tab.dart'; // Asegúrate de tener este import

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Lista de las vistas principales
  // Nota: La Pokébola central no es una "pestaña" per se, 
  // sino un botón de acción rápida que definiremos luego.
  final List<Widget> _tabs = [
    const _PokemonListTab(),   // Vista 1: Listado por juego
    const Center(child: Text("Objetos (Próximamente)")), // Vista 2
    const Center(child: Text("Líderes (Próximamente)")), // Vista 3
    const FavoritesTab(),      // Vista 4: Tus favoritos (Ya integrada)
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameLoaded) {
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
        drawer: const Drawer(), // Aquí va el código que ya teníamos de la lista de juegos
        
        // El body ahora cambia según el índice seleccionado
        body: _tabs[_currentIndex],

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            // Aquí irá la lógica de "Mi Equipo"
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TeamScreen()),);
          },
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/1200px-Pok%C3%A9_Ball_icon.svg.png',
            height: 35,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.list, color: _currentIndex == 0 ? Colors.red : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.badge_outlined, color: _currentIndex == 1 ? Colors.red : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
              const SizedBox(width: 40), // Espacio para la Pokébola
              IconButton(
                icon: Icon(Icons.emoji_events_outlined, color: _currentIndex == 2 ? Colors.red : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 2),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: _currentIndex == 3 ? Colors.red : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget interno para limpiar el código del body del listado principal
class _PokemonListTab extends StatelessWidget {
  const _PokemonListTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: state.pokemons.length,
            itemBuilder: (context, index) => PokemonCard(pokemon: state.pokemons[index]),
          );
        }
        return const Center(child: Text("Selecciona un juego en el menú lateral"));
      },
    );
  }
}