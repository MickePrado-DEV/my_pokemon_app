import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/core/network/dio_client.dart';
import 'package:my_pokemon_app/data/repositories/game_repository.dart';
import 'package:my_pokemon_app/data/repositories/pokemon_repository.dart';
import 'package:my_pokemon_app/logic/blocs/game/game_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/game/game_event.dart';
import 'package:my_pokemon_app/logic/blocs/pokemon/pokemon_bloc.dart';
import 'logic/blocs/user/user_bloc.dart';
import 'logic/blocs/user/user_state.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 


  @override
  Widget build(BuildContext context) {
     final dioClient = DioClient();
     final gameRepo = GameRepository(dioClient);
     final pokemonRepo = PokemonRepository(dioClient);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(
                   create: (_) => GameBloc(gameRepo)..add(LoadGamesEvent()),
            ),
            BlocProvider(create: (_) => PokemonBloc(pokemonRepo) )
      ],
      child: MaterialApp(
        title: 'PokeApp Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            // Si el usuario ya se registró, va al Dashboard. Si no, al Onboarding.
            return state.isRegistered ? const DashboardScreen() : const OnboardingScreen();
          },
        ),
      ),
    );
  }
}