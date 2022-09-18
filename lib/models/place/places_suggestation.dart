
class PlacesSuggestion {
  late String placeId;
  late String description;

  PlacesSuggestion({required this.placeId, required this.description});
  PlacesSuggestion.fromJson(Map<String, dynamic> json)
      : placeId = json['place_id'],
        description = json['description'];

}