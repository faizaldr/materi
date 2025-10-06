import "package:flutter/material.dart";
String tes="ini teks";
// diluar scope harus berupa deklaratif
//tes = "ini berubah";

void main(){
  String nama = "Badu Yulianto";
  int usia = 25;
  double gaji = 5_570_000.0;
  bool aktif = true;

  // null value :
  String? pekerjaan; // (?) nullable dari fitur null safety flutter
  // late, terlambah inisialisasi nilai 
  late String jabatan;
  jabatan = "Manager";
  
  // var, nullable, deklarasi variabel dengan tipe data menyesuaikan inisialisasi pertamanya
  var golongan;
  golongan = "IIIa";
  // fitur auto convert pada var
  golongan = 1;
  print(golongan.runtimeType);
  print(tes);
  print(nama);
  print(usia);
  print(gaji);
  print(aktif);
  debugPrint(nama);
  print(pekerjaan);
  print(jabatan);
}