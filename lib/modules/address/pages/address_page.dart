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
    _indexPage = 1;
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

  _onRefresh() {
    _appendData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Alamat"), centerTitle: true),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: _addressList!.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsetsGeometry.fromLTRB(5, 0, 5, 0),
            child: Card(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Text(_addressList![index]!.address!),
                    Text(_addressList![index]!.town!),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _addressList![index]!.latitude!.toString(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _addressList![index]!.longitude!.toString(),textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onRefresh: () => _onRefresh(),
      ),
    );
  }
}
