// ignore_for_file: non_constant_identifier_names

class ListNews {
  const ListNews(
    this.id_berita,
    this.slug,
    this.gambar,
    this.judul,
    this.caption,
    this.tag,
    this.tanggal,
    this.kategori,
    this.detail,
  );
  final String id_berita;
  final String slug;
  final String gambar;
  final String judul;
  final String tag;
  final String caption;
  final String tanggal;
  final String kategori;
  final String detail;
}

class DetailNews {
  const DetailNews(
    this.id_berita,
    this.slug,
    this.gambar,
    this.judul,
    this.caption,
    this.tag,
    this.tanggal,
    this.kategori,
    this.content,
  );
  final String id_berita;
  final String slug;
  final String gambar;
  final String judul;
  final String tag;
  final String caption;
  final String tanggal;
  final String kategori;
  final String content;
}
