import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fast_location_app/src/shared/components/app_button.dart';
import 'package:fast_location_app/src/shared/components/app_loading.dart';
import 'package:fast_location_app/src/routes/app_router.dart';
import 'package:fast_location_app/src/modules/home/components/search_address.dart';
import 'package:fast_location_app/src/modules/home/components/search_empty.dart';
import 'package:fast_location_app/src/modules/home/components/address_list.dart';
import 'package:fast_location_app/src/modules/home/controller/home_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeController controller = HomeController();
  TextEditingController searchController = TextEditingController();

  late ReactionDisposer errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addressNotFound();
  }

  @override
  void dispose() {
    searchController.dispose();
    errorReactionDisposer();
    super.dispose();
  }

  void addressNotFound() {
    errorReactionDisposer = reaction(
      (_) => controller.hasError,
      (bool error) {
        if (error) dialogAddressNotFound("Endereço não encontrado!");
        controller.hasError = false;
      },
    );
  }

  void dialogAddressNotFound(String info) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    info,
                    style: const TextStyle(fontSize: 18)
                  ),
                ),
                AppButton(
                  label: "Fechar",
                  action: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return controller.isLoading
          ? const AppLoading()
          : Scaffold(
              backgroundColor: AppColors.appPageBackground,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(                        
			                  top: 20,
                        left: 25,
                        right: 25
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.multiple_stop,
                                color: Colors.green,
                                size: 40,
                              ),
                              Text("Fast Location",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                              Padding(
                                padding: EdgeInsets.only(right: 70),
                              ),
                              Icon(
                                Icons.login,
                                color: Colors.green,
                                size: 35,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 216, 216, 216)),
                              child: Center(
                                child: Padding(
                                  padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                  child: controller.hasAddress 
                                    ? SearchAddress(address: controller.lastAddress!)
                                    : const SearchEmpty()
                              )),
                            ),
                          ),
                          AppButton(
                            label: "Localizar endereço",
                            action: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 130,
                                        child: Column(children: [
                                          TextFormField(
                                            enabled: true,
                                            keyboardType: TextInputType.number,
                                            controller: searchController,
                                            decoration: const InputDecoration(
                                              labelText: "Digite o CEP:",
                                              labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                                              //hintText: 'Formato: 00000000',
                                            )
                                          ),
                                          const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                                          AppButton(
                                            label: "Buscar",
                                            action: () {
                                              controller.getAddress(searchController.text);
                                              Navigator.of(context).pop();
                                              searchController.text = '';
                                            },
                                          ),
                                        ]),
                                      ),
                                    );
                                  });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text("Últimos endereços",
                                    style: TextStyle(
                                        fontSize: 20,
					                              fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AddressList(
                              addressList: controller.addressList,
                            ),
                          ),
                          AppButton(
                            label: "Histórico",
                            action: () {
                              Navigator.of(context).pushNamed(AppRouter.history);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(height: 20)
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.green,
                shape: const CircleBorder(),
                child: const Icon(Icons.fork_right, size: 40, color: Colors.white),
                onPressed: () => {},
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            );
    });
  }
}