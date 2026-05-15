class Vessel {
  final int id;
  final String name;

  Vessel({required this.id, required this.name});

  factory Vessel.fromJson(Map<String, dynamic> json) {
    return Vessel(
      id: json['id'],
      name: json['name'],
    );
  }
}
