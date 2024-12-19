import 'package:flutter/material.dart';
import 'package:surah_app/Screens/detailScreen.dart';

import '../model/surah.dart';
import '../service/api_service.dart';

class SuratListScreen extends StatefulWidget {
  @override
  _SuratListScreenState createState() => _SuratListScreenState();
}

class _SuratListScreenState extends State<SuratListScreen> {
  final SuratService _suratService = SuratService();
  List<SuratModel> _allSurat = [];
  List<SuratModel> _filteredSurat = [];
  bool _isLoading = true;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchSuratList();
  }

  Future<void> _fetchSuratList() async {
    try {
      final data = await _suratService.fetchSuratList();
      setState(() {
        _allSurat = data;
        _filteredSurat = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching surat list: $e');
    }
  }

  void _filterSurat(String query) {
    setState(() {
      _searchQuery = query;
      _filteredSurat = _allSurat
          .where((surat) =>
              surat.namaLatin.toLowerCase().contains(query.toLowerCase()) ||
              surat.arti.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Daftar Surat")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Surat"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Cari Surat",
                hintText: "Masukkan nama surat atau arti",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _filterSurat,
            ),
          ),
          Expanded(
            child: _filteredSurat.isEmpty
                ? Center(
                    child: Text("Tidak ada surat ditemukan"),
                  )
                : ListView.builder(
                    itemCount: _filteredSurat.length,
                    itemBuilder: (context, index) {
                      final surat = _filteredSurat[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuratDetailScreen(
                                  nomor: surat.nomor,
                                  namaLatin: surat.namaLatin,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.green.shade300,
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  surat.namaLatin,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Arti: ${surat.arti}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Ayat: ${surat.jumlahAyat}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
