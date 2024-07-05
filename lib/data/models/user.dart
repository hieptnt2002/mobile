class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String firstHiragana;
  final String lastHiragana;
  final int? gender;
  final String status;
  final DateTime? dateOfBirth;
  final String? medicalNumber;
  final String? creditCard;
  final int? isDoctor;
  final String? activeToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.firstHiragana,
    required this.lastHiragana,
    this.gender,
    this.status = 'ACTIVE',
    this.dateOfBirth,
    this.medicalNumber,
    this.creditCard,
    this.isDoctor,
    this.activeToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      firstHiragana: json['first_hiragana'] ?? '',
      lastHiragana: json['last_hiragana'] ?? '',
      gender: json['gender'],
      status: json['status'],
      dateOfBirth: DateTime.tryParse(json['date_of_birth'] ?? ''),
      medicalNumber: json['medical_number'].toString(),
      creditCard: json['credit_card'],
      isDoctor: json['is_doctor'],
      activeToken: json['active_token'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'first_hiragana': firstHiragana,
      'last_hiragana': lastHiragana,
      'gender': gender,
      'status': status,
      // 'date_of_birth': dateOfBirth == null
      //     ? null
      //     : DateFormat('yyyy-MM-dd').format(dateOfBirth!),
      'medical_number': medicalNumber,
      'credit_card': creditCard,
      'is_doctor': isDoctor,
    };
  }

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? firstHiragana,
    String? lastHiragana,
    int? gender,
    String? status,
    DateTime? dateOfBirth,
    String? medicalNumber,
    String? creditCard,
    int? isDoctor,
    String? activeToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deletedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      firstHiragana: firstHiragana ?? this.firstHiragana,
      lastHiragana: lastHiragana ?? this.lastHiragana,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      medicalNumber: medicalNumber ?? this.medicalNumber,
      creditCard: creditCard ?? this.creditCard,
      isDoctor: isDoctor ?? this.isDoctor,
      activeToken: activeToken ?? this.activeToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

class UserAndToken {
  final User userModel;
  final String jwt;
  UserAndToken({
    required this.userModel,
    required this.jwt,
  });
  factory UserAndToken.fromJson(Map<String, dynamic> json) {
    return UserAndToken(
      jwt: json['jwt'],
      userModel: User.fromJson(json['user']),
    );
  }
}
