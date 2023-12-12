import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pegawai_detail.dart';
import '../service/pegpas_service.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);
  State<PegawaiForm> createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isi Form Pegawai')),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldPegawai(),
                SizedBox(height: 20),
                _tombolSimpan()
              ],
            )),
      ),
    );
  }

  _fieldPegawai() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Id"),
          controller: _idCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Nip"),
          controller: _nipCtrl,
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
          decoration: InputDecoration(labelText: "Email"),
          controller: _emailCtrl,
        ),
        TextField(
          decoration: InputDecoration(labelText: "Password"),
          controller: _passwordCtrl,
        ),
      ],
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pegawai pegawai = new Pegawai(
            id: int.parse(_idCtrl.text),
            nip: _nipCtrl.text,
            nama: _namaCtrl.text,
            tanggal_lahir: _tanggal_lahirCtrl.text,
            nomor_telepon: _nomor_teleponCtrl.text,
            email: _emailCtrl.text,
            password: _passwordCtrl.text,
          );
          await PegawaiPasienService().simpanPegawai(pegawai).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPegawai(pegawai: value)));
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 12, 35, 164)),
        child: const Text("Simpan"));
  }
}
