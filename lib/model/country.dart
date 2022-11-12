import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String welcomeToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Name name;
  String flag, region, timezones;
  dynamic population;
  Flags? flags;
  String capital;
  Flags? coatOfArms;
  Idd? dialcode;
  Car? car;
  // Languages? languages;
  double area;
  Country(
      {required this.name,
      required this.area,
      // required this.languages,
      required this.dialcode,
      required this.region,
      required this.population,
      required this.capital,
      required this.flag,
      required this.coatOfArms,
      required this.flags,
      required this.car,
      required this.timezones});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: Name.fromJson(json["name"]),
        flag: json["flag"],
        dialcode: Idd.fromJson(json["idd"]),
        timezones: json["timezones"].toString(),
        region: json["region"],
        area: json["area"],
        population: json["population"],
        capital: json["capital"].toString(),
        flags: Flags.fromJson(json['flags']),
        car: Car.fromJson(json['car']),
        // languages: Languages.fromJson(json["languages"]),
        coatOfArms: Flags.fromJson(json['coatOfArms']),
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "flag": flag,
        "area": area,
        "timezones": timezones,
        "region": region,
        "population": population,
        "capital": capital,
        "flags": flags!.toJson(),
        "car": car!.toJson(),
        "idd": dialcode!.toJson(),
        // "languages": languages!.toJson(),
        "coatOfArms": coatOfArms!.toJson()
      };
}

class Name implements Comparable {
  Name({
    required this.common,
    required this.official,
  });

  String common;
  String official;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"] as String,
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
      };
  // // sort by Name (asc)
  @override
  int compareTo(other) {
    return common.compareTo(other.common);
  }
}

class Flags {
  dynamic png;
  dynamic svg;

  Flags({this.png, this.svg});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['png'] = png;
    data['svg'] = svg;
    return data;
  }
}

class Idd {
  String? root;
  List<dynamic>? suffixes;
  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    suffixes = json['suffixes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['root'] = root;
    suffixes = data['suffixes'];
    return data;
  }
}

class Car {
  List<dynamic>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json['signs'];
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['signs'] = signs;
    data['side'] = side;
    return data;
  }
}

// class Languages {
//   String? ara;

//   Languages({this.ara});

//   Languages.fromJson(Map<String, dynamic> json) {
//     ara = json['ara'] as String;
//   }

//   Map<String, dynamic> toJson() => {
//         "ara": ara,
//       };
// }
