import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/modules/address/models/address_model.dart';
import 'package:platform/platform.dart';

class AddressDetailPage extends StatefulWidget {
  Data? data;
  @override
  State<StatefulWidget> createState() {
    return _AddressDetailPageState();
  }
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  Data? data;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _townController = TextEditingController();
  String? _type;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    if (data != null) {
      _addressController.text = data!.address!;
      _townController.text = data!.town!;
      _type = data!.type;
      _latitude = data!.latitude;
      _longitude = data!.longitude;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Form(
          child: ListView(
            children: [
              SizedBox(height: 20),
              Text(
                widget.data == null ? "Tambah Data" : "Ubah Data",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormComponent(
                Icons.share_location_rounded,
                "Alamat anda",
                "Alamat",
                false,
                _addressController,
                TextInputType.name,
              ),
              SizedBox(height: 20),
              TextFormComponent(
                Icons.location_city,
                "Kota anda",
                "Kota",
                false,
                _townController,
                TextInputType.name,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Platform.iOS == true
                    ? CupertinoButton(
                        child: Text(_type ?? "Pilih Tipe"),
                        onPressed: () => _showActionSheet(context),
                      )
                    : DropdownButton(
                        hint: Text("Pilih Tipe Alamat"),
                        items: _dropDownItem,
                        value: _type,
                        onChanged: _dropdownChange,
                      ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: BoxBorder.all(color: Colors.black, strokeAlign: 1),
                ),
              ),
              ListTile(
                leading: Icon(Icons.gps_fixed),
                title: Text("${_latitude} - ${_longitude}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showActionSheet(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text("Pilih Tipe Alamat"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _type = "Rumah";
              });
            },
            child: Text("Rumah"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _type = "Kos";
              });
            },
            child: Text("Kos"),
          ),
        ],
      ),
    );
  }

  _dropdownChange(value) {
    setState(() {
      _type = value;
    });
  }

  final List<DropdownMenuItem> _dropDownItem = [
    DropdownMenuItem(child: Text("Rumah"), value: "Rumah"),
    DropdownMenuItem(child: Text("Kos"), value: "Kos"),
  ];
}
