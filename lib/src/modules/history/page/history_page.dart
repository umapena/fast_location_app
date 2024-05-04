import 'package:fast_location_app/src/modules/history/controller/history_controller.dart';
import 'package:fast_location_app/src/modules/home/components/address_list.dart';
import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:fast_location_app/src/shared/components/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _controller.isLoading
          ? const AppLoading()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.appPageBackground,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: AppColors.appPageBackground,
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 25,
                        right: 25,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Histórico de endereços",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: AddressList(
                              addressList: _controller.addressHistoryList,
                            ),
                          ),
                        ],
                      )),
                )),
              ));
    });
  }
}
