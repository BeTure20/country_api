// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Country {
  String name;
  String capital;
  String flag;
  Country(
    this.name,
    this.capital,
    this.flag,
  );
  Country copyWith({
    String? name,
    String? capital,
    String? flag,
  }) {
    return Country(
      name ?? this.name,
      capital ?? this.capital,
      flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'capital': capital,
      'flag': flag,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      map['name'] as String,
      map['capital'] as String,
      map['flag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Country(name: $name, capital: $capital, flag: $flag)';

  @override
  bool operator ==(covariant Country other) {
    if (identical(this, other)) return true;

    return other.name == name && other.capital == capital && other.flag == flag;
  }

  @override
  int get hashCode => name.hashCode ^ capital.hashCode ^ flag.hashCode;
}
