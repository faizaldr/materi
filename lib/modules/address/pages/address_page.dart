import 'package:flutter/material.dart';
import 'package:materi/modules/address/data/address_service.dart';
import 'package:materi/modules/address/models/address_model.dart';
import 'package:materi/utils/message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int _indexPage = 1;
  int _maxIndexPage = 1; // pastikan ini total halaman (pageCount), bukan pageSize
  final List<Data> _addressList = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    _indexPage = 1;
    try {
      final result = await actionGetAddressService(_indexPage);
      if (!mounted || result == null) return;
      setState(() {
        _addressList
          ..clear()
          ..addAll(result.data ?? []);
        // Sesuaikan dengan struktur meta API kamu:
        _maxIndexPage = result.meta?.pagination?.pageCount ??
                        result.meta?.pagination?.page ??
                        1;
      });
    } catch (e) {
      if (mounted) Message.errorMessage(context, "Gagal memuat data");
    }
  }

  // ============== PULL-DOWN (REFRESH DARI ATAS) ==============
  Future<void> _onPullDown() async {
    try {
      await _loadFirstPage();
      _refreshController.refreshCompleted(); // akhiri animasi refresh
      // Jika masih ada halaman selanjutnya, reset footer agar bisa load lagi
      _refreshController.resetNoData();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  // ============== PULL-UP (LOAD MORE DARI BAWAH) ==============
  Future<void> _onPullUp() async {
    // Habis? tandai footer no data
    if (_indexPage >= _maxIndexPage) {
      _refreshController.loadNoData();
      Message.errorMessage(context, "Data sudah habis");
      return;
    }

    try {
      _indexPage++;
      final result = await actionGetAddressService(_indexPage);
      if (!mounted || result == null) {
        _refreshController.loadFailed();
        return;
      }
      setState(() {
        _addressList.addAll(result.data ?? []);
      });

      if (_indexPage >= _maxIndexPage) {
        _refreshController.loadNoData(); // tidak ada halaman lagi
      } else {
        _refreshController.loadComplete(); // sukses, masih bisa load lagi
      }
    } catch (e) {
      _refreshController.loadFailed();
      if (mounted) {
        _indexPage = (_indexPage > 1) ? _indexPage - 1 : 1; // rollback jika gagal
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Alamat"), centerTitle: true),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,   // ← aktifkan pull-down (refresh)
        enablePullUp: true,     // ← aktifkan pull-up (load more)
        onRefresh: _onPullDown, // ← ini PULL DOWN
        onLoading: _onPullUp,   // ← ini PULL UP
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _addressList.length,
          itemBuilder: (context, index) {
            final item = _addressList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.address ?? "-", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(item.town ?? "-"),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: Text(item.latitude?.toString() ?? "-")),
                          Expanded(
                            child: Text(item.longitude?.toString() ?? "-", textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
