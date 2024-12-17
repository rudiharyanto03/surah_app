import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/surah.dart';
import '../model/tafsir.dart';


class SuratService {
  static const String baseUrl = 'https://equran.id/api';

  Future<List<SuratModel>> fetchSuratList() async {
    final response = await http.get(Uri.parse('$baseUrl/surat'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => SuratModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load surat list');
    }
  }

  Future<SuratModel> fetchSuratDetail(int nomor) async {
    final response = await http.get(Uri.parse('$baseUrl/surat/$nomor'));

    if (response.statusCode == 200) {
      return SuratModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load surat detail');
    }
  }

  Future<List<TafsirModel>> fetchTafsirDetail(int nomor) async {
    final response = await http.get(Uri.parse('$baseUrl/tafsir/$nomor'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['tafsir'];
      return data.map((json) => TafsirModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tafsir detail');
    }
  }
}
