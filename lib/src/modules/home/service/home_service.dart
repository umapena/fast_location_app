import 'package:dio/dio.dart';
import 'package:fast_location_app/src/modules/home/model/address_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/home_local_repository.dart';
import 'package:fast_location_app/src/modules/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';

class HomeService {
  final HomeRepository repository = HomeRepository();
  final HomeLocalRepository localRepository = HomeLocalRepository();

  Future<AddressModel> getAddress(String cep) async {
    try {
      Response response = await repository.getAddress(cep);
      return AddressModel.fromJson(response.data);
    } catch (ex) {
      debugPrint('HomeService.getAddress -> ${ex.toString()}');
      rethrow;
    }
  }

  Future<List<AddressModel>> getAddressList() async {
    try {
      List<AddressModel>? addressRecentList = await localRepository.getAddressRecent();
      return addressRecentList ?? <AddressModel>[];
    } catch (ex) {
      debugPrint('HomeService.getAddressRecentList -> ${ex.toString()}');
      rethrow;
    }
  }

  Future<void> addAddressList(AddressModel address) async {
    await localRepository.addAddressHistory(address);
  }

  Future<void> updateAddressList(AddressModel address) async {
    await localRepository.addAddressRecent(address);
  }

  Future<List<AddressModel>> getAddressHistoryList() async {
    try {
      List<AddressModel>? addressHistoryList = await localRepository.getAddressHistory();
      return addressHistoryList ?? <AddressModel>[];
      
    } catch (ex) {
      debugPrint('HomeService.getAddressHistoryList -> ${ex.toString()}');
      rethrow;
    }
  }

}