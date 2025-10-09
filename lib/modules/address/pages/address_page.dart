import 'package:flutter/material.dart';
import 'package:materi/modules/address/data/address_service.dart';
import 'package:materi/modules/address/models/address_model.dart';

class AddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressPageState();
  }
}

class _AddressPageState extends State<AddressPage> {
  int _indexPage = 1;
  Future<Data?>? _future;

  @override
  void initState() {
    super.initState();
  }

  void _initData() {
    setState(() {
      _future = actionGetAddressService(_indexPage);
    });
  }

  void _

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Alamat"), centerTitle: true),
      // body: ,
    );
  }
}
