import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pasien_detail.dart';
import '../service/pegpas_service.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({Key? key}) : super(key: key);
  _PasienFormState createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nomor_rmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isi form Pasien')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [_fieldPasien(), SizedBox(height: 20), _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldPasien() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Id"),
          controller: _idCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Nomor Rekam Medis"),
          controller: _nomor_rmCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Nama"),
          controller: _namaCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Tanggal Lahir"),
          controller: _tanggal_lahirCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Nomor Telepon"),
          controller: _nomor_teleponCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Alamat"),
          controller: _alamatCtrl,
        ),
      ],
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pasien pasien = new Pasien(
              id: int.parse(_idCtrl.text),
              nomor_rm: _nomor_rmCtrl.text,
              nama: _namaCtrl.text,
              tanggal_lahir: _tanggal_lahirCtrl.text,
              nomor_telepon: _nomor_teleponCtrl.text,
              alamat: _alamatCtrl.text);
          await PegawaiPasienService().simpanPasien(pasien).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPasien(pasien: value)));
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 12, 35, 164)),
        child: const Text("Simpan"));
  }
}
