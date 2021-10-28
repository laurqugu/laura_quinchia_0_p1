class Logos {
  String light = '';
  String dark = '';

  Logos({required this.light, required this.dark});

  Logos.fromJson(Map<String, dynamic> json) {
    light = json['light'];
    dark = json['dark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['light'] = this.light;
    data['dark'] = this.dark;
    return data;
  }
}