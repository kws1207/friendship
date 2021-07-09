import 'package:http/http.dart';

class Restaurant {
  String place_name;
  String id;
  String category_name;
  String phone;

  Restaurant({this.place_name, this.id, this.category_name, this.phone});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      place_name: json['place_name'] as String,
      id: json['id'] as String,
      category_name: json['category_name'] as String,
      phone: json['phone'] as String,
    );
  }
}
