import 'package:flutter/material.dart';
import 'package:materi/modules/address/data/address_service.dart';
import 'package:materi/modules/address/models/address_model.dart';
import 'package:materi/modules/address/pages/address_detail_page.dart';
import 'package:materi/utils/message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int _indexPage = 1;
  int _maxIndexPage = 1;
  final List<Data> _addressList = [];

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

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
        _maxIndexPage =
            result.meta?.pagination?.pageCount ??
            result.meta?.pagination?.page ??
            1;
      });
    } catch (e) {
      if (mounted) Message.errorMessage(context, "Gagal memuat data");
    }
  }

  Future<void> _onPullDown() async {
    try {
      await _loadFirstPage();
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> _onPullUp() async {
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
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    } catch (e) {
      _refreshController.loadFailed();
      if (mounted) {
        _indexPage = (_indexPage > 1) ? _indexPage - 1 : 1;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddressDetailPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 20, child: Text("$_indexPage/$_maxIndexPage")),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onPullDown,
              onLoading: _onPullUp,
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return SizedBox(height: 55.0, child: Center(child: body));
                },
              ),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _addressList.length,
                itemBuilder: (context, index) {
                  final item = _addressList[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddressDetailPage(data: item),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.address ?? "-",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(item.town ?? "-"),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.latitude?.toString() ?? "-",
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.longitude?.toString() ?? "-",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
