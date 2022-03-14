
import 'language_model.dart';


class CountryModel {
  String? name;
  List<Language>? languages;
  String? native;
  String? capital;
  String? emoji;
  String? emojiU;

  CountryModel({
    this.name,
    this.languages,
    this.native,
    this.capital,
    this.emoji,
    this.emojiU,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        languages: json["languages"] != null
            ? List<Language>.from(
                json["languages"].map((x) => Language.fromJson(x)))
            : [],
    native: json["native"],
    capital: json["capital"],
    emoji: json["emoji"],

  );

  Map<String, dynamic> toJson() => {
        "name": name,
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
      };
}
