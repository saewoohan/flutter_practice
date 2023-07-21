import 'package:flutter/material.dart';
import 'package:sixth_app/widgets/new_item.dart';

class NewItemScreen extends StatelessWidget{
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Add a new item'),
    ),
    body: const NewItem());
  }

}