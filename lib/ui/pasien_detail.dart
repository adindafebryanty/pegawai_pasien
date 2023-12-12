import 'package:flutter/material.dart';
import '../ui/pegpas_page.dart';
import '../ui/pasien_updateform.dart';
import '../model/peg_pas.dart';
import '../service/pegpas_service.dart';

class DetailPasien extends StatefulWidget {
  final Pasien pasien;

  const DetailPasien({Key? key, required this.pasien}) : super(key: key);
  _DetailPasienState createState() => _DetailPasienState();
}

class _DetailPasienState extends State<DetailPasien> {
  Stream<Pasien> getData() async* {
    Pasien data =
        await PegawaiPasienService().getPasienById(widget.pasien.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pasien"),
      ),
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
                "Id: ${widget.pasien.id ?? ''}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nomor Rekam Medis: ${widget.pasien.nomor_rm}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nama: ${widget.pasien.nama}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Tanggal Lahir: ${widget.pasien.tanggal_lahir}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Nomor Telepon: ${widget.pasien.nomor_telepon}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Alamat: ${widget.pasien.alamat}",
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
                          PasienUpdateForm(pasien: snapshot.data)));
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
                              .hapusPasien(snapshot.data)
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
