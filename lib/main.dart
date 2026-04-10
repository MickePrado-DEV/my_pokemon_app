import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/core/network/dio_client.dart';
import 'package:my_pokemon_app/data/repositories/favorite_repository.dart';
import 'package:my_pokemon_app/data/repositories/game_repository.dart';
import 'package:my_pokemon_app/data/repositories/item_repository.dart';
import 'package:my_pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:my_pokemon_app/data/repositories/user_repository.dart';
import 'package:my_pokemon_app/logic/blocs/favorites/favorites_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/favorites/favorites_event.dart';
import 'package:my_pokemon_app/logic/blocs/game/game_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/game/game_event.dart';
import 'package:my_pokemon_app/logic/blocs/items/item_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/pokemon/pokemon_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/team/team_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/user/user_event.dart';
import 'logic/blocs/user/user_bloc.dart';
import 'logic/blocs/user/user_state.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() async {
  // 1. CRUCIAL: Asegura que los canales nativos (SharedPreferences, Dio) estén listos
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializamos instancias de una sola vez
  final dioClient = DioClient();
  final gameRepo = GameRepository(dioClient);
  final pokemonRepo = PokemonRepository(dioClient);
  final favoriteRepo = FavoriteRepository();
  final itemRepo = ItemRepository(dioClient);
  final userRepo = UserRepository();

  runApp(
    MyApp(
      gameRepo: gameRepo,
      pokemonRepo: pokemonRepo,
      favoriteRepo: favoriteRepo,
      itemRepo: itemRepo,
      userRepo:userRepo
    ),
  );
}

class MyApp extends StatelessWidget {
  final GameRepository gameRepo;
  final PokemonRepository pokemonRepo;
  final FavoriteRepository favoriteRepo;
  final ItemRepository itemRepo;
  final UserRepository userRepo;

  const MyApp({
    super.key,
    required this.gameRepo,
    required this.pokemonRepo,
    required this.favoriteRepo,
    required this.itemRepo,
    required this.userRepo
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc(userRepo)),
        BlocProvider(create: (_) => GameBloc(gameRepo)..add(LoadGamesEvent())),
        BlocProvider(create: (_) => PokemonBloc(pokemonRepo)),
        BlocProvider(
          create: (_) => FavoritesBloc(favoriteRepo)..add(LoadFavoritesEvent()),
        ),
        BlocProvider(create: (_) => TeamBloc()),
        BlocProvider(create: (_)=> ItemBloc(itemRepo)),
        BlocProvider(
          create: (_) => UserBloc(UserRepository())..add(LoadUserEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'PokeApp Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state.isRegistered 
                ? const DashboardScreen() 
                : const OnboardingScreen();
          },
        ),
      ),
    );
  }
}