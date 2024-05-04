import 'package:fast_location_app/src/modules/home/model/address_model.dart';
import 'package:fast_location_app/src/modules/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  
  final HomeService _service;
  _HomeController({HomeService? service}) : _service = service ?? HomeService();

  @observable
  bool isLoading = false;

  @observable
  bool hasAddress = false;

  @observable
  List<AddressModel> addressList = [];

  @observable
  AddressModel? lastAddress;

  @observable
  bool hasError = false;

  @action
  Future<void> loadData() async {
    isLoading = true;
    addressList = await _service.getAddressList();
    isLoading = false;
  }

  @action
  Future<void> getAddress(String cep) async {
    try {
      isLoading = true;
      lastAddress = await _service.getAddress(cep);
      await updateAddress(lastAddress!);
      await addAddress(lastAddress!);
      isLoading = false;
      hasAddress = true;
    } catch (ex) {
      isLoading = false;
      hasError = true;
      debugPrint("HomeController.getAddress -> ${ex.toString()}");
    }
  }

    @action
  Future<void> addAddress(AddressModel address) async {
    await _service.addAddressList(address);
  }

  @action
  Future<void> updateAddress(AddressModel address) async {
    await _service.updateAddressList(address);
    addressList = await _service.getAddressList();
  }

}