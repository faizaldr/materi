class ApiModel {
  String? status;
  List<Data>? data;

  ApiModel({this.status, this.data});

  ApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? lat;
  String? lon;
  String? nama;
  String? keterangan;
  String? kontributor;
  String? aksi;

  Data({
    this.id,
    this.lat,
    this.lon,
    this.nama,
    this.keterangan,
    this.kontributor,
    this.aksi,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    nama = json['nama'];
    keterangan = json['keterangan'];
    kontributor = json['kontributor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    if (this.lat != null) data['lat'] = this.lat;
    if (this.lon != null) data['lon'] = this.lon;
    if (this.nama != null) data['nama'] = this.nama;
    if (this.keterangan != null) data['keterangan'] = this.keterangan;
    if (this.kontributor != null) data['kontributor'] = this.kontributor;
    if (this.aksi != null) data['aksi'] = this.aksi;
    return data;
  }
}
