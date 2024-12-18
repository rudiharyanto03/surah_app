import 'package:flutter/material.dart';
import 'package:surah_app/Screens/detailScreen.dart';

import '../model/surah.dart';
import '../service/api_service.dart';

class SuratListScreen extends StatefulWidget {
  @override
  _SuratListScreenState createState() => _SuratListScreenState();
}

class _SuratListScreenState extends State<SuratListScreen> {
  List<SuratModel> suratList = [];
  bool isLoading = true;
  final SuratService _suratService = SuratService();

  @override
  void initState() {
    super.initState();
    _fetchSuratList();
  }

  Future<void> _fetchSuratList() async {
    try {
      final data = await _suratService.fetchSuratList();
      setState(() {
        suratList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching surat list: $e');
    }
  }

  void _navigateToDetail(int nomor, String nama) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuratDetailScreen(nomor: nomor, namaLatin: nama),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Surat'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: suratList.length,
              itemBuilder: (context, index) {
                var surat = suratList[index];
                return ListTile(
                  title: Text(surat.namaLatin),
                  subtitle: Text(surat.arti),
                  onTap: () => _navigateToDetail(surat.nomor, surat.namaLatin),
                );
              },
            ),
    );
  }
}
