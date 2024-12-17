import 'package:flutter/material.dart';
import 'package:surah_app/Screens/tafsirScreen.dart';

import '../model/surah.dart';
import '../service/api_service.dart';

class SuratDetailScreen extends StatefulWidget {
  final int nomor;

  SuratDetailScreen({required this.nomor});

  @override
  _SuratDetailScreenState createState() => _SuratDetailScreenState();
}

class _SuratDetailScreenState extends State<SuratDetailScreen> {
  SuratModel? suratDetail; // Ubah menjadi nullable SuratModel
  bool isLoading = true;
  final SuratService _suratService = SuratService();

  @override
  void initState() {
    super.initState();
    _fetchSuratDetail();
  }

  // Memanggil service untuk mengambil detail surat
  Future<void> _fetchSuratDetail() async {
    try {
      final data = await _suratService.fetchSuratDetail(widget.nomor);
      setState(() {
        suratDetail = data; // Menyimpan data ke suratDetail
        isLoading = false;   // Menandakan loading selesai
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching surat detail: $e');
    }
  }

  // Fungsi untuk membuka halaman tafsir
  void _navigateToTafsir() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TafsirScreen(nomor: widget.nomor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Periksa apakah suratDetail sudah terisi atau masih null
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Jika suratDetail null, tampilkan pesan error atau placeholder
    if (suratDetail == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Failed to load surat details")),
      );
    }

    // Jika data sudah berhasil diambil, tampilkan detail surat
    return Scaffold(
      appBar: AppBar(title: Text(suratDetail!.namaLatin), backgroundColor: Colors.green,),
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