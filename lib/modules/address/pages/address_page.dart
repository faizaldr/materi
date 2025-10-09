import 'package:flutter/material.dart';
import 'package:materi/modules/address/data/address_service.dart';
import 'package:materi/modules/address/models/address_model.dart';
import 'package:materi/utils/message.dart';

class AddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressPageState();
  }
}

class _AddressPageState extends State<AddressPage> {
  int _indexPage = 1;
  int _maxIndexPage = 1;
  List<Data>? _addressList = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final result = await actionGetAddressService(_indexPage);
    if (result != null)
      setState(() {
        _addressList!.addAll(result.data!.toList());
        _maxIndexPage = result.meta!.pagination!.pageSize!;
      });
  }

  void _appendData(context) async {
    if (_indexPage < _maxIndexPage) {
      _indexPage++;
      final result = await actionGetAddressService(_indexPage);
      if (result != null)
        setState(() {
          _addressList!.addAll(result.data!.toList());
        });
    } else {
      Message.errorMessage(context, "Data sudah habis");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Alamat"), centerTitle: true),
      // body: ,
    );
  }
}
