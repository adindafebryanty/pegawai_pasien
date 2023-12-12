import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pasien_detail.dart';
import '../service/pegpas_service.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nomor_rmCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();

  Future<Pasien> getData() async {
    Pasien data =
        await PegawaiPasienService().getPasienById(widget.pasien.id.toString());
    setState(() {
      _idCtrl.text = data.id.toString();
      _nomor_rmCtrl.text = data.nomor_rm;
      _namaCtrl.text = data.nama;
      _tanggal_lahirCtrl.text = data.tanggal_lahir;
      _nomor_teleponCtrl.text = data.nomor_telepon;
      _alamatCtrl.text = data.alamat;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Data Pasien")),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _fieldPasien(),
                  SizedBox(height: 15),
                  _tombolSimpan()
                ],
              ))),
    );
  }

  _fieldPasien() {
    return Column(children: [
      TextField(
        decoration: const InputDecoration(labelText: "Id"),
        controller: _idCtrl,
      ),
      TextField(
        decoration: const InputDecoration(labelText: "Nomor Rekam Medis"),
        controller: _nomor_rmCtrl,
      ),
      TextField(
        decoration: const InputDecoration(labelText: "Nama"),
        controller: _namaCtrl,
      ),
      TextField(
        decoration: const InputDecoration(labelText: "Tanggal Lahir"),
        controller: _tanggal_lahirCtrl,
      ),
      TextField(
        decoration: const InputDecoration(labelText: "Nomor Telepon"),
        controller: _nomor_teleponCtrl,
      ),
      TextField(
        decoration: const InputDecoration(labelText: "Alamat"),
        controller: _alamatCtrl,
      ),
    ]);
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
        String id = widget.pasien.id.toString();
        await PegawaiPasienService().ubahPasien(pasien, id).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPasien(pasien: pasien)));
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
