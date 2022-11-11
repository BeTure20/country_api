import 'dart:convert';

import 'package:country_api/model/translations.dart';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String welcomeToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<dynamic>? latlng;
  bool? landlocked;
  List<String>? borders;
  double? area;
  Demonyms? demonyms;
  String? flag;
  Maps? maps;
  int? population;
  Gini? gini;
  String? fifa;
  Car? car;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  Flags? coatOfArms;
  String? startOfWeek;
  CapitalInfo? capitalInfo;

  Country(
      {this.name,
      this.tld,
      this.cca2,
      this.ccn3,
      this.cca3,
      this.cioc,
      this.independent,
      this.status,
      this.unMember,
      this.currencies,
      this.idd,
      this.capital,
      this.altSpellings,
      this.region,
      this.subregion,
      this.languages,
      this.translations,
      this.latlng,
      this.landlocked,
      this.borders,
      this.area,
      this.demonyms,
      this.flag,
      this.maps,
      this.population,
      this.gini,
      this.fifa,
      this.car,
      this.timezones,
      this.continents,
      this.flags,
      this.coatOfArms,
      this.startOfWeek,
      this.capitalInfo});

  Country.fromJson(Map<String, dynamic> json) {
    name = Name.fromJson(json['name']);
    tld = json['tld'].cast<String>();
    cca2 = json['cca2'];
    ccn3 = json['ccn3'];
    cca3 = json['cca3'];
    cioc = json['cioc'];
    independent = json['independent'];
    status = json['status'];
    unMember = json['unMember'];
    currencies = Currencies.fromJson(json['currencies']);
    idd = Idd.fromJson(json['idd']);
    capital = json['capital'].cast<String>();
    altSpellings = json['altSpellings'].cast<String>();
    region = json['region'];
    subregion = json['subregion'];
    languages = Languages.fromJson(json['languages']);
    translations = Translations.fromJson(json['translations']);
    latlng = json['latlng'].cast<int>();
    landlocked = json['landlocked'];
    borders = json['borders'].cast<String>();
    area = json['area'];
    demonyms = Demonyms.fromJson(json['demonyms']);
    flag = json['flag'];
    maps = Maps.fromJson(json['maps']);
    population = json['population'];
    gini = Gini.fromJson(json['gini']);
    fifa = json['fifa'];
    car = Car.fromJson(json['car']);
    timezones = json['timezones'].cast<String>();
    continents = json['continents'].cast<String>();
    flags = Flags.fromJson(json['flags']);
    coatOfArms = Flags.fromJson(json['coatOfArms']);
    startOfWeek = json['startOfWeek'];
    capitalInfo = CapitalInfo.fromJson(json['capitalInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['tld'] = tld;
    data['cca2'] = cca2;
    data['ccn3'] = ccn3;
    data['cca3'] = cca3;
    data['cioc'] = cioc;
    data['independent'] = independent;
    data['status'] = status;
    data['unMember'] = unMember;
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    if (idd != null) {
      data['idd'] = idd!.toJson();
    }
    data['capital'] = capital;
    data['altSpellings'] = altSpellings;
    data['region'] = region;
    data['subregion'] = subregion;
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    if (translations != null) {
      data['translations'] = translations!.toJson();
    }
    data['latlng'] = latlng;
    data['landlocked'] = landlocked;
    data['borders'] = borders;
    data['area'] = area;
    if (demonyms != null) {
      data['demonyms'] = demonyms!.toJson();
    }
    data['flag'] = flag;
    if (maps != null) {
      data['maps'] = maps!.toJson();
    }
    data['population'] = population;
    if (gini != null) {
      data['gini'] = gini!.toJson();
    }
    data['fifa'] = fifa;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['timezones'] = timezones;
    data['continents'] = continents;
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (coatOfArms != null) {
      data['coatOfArms'] = coatOfArms!.toJson();
    }
    data['startOfWeek'] = startOfWeek;
    if (capitalInfo != null) {
      data['capitalInfo'] = capitalInfo!.toJson();
    }
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Ara? ara;

  NativeName({this.ara});

  NativeName.fromJson(Map<String, dynamic> json) {
    ara = json['ara'] != null ? Ara.fromJson(json['ara']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ara != null) {
      data['ara'] = ara!.toJson();
    }
    return data;
  }
}

class Ara {
  String? official;
  String? common;

  Ara({this.official, this.common});

  Ara.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

class Currencies {
  MRU? mRU;

  Currencies({this.mRU});

  Currencies.fromJson(Map<String, dynamic> json) {
    mRU = json['MRU'] != null ? MRU.fromJson(json['MRU']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mRU != null) {
      data['MRU'] = mRU!.toJson();
    }
    return data;
  }
}

class MRU {
  String? name;
  String? symbol;

  MRU({this.name, this.symbol});

  MRU.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}

class Idd {
  String? root;
  List<String>? suffixes;

  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    suffixes = json['suffixes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['root'] = root;
    data['suffixes'] = suffixes;
    return data;
  }
}

class Languages {
  String? ara;

  Languages({this.ara});

  Languages.fromJson(Map<String, dynamic> json) {
    ara = json['ara'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ara'] = ara;
    return data;
  }
}

class Demonyms {
  Eng? eng;
  Eng? fra;

  Demonyms({this.eng, this.fra});

  Demonyms.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
    fra = json['fra'] != null ? Eng.fromJson(json['fra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    if (fra != null) {
      data['fra'] = fra!.toJson();
    }
    return data;
  }
}

class Eng {
  String? f;
  String? m;

  Eng({this.f, this.m});

  Eng.fromJson(Map<String, dynamic> json) {
    f = json['f'];
    m = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f'] = f;
    data['m'] = m;
    return data;
  }
}

class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json['googleMaps'];
    openStreetMaps = json['openStreetMaps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['googleMaps'] = googleMaps;
    data['openStreetMaps'] = openStreetMaps;
    return data;
  }
}

class Gini {
  double? d2014;

  Gini({this.d2014});

  Gini.fromJson(Map<String, dynamic> json) {
    d2014 = json['2014'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2014'] = d2014;
    return data;
  }
}

class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json['signs'].cast<String>();
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['signs'] = signs;
    data['side'] = side;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;

  Flags({this.png, this.svg});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    return data;
  }
}

class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({this.latlng});

  CapitalInfo.fromJson(Map<String, dynamic> json) {
    latlng = json['latlng'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latlng'] = latlng;
    return data;
  }
}
// class Country {
//   Name name;
//   String flag, population;
//   Flags? flags;
//   String capital;
//   Flags? coatOfArms;
//   Country({
//     required this.name,
//     required this.population,
//     required this.capital,
//     required this.flag,
//     required this.coatOfArms,
//     required this.flags,
//   });

//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//         name: Name.fromJson(json["name"]),
//         flag: json["flag"],
//         population: json["population"],
//         capital: json["capital"].toString(),
//         flags: Flags.fromJson(json['flags']),
//         coatOfArms: Flags.fromJson(json['coatOfArms']),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name.toJson(),
//         "flag": flag,
//         "population": population,
//         "capital": capital,
//         "flags": flags!.toJson(),
//         "coatOfArms": coatOfArms!.toJson()
//       };
// }

// class Name {
//   Name({
//     required this.common,
//     required this.official,
//   });

//   String common;
//   String official;

//   factory Name.fromJson(Map<String, dynamic> json) => Name(
//         common: json["common"] as String,
//         official: json["official"],
//       );

//   Map<String, dynamic> toJson() => {
//         "common": common,
//         "official": official,
//       };

//   // // sort by Name (asc)
//   // @override
//   // int compareTo(other) {
//   //   return common.compareTo(other.common);
//   // }
// }

// class Flags {
//   String? png;
//   String? svg;

//   Flags({this.png, this.svg});

//   Flags.fromJson(Map<String, dynamic> json) {
//     png = json['png'];
//     svg = json['svg'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['png'] = png;
//     data['svg'] = svg;
//     return data;
//   }
// }
