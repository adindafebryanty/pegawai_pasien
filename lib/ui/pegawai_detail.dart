import 'package:flutter/material.dart';
import 'package:pegawai_app/ui/pegpas_page.dart';
import '../model/peg_pas.dart';
import '../ui/pegawai_updateform.dart';
import '../service/pegpas_service.dart';

class DetailPegawai extends StatefulWidget {
  final Pegawai pegawai;
  const DetailPegawai({Key? key, required this.pegawai}) : super(key: key);
  _DetailPegawaiState createState() => _DetailPegawaiState();
}

class _DetailPegawaiState extends State<DetailPegawai> {
  Stream<Pegawai> getData() async* {
    Pegawai data = await PegawaiPasienService()
        .getPegawaiById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pegawai")),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }

          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Id: ${widget.pegawai.id ?? ''}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nip: ${widget.pegawai.nip}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nama: ${widget.pegawai.nama}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Tanggal Lahir: ${widget.pegawai.tanggal_lahir}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nomor Telepon: ${widget.pegawai.nomor_telepon}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Email: ${widget.pegawai.email}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Password: ${widget.pegawai.password}",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tombolUbah(),
                  _tombolHapus(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PegawaiUpdateForm(pegawai: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 5, 132, 235)),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Ingin Menghapus Data Ini?"),
            actions: [
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await PegawaiPasienService()
                              .hapusPegawai(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PegPasPage()));
                          });
                        },
                        child: const Text("Ya"),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                      )),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Tidak"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 220, 6, 6)),
        child: const Text("Hapus"));
  }
}
