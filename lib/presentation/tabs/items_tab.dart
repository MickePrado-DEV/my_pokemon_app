import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../logic/blocs/items/item_bloc.dart';
import '../../logic/blocs/items/item_state.dart';

class ItemsTab extends StatelessWidget {
  const ItemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ItemLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 objetos por fila
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      height: 40,
                      errorWidget: (context, url, error) => const Icon(Icons.help_outline),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.name.replaceAll('-', ' '),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is ItemError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Presiona para cargar objetos"));
      },
    );
  }
}