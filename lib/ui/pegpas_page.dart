import 'package:flutter/material.dart';
import '../model/peg_pas.dart';
import '../ui/pegawai_form.dart';
import '../ui/pasien_form.dart';
import '../ui/pegawai_item.dart';
import '../ui/pasien_item.dart';
import '../widget/sidebar.dart';
import '../service/pegpas_service.dart';

class PegPasPage extends StatefulWidget {
  const PegPasPage({Key? key}) : super(key: key);
  _PegPasPageState createState() => _PegPasPageState();
}

class _PegPasPageState extends State<PegPasPage> {
  Stream<List<Pegawai>> getListPegawai() async* {
    List<Pegawai> data = await PegawaiPasienService().ListDataPegawai();
    yield data;
  }

  Future refreshDataPegawai() async {
    await Future.delayed(Duration(seconds: 1));
    getListPegawai();
  }

  Stream<List<Pasien>> getListPasien() async* {
    List<Pasien> data = await PegawaiPasienService().ListDataPasien();
    yield data;
  }

  Future refreshDataPasien() async {
    await Future.delayed(Duration(seconds: 1));

    getListPasien();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pegawai & Pasien"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Pilih Form"),
                    content: Text("Pilih Form yang Ingin Anda Tambahkan:"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PegawaiForm(),
                            ),
                          );
                        },
                        child: const Text("Form Pegawai"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PasienForm(),
                            ),
                          );
                        },
                        child: const Text("Form Pasien"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshDataPegawai,
              child: StreamBuilder(
                stream: getListPegawai(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('Data Kosong');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ItemPegawai(pegawai: snapshot.data[index]);
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshDataPasien,
              child: StreamBuilder(
                stream: getListPasien(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('Data Kosong');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ItemPasien(pasien: snapshot.data[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
