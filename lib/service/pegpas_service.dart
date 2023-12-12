import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/peg_pas.dart';

class PegawaiPasienService {
  Future<List<Pegawai>> ListDataPegawai() async {
    final Response response = await ApiClient().get('poli');
    final List data = response.data as List;
    List<Pegawai> result = data.map((json) => Pegawai.fromJson(json)).toList();
    return result;
  }

  Future<Pegawai> simpanPegawai(Pegawai pegawai) async {
    var data = pegawai.toJson();
    final Response response = await ApiClient().post('pegawai', data);
    Pegawai result = Pegawai.fromJson(response.data);
    return result;
  }

  Future<Pegawai> ubahPegawai(Pegawai pegawai, String id) async {
    var data = pegawai.toJson();
    final Response response = await ApiClient().put('pegawai/$id', data);
    print(response);
    Pegawai result = Pegawai.fromJson(response.data);
    return result;
  }

  Future<Pegawai> getPegawaiById(String id) async {
    final Response response = await ApiClient().get('pegawai/$id');
    Pegawai result = Pegawai.fromJson(response.data);
    return result;
  }

  Future<Pegawai> hapusPegawai(Pegawai pegawai) async {
    final Response response =
        await ApiClient().delete('pegawai/${pegawai.id}', {});
    Pegawai result = Pegawai.fromJson(response.data);
    return result;
  }

  Future<List<Pasien>> ListDataPasien() async {
    final Response response = await ApiClient().get('poli');
    final List data = response.data as List;
    List<Pasien> result = data.map((json) => Pasien.fromJson(json)).toList();
    return result;
  }

  Future<Pasien> simpanPasien(Pasien pasien) async {
    var data = pasien.toJson();
    final Response response = await ApiClient().post('pasien', data);
    Pasien result = Pasien.fromJson(response.data);
    return result;
  }

  Future<Pasien> ubahPasien(Pasien pasien, String id) async {
    var data = pasien.toJson();
    final Response response = await ApiClient().put('pasien/$id', data);
    print(response);
    Pasien result = Pasien.fromJson(response.data);
    return result;
  }

  Future<Pasien> getPasienById(String id) async {
    final Response response = await ApiClient().get('pasien/$id');
    Pasien result = Pasien.fromJson(response.data);
    return result;
  }

  Future<Pasien> hapusPasien(Pasien pasien) async {
    final Response response =
        await ApiClient().delete('pasien/${pasien.id}', {});
    Pasien result = Pasien.fromJson(response.data);
    return result;
  }
}
