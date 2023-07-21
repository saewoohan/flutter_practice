import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seventh_app/model/place.dart';
import 'package:seventh_app/provider/list_provider.dart';
import 'package:seventh_app/widget/image_input.dart';
import 'dart:io';

import 'package:seventh_app/widget/location_input.dart';

class AddItems extends ConsumerStatefulWidget{
  const AddItems({super.key});

  @override
  ConsumerState<AddItems> createState() {
    return _AddItemsState();
  }

}

class _AddItemsState extends ConsumerState<AddItems> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  String? _savedTitle;
  void _saveList(){
    if(_savedTitle == null || _selectedImage == null){
      return;
    }
    ref.read(placeProvider.notifier).addPlace(_savedTitle!, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Place'),
      ),
      body: Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Name',),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters.';
                      }
                      return null;
                    },
                    onChanged: (value){
                      _savedTitle = value;
                    },
                    ),
                 const SizedBox(height: 10),
                //Image Intput
                ImageInput(onselectedImage: (image) {
                  _selectedImage = image;
                }),
                  const SizedBox(height: 10),
                  LocationInput(onSelectedLocation: (location) {
                    _selectedLocation = location;
                  },),
                const SizedBox(height: 16,),
                ElevatedButton.icon(onPressed: (){
                  _saveList();
                }, icon: const Icon(Icons.add), label: const Text('Add Place')),
              ]
            ),
          )
      )
      )
    );
  }

}