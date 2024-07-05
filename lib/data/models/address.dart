class Prefecture {
  final int id;
  final String name;
  final String nameJp;

  Prefecture({
    required this.id,
    required this.name,
    required this.nameJp,
  });

  factory Prefecture.fromJson(Map<String, dynamic> json) {
    return Prefecture(
      id: json['id'],
      name: json['name'],
      nameJp: json['name_jp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_jp': nameJp,
    };
  }

  @override
  bool operator ==(Object other) =>
      other is Prefecture &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name;

  @override
  int get hashCode => id.hashCode + name.hashCode;
}

class Address {
  final int id;
  final String zipCode;
  final String municipality;
  final String address;
  final String phone;
  final int defaultFlg;
  final Prefecture prefecture;

  Address({
    required this.id,
    required this.zipCode,
    required this.municipality,
    required this.address,
    required this.phone,
    required this.defaultFlg,
    required this.prefecture,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      zipCode: json['zip_code'],
      municipality: json['municipality'],
      address: json['address'],
      phone: json['phone'],
      defaultFlg: json['default_flg'],
      prefecture: Prefecture.fromJson(json['prefecture']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zip_code': zipCode,
      'municipality': municipality,
      'address': address,
      'phone': phone,
      'prefecture_id': prefecture.id,
    };
  }

  Address copyWith({
    int? id,
    String? zipCode,
    String? municipality,
    String? address,
    String? phone,
    int? defaultFlg,
    Prefecture? prefecture,
  }) {
    return Address(
      id: id ?? this.id,
      zipCode: zipCode ?? this.zipCode,
      municipality: municipality ?? this.municipality,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      defaultFlg: defaultFlg ?? this.defaultFlg,
      prefecture: prefecture ?? this.prefecture,
    );
  }
}
