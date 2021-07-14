import 'package:geolocator/geolocator.dart';
import 'dart:math';

class Restaurant {
  String place_name;
  String id;
  String x, y;
  String category_name;
  String phone;
  num distance;

  Restaurant(
      {this.place_name,
      this.id,
      this.category_name,
      this.phone,
      this.x,
      this.y,
      this.distance});

  factory Restaurant.fromJson(
      Map<String, dynamic> json, Position currentLocation) {
    String _x = json['x'] as String;
    String _y = json['y'] as String;
    return Restaurant(
      place_name: json['place_name'] as String,
      id: json['id'] as String,
      category_name: json['category_name'] as String,
      phone: json['phone'] as String,
      x: _x,
      y: _y,
      distance: pow(currentLocation.latitude - num.parse(_x), 2) *
          pow(currentLocation.longitude - num.parse(_y), 2),
    );
  }
}
