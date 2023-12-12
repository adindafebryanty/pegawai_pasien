import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pegawai_detail.dart';
import '../service/pegpas_service.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _tanggal_lahirCtrl = TextEditingController();
  final _nomor_teleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiPasienService()
        .getPegawaiById(widget.pegawai.id.toString());
    setState(() {
      _idCtrl.text = data.id.toString();
      _nipCtrl.text = data.nip;
      _namaCtrl.text = data.nama;
      _tanggal_lahirCtrl.text = data.tanggal_lahir;
      _nomor_teleponCtrl.text = data.nomor_telepon;
      _emailCtrl.text = data.email;
      _passwordCtrl.text = data.password;
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
      appBar: AppBar(title: const Text("Ubah Data Pegawai")),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _fieldPegawai(),
                  SizedBox(height: 15),
                  _tombolSimpan()
                ],
              ))),
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
        String id = widget.pegawai.id.toString();
        await PegawaiPasienService().ubahPegawai(pegawai, id).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPegawai(pegawai: pegawai)));
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
