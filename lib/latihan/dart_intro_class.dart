import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pegawai {
  late String nama;
  late int usia;
  String? email;

  // Pegawai(String nama, int usia, String? email){
  //   this.nama = nama;
  //   this.usia = usia;
  //   this.email = email;
  // }

  // required, wajib diisi
  Pegawai(this.nama, this.usia, {/*required*/ this.email});

  String teks() {
    return "Halo, ${nama}";
  }
}

String teks() {
  return "Halo";
}

Widget myButton(){
  return ElevatedButton(onPressed: (){}, child: Text("Klik"));
}

void main() {
  // var newPegawai = Pegawai("Badu", 21, "badu@gmail.com");
  var newPegawai = Pegawai("Badu", 21, email: "badu@gmail.com");

  print(newPegawai.nama);
  print(newPegawai.teks());
  // aplikasi UI mulai dari runApp
  runApp(MaterialApp(home: Scaffold(body: myButton(),),));
}
