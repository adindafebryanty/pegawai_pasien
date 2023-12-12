import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pegawai_detail.dart';

class ItemPegawai extends StatelessWidget {
  final Pegawai pegawai;
  const ItemPegawai({Key? key, required this.pegawai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text("${pegawai.nama}"),
          subtitle: Text("Pegawai"),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPegawai(pegawai: pegawai),
          ),
        );
      },
    );
  }
}
