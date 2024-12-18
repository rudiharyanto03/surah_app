class TafsirModel {
  final int ayat;
  final String tafsir;

  TafsirModel({
    required this.ayat,
    required this.tafsir,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) {
    return TafsirModel(
      ayat: json['ayat'],
      tafsir: json['tafsir'],
    );
  }
}
