class Pegawai {
  int id;
  String nip, nama, tanggal_lahir, nomor_telepon, email, password;

  Pegawai(
      {required this.id,
      required this.nip,
      required this.nama,
      required this.tanggal_lahir,
      required this.nomor_telepon,
      required this.email,
      required this.password});
  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
        id: json['id'],
        nip: json['nip'],
        nama: json['nama'],
        tanggal_lahir: json['tanggal_lahir'],
        nomor_telepon: json['nomor_telepon'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "nama": nama,
        "tanggal_lahir": tanggal_lahir,
        "nomor_telepon": nomor_telepon,
        "email": email,
        "password": password
      };
}

class Pasien {
  int id;
  String nomor_rm, nama, tanggal_lahir, nomor_telepon, alamat;

  Pasien(
      {required this.id,
      required this.nomor_rm,
      required this.nama,
      required this.tanggal_lahir,
      required this.nomor_telepon,
      required this.alamat});
  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
        id: json['id'],
        nomor_rm: json['nomor_rm'],
        nama: json['nama'],
        tanggal_lahir: json['tanggal_lahir'],
        nomor_telepon: json['nomor_telepon'],
        alamat: json['alamat']);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_rm": nomor_rm,
        "nama": nama,
        "tanggal_lahir": tanggal_lahir,
        "nomor_telepon": nomor_telepon,
        "alamat": alamat
      };
}
