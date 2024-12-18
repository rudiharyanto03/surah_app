import 'package:flutter/material.dart';
import 'package:surah_app/Screens/tafsirScreen.dart';

import '../model/surah.dart';
import '../service/api_service.dart';

class SuratDetailScreen extends StatefulWidget {
  final int nomor;
  final String namaLatin;

  SuratDetailScreen({required this.nomor, required this.namaLatin});

  @override
  _SuratDetailScreenState createState() => _SuratDetailScreenState();
}

class _SuratDetailScreenState extends State<SuratDetailScreen> {
  SuratModel? suratDetail; 
  bool isLoading = true;
  final SuratService _suratService = SuratService();

  @override
  void initState() {
    super.initState();
    _fetchSuratDetail();
  }


  Future<void> _fetchSuratDetail() async {
    try {
      final data = await _suratService.fetchSuratDetail(widget.nomor);
      setState(() {
        suratDetail = data; 
        isLoading = false; 
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching surat detail: $e');
    }
  }

  void _navigateToTafsir() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TafsirScreen(
          nomor: widget.nomor,
          namaLatin: widget.namaLatin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (suratDetail == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Failed to load surat details")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(suratDetail!.namaLatin),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                suratDetail!.namaLatin,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Jumlah Ayat: ${suratDetail!.jumlahAyat}'),
              Text('Tempat Turun: ${suratDetail!.tempatTurun}'),
              Text('Arti: ${suratDetail!.arti}'),
              SizedBox(height: 20),
              Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(suratDetail!.deskripsi),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToTafsir,
                child: Text('Lihat Tafsir Surat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
