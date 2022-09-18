import 'package:find_and_lost/models/place/places_suggestation.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final PlacesSuggestion suggestion;

  const PlaceItem({required this.suggestion, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestion.description
        .replaceAll(suggestion.description.split(',')[0], '');
    try{
      subTitle = subTitle.substring(2);
    }
    catch(e){
    }
    return Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.all(8),
        padding: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
                ),
                child: Icon(
                  Icons.place,
                  color: Colors.white,
                ),
              ),
              title: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: '${suggestion.description.split(',')[0]}\n',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: subTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
            ),
          ],
        ));
  }
}
