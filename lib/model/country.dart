import 'dart:convert';

// List<Country> productsResponseFromJson(String str) =>
//     List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

// String productsResponseToJson(List<Country> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  final String name;
  final List<Capital>? capital;
  final String flag;

  Country({
    required this.name,
    required this.capital,
    required this.flag,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'capital': capital,
      'flag': flag,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name']['common'],
      capital:
          List<Capital>.from(map['capital']?.map((p) => Capital.fromJson(p))),
      flag: map['flag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(source) => Country.fromMap(json.decode(source));
}

class Capital {
  late String name;

  Capital({required this.name});

  Capital.fromJson(Map<String, dynamic> json) {
    name = json as String;
  }
}
// class Fal {
//   late String fm;

// //   Map<String, dynamic> toMap() {
// //     return <String, dynamic>{
// //       'fm': fm,
// //     };
// //   }

// //   factory Fal.fromMap(Map<String, dynamic> map) {
// //     return Fal(
// //       fm: map['fm'] as String,
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory Fal.fromJson(String source) =>
// //       Fal.fromMap(json.decode(source) as Map<String, dynamic>);
// }
