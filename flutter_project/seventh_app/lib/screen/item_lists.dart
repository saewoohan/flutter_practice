import 'package:flutter/material.dart';
import 'package:seventh_app/provider/list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seventh_app/widget/place_lists.dart';
import 'package:seventh_app/screen/add_items.dart';

class ItemLists extends ConsumerWidget{
  const ItemLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(
      title: const Text('Your Places'),
      actions: [
        IconButton(onPressed: ()  {
           Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddItems()));
        }, icon: const Icon(Icons.add)),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: PlaceLists(places: userPlaces),
    ),
    );
  }

}