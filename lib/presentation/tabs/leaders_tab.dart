import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/game/game_bloc.dart';
import '../../logic/blocs/game/game_state.dart';
import '../../data/repositories/leader_repository.dart';

class LeadersTab extends StatelessWidget {
  const LeadersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderRepo = LeaderRepository();

    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameLoaded) {
          final leaders = leaderRepo.getLeadersByGame(state.selectedGame);

          if (leaders.isEmpty) {
            return const Center(child: Text("Líderes no disponibles para este juego aún."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: leaders.length,
            itemBuilder: (context, index) {
              final leader = leaders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  leading: Image.network(leader.imageUrl, width: 50),
                  title: Text(leader.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(leader.gymName),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(leader.badgeUrl, width: 30),
                      Text(leader.badgeName, style: const TextStyle(fontSize: 8)),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}