import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/modules/tracking/data/tracking_service.dart';
import 'package:materi/modules/tracking/data/location_service.dart';
import 'package:materi/modules/tracking/models/tracking_model.dart';
import 'package:materi/utils/message.dart';
import 'package:platform/platform.dart';
import 'package:provider/provider.dart';

class TrackingDetailPage extends StatefulWidget {
  Data? data;
  TrackingDetailPage({this.data, Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TrackingDetailPageState();
  }
}

class _TrackingDetailPageState extends State<TrackingDetailPage> {
  Data? data;
  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _placeTypeController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  double? _latitude;
  double? _longitude;
  LocationService? locationService;

  @override
  void initState() {
    super.initState();
    data = widget.data ?? new Data();
    print(data);
    locationService = LocationService();
    if (data?.id != null) {
      _placeNameController.text = data?.placeName! ?? "";
      _placeTypeController.text = data?.placeType ?? "";
      _commentController.text = data?.comment! ?? "";
      _latitude = data?.latitude ?? 0.0;
      _longitude = data?.longitude ?? 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<LatLon>(
      create: (context) => locationService!.locationStream,
      initialData: LatLon(0.0, 0.0),
      child: Scaffold(
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
                  Icons.place,
                  "Nama Lokasi tujuan",
                  "Lokasi",
                  false,
                  _placeNameController,
                  TextInputType.name,
                ),
                SizedBox(height: 20),
                TextFormComponent(
                  Icons.multitrack_audio,
                  "Tipe Lokasi tujuan",
                  "Tipe",
                  false,
                  _placeTypeController,
                  TextInputType.name,
                ),
                SizedBox(height: 20),
                TextFormComponent(
                  Icons.comment,
                  "Komentar anda",
                  "Komentar",
                  false,
                  _commentController,
                  TextInputType.name,
                ),
                Builder(
                  builder: (context) {
                    final latlon = context.watch<LatLon>();
                    _latitude = latlon.latitude;
                    _longitude = latlon.longitude;
                    return ListTile(
                      leading: Icon(Icons.gps_fixed),
                      title: Text("${latlon.latitude} | ${latlon.longitude}"),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: _actionSaveAddress,
                  child: Text("Simpan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _actionSaveAddress() async {
    data!.placeName = _placeNameController.text;
    data!.comment = _commentController.text;
    data!.placeType = _placeTypeController.text;
    data!.latitude = _latitude;
    data!.longitude = _longitude;

    bool result = true;
    if (data!.id == null) {
      result = await actionSaveAddressService(data!);
    } else {
      result = await actionSaveAddressService(data!, isInsert: false);
    }
    result
        ? Message.successMessage(context, "Berhasil")
        : Message.errorMessage(context, "Gagal");
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
                _placeTypeController.text = "Rumah";
              });
            },
            child: Text("Rumah"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _placeTypeController.text = "Kos";
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
      _placeTypeController = value;
    });
  }

  final List<DropdownMenuItem> _dropDownItem = [
    DropdownMenuItem(child: Text("Rumah"), value: "Rumah"),
    DropdownMenuItem(child: Text("Kos"), value: "Kos"),
  ];
}
