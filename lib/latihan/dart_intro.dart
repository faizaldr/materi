import "package:flutter/material.dart";
String tes="ini teks";
// diluar scope harus berupa deklaratif
//tes = "ini berubah";

void main(){
  String nama = "Badu Yulianto";
  int usia = 25;
  double gaji = 5_570_000.0;
  bool aktif = true;

  print(tes);
  print(nama);
  print(usia);
  print(gaji);
  print(aktif);
  debugPrint(nama);
}