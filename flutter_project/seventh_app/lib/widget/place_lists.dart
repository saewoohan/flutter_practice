import 'package:flutter/material.dart';
import 'package:seventh_app/model/place.dart';
import 'package:seventh_app/main.dart';
import 'package:seventh_app/screen/place_details.dart';

class PlaceLists extends StatelessWidget {
  const PlaceLists({super.key, required this.places});

  final List<Place> places;

  void _onTapping(BuildContext context, Place place) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => PlaceDetails(place: place)));
  }

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
          child: Text('No place',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              )));
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  )),
          subtitle: Text(places[index].location.address,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  )),
          onTap: () {
            _onTapping(context, places[index]);
          },
        );
      },
    );
  }
}
