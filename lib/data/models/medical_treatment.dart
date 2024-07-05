class MedicalTreatment {
  final int id;
  final String name;
  final String icon;
  final String type;
  final String note;
  MedicalTreatment({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.note,
  });

  factory MedicalTreatment.fromJson(Map<String, dynamic> json) {
    return MedicalTreatment(
      id: json['id'],
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? '',
      note: json['note'] ?? '',
    );
  }
  @override
  int get hashCode => id.hashCode + name.hashCode;

  @override
  bool operator ==(Object other) {
    return other is MedicalTreatment && other.id == id && other.name == name;
  }
}
