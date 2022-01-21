class Kategori {
  int id;
  String kategoriAdi;

  Kategori({
    required this.id,
    required this.kategoriAdi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategoriAdi': kategoriAdi,
    };
  }
}
