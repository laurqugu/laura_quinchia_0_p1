import 'package:soccer_app/models/logos.dart';

class Data {
  String id = '';
  String name = '';
  String slug = '';
  String abbr = '';
  Logos logos = Logos(light: '', dark: 'dark');

  Data({
    required this.id, 
    required this.name, 
    required this.slug, 
    required this.abbr, 
    required this.logos
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    abbr = json['abbr'];
    logos = Logos.fromJson(json['logos']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['abbr'] = this.abbr;
    data['logos'] = this.logos.toJson();

    return data;
  }
}