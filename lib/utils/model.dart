class MakananModel {
  final String id;
  final String nama_makanan;
  final String harga;
  final String deskripsi;
  final String imageurl;

  MakananModel(
      {required this.id,
      required this.nama_makanan,
      required this.harga,
      required this.deskripsi,
      required this.imageurl});

  factory MakananModel.fromJson(Map<String, dynamic> data) {
    return MakananModel(
        id: data['_id'],
        nama_makanan: data['nama_makanan'],
        harga: data['harga'],
        deskripsi: data['deskripsi'],
        imageurl: data['imageurl']);
  }
}