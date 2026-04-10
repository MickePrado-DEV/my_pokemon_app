

import 'package:my_pokemon_app/data/models/item_model.dart';

abstract class ItemState {}
class ItemInitial extends ItemState {}
class ItemLoading extends ItemState {}
class ItemLoaded extends ItemState {
  final List<ItemModel> items;
  ItemLoaded(this.items);
}
class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}