import 'package:flutter/material.dart';
import 'package:materi/modules/address/models/address_model.dart';

class AddressDetailPage extends StatefulWidget {
  Data? data;
  @override
  State<StatefulWidget> createState() {
    return _AddressDetailPageState();
  }
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Text(widget.data != null ? "Tambah Data" : "Ubah Data")],
      ),
    );
  }
}
