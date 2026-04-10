import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/team/team_bloc.dart';
import 'package:my_pokemon_app/logic/blocs/team/team_event.dart';
import 'package:my_pokemon_app/logic/blocs/team/team_state.dart';


class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi Equipo Inicial"), backgroundColor: Colors.red),
      body: BlocBuilder<TeamBloc, TeamState>(
        builder: (context, state) {
          if (state.myTeam.isEmpty) {
            return const Center(child: Text("Tu equipo está vacío. ¡Atrapa algunos!"));
          }
          return ListView.builder(
            itemCount: state.myTeam.length,
            itemBuilder: (context, index) {
              final pokemon = state.myTeam[index];
              return ListTile(
                leading: CachedNetworkImage(
  imageUrl: pokemon.imageUrl,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
  width: 50,
),
                title: Text(pokemon.name.toUpperCase()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => context.read<TeamBloc>().add(RemoveFromTeamEvent(pokemon.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}