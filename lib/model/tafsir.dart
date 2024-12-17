class TafsirModel {
  final int ayat;
  final String tafsir;

  TafsirModel({
    required this.ayat,
    required this.tafsir,
  });

  // Factory method untuk membuat objek TafsirModel dari JSON
  factory TafsirModel.fromJson(Map<String, dynamic> json) {
    return TafsirModel(
      ayat: json['ayat'],
      tafsir: json['tafsir'],
    );
  }
}
