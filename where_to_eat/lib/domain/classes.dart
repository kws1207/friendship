import 'package:quiver/core.dart';
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

  @override
  int get hashCode => hash2(place_name.hashCode, id.hashCode);

  @override
  bool operator ==(other) {
    return other.id == id;
  }

  factory Restaurant.fromJsonInit(Map<String, dynamic> json) {
    return Restaurant(
      place_name: json['place_name'] as String,
      id: json['id'] as String,
      category_name: json['category_name'] as String,
      phone: json['phone'] as String,
      x: json['x'] as String,
      y: json['y'] as String,
      distance: 0,
    );
  }

  factory Restaurant.fromJson(
      Map<String, dynamic> json, Restaurant kopoLocation) {
    String _x = json['x'] as String;
    String _y = json['y'] as String;
    return Restaurant(
      place_name: json['place_name'] as String,
      id: json['id'] as String,
      category_name: json['category_name'] as String,
      phone: json['phone'] as String,
      x: _x,
      y: _y,
      distance: pow(num.parse(kopoLocation.x) - num.parse(_x), 2) +
          pow(num.parse(kopoLocation.y) - num.parse(_y), 2),
    );
  }
}
