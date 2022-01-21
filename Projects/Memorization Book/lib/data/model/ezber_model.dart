class Ezber {
  int id, kategoriId, ezberlendi;
  String ezber, anlam;

  Ezber({
    required this.id,
    required this.kategoriId,
    required this.ezberlendi,
    required this.ezber,
    required this.anlam,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategoriId': kategoriId,
      'ezberlendi': ezberlendi,
      'ezber': ezber,
      'anlam': anlam,
    };
  }
}
