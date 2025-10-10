class TrackingModel {
  List<Data>? data;
  Meta? meta;

  TrackingModel({this.data, this.meta});

  TrackingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? documentId;
  String? placeName;
  String? placeType;
  String? comment;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Data(
      {this.id,
      this.documentId,
      this.placeName,
      this.placeType,
      this.comment,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentId = json['documentId'];
    placeName = json['placeName'];
    placeType = json['placeType'];
    comment = json['comment'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.placeName != null) data['placeName'] = this.placeName;
    if(this.placeType != null) data['placeType'] = this.placeType;
    if(this.comment != null) data['comment'] = this.comment;
    if(this.latitude != null) data['latitude'] = this.latitude;
    if(this.longitude != null) data['longitude'] = this.longitude;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}
