class SuratModel {
  final int nomor;
  final String namaLatin;
  final String nama;
  final String arti;
  final int jumlahAyat;
  final String tempatTurun;
  final String deskripsi;

  SuratModel({
    required this.nomor,
    required this.namaLatin,
    required this.nama,
    required this.arti,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.deskripsi,
  });

  // Factory method untuk membuat objek SuratModel dari JSON
  factory SuratModel.fromJson(Map<String, dynamic> json) {
    return SuratModel(
      nomor: json['nomor'],
      namaLatin: json['nama_latin'],
      nama: json['nama'],
      arti: json['arti'],
      jumlahAyat: json['jumlah_ayat'],
      tempatTurun: json['tempat_turun'],
      deskripsi: json['deskripsi'],
    );
  }
}
