import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pasien_detail.dart';

class ItemPasien extends StatelessWidget {
  final Pasien pasien;
  const ItemPasien({super.key, required this.pasien});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${pasien.nama}"),
          subtitle: Text("Pasien"),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPasien(pasien: pasien),
          ),
        );
      },
    );
  }
}
