import 'package:flutter/material.dart';
import '../model/tafsir.dart';
import '../service/api_service.dart';

class TafsirScreen extends StatefulWidget {
  final int nomor;
  final String namaLatin;

  TafsirScreen({required this.nomor,required this.namaLatin});

  @override
  _TafsirScreenState createState() => _TafsirScreenState();
}

class _TafsirScreenState extends State<TafsirScreen> {
  late List<TafsirModel> tafsirDetail;
  bool isLoading = true;
  final SuratService _suratService = SuratService();

  @override
  void initState() {
    super.initState();
    _fetchTafsirDetail();
  }

  Future<void> _fetchTafsirDetail() async {
    try {
      final data = await _suratService.fetchTafsirDetail(widget.nomor);
      setState(() {
        tafsirDetail = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching tafsir detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tafsir Surat ${widget.namaLatin}'), backgroundColor: Colors.green,),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tafsirDetail.length,
        itemBuilder: (context, index) {
          var tafsir = tafsirDetail[index];
          return ListTile(
            title: Text('Ayat ${tafsir.ayat}'),
            subtitle: Text(tafsir.tafsir),
          );
        },
      ),
    );
  }
}
