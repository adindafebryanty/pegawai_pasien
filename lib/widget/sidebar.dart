import 'package:flutter/material.dart';
import 'package:pegawai_app/ui/pasien_form.dart';
import 'package:pegawai_app/ui/pegawai_detail.dart';
import 'package:pegawai_app/ui/pegawai_form.dart';
import '../ui/Login.dart';
import '../ui/beranda.dart';
import '../ui/pegpas_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('adinda123@gmail.com')),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Beranda'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beranda()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Pegawai Dan Pasien'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PegPasPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outlined),
            title: Text('Pegawai'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PegawaiForm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('Pasien'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PasienForm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Keluar'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
