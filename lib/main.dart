import 'package:flutter/material.dart';
import '/ui/Login.dart';
import '/helpers/user_info.dart';
import '/ui/beranda.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(MaterialApp(
    title: "Rumah Sakit",
    debugShowCheckedModeBanner: false,
    home: token == null ? Beranda() : Login(),
  ));
}
