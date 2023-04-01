// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:benchmark_encrypt_decrypt/models/benchmark_data.dart';
import 'package:flutter/foundation.dart';

import '../services/get_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/intern_position.dart';
import '../storage/storage_manager.dart';
import 'package:collection/collection.dart';

class HomePageController extends GetxController {
  final _storageManager = StorageManager();
  final _apiService = ApiService();
  var isLoading = false;

  List<BenchmarkData> listDataWrite = [];
  List<BenchmarkData> listDataWriteEncrypted = [];
  List<BenchmarkData> listDataRead = [];
  List<BenchmarkData> listDataReadEncrypted = [];

  var maxWriteValue = 0.0;
  var maxReadValue = 0.0;

  double get avgWrite => listDataWrite.map((e) => e.result).average;
  double get avgWriteE => listDataWriteEncrypted.map((e) => e.result).average;

  double get avgRead => listDataRead.map((e) => e.result).average;
  double get avgReadE => listDataReadEncrypted.map((e) => e.result).average;

  Function deepEq = const DeepCollectionEquality().equals;

  Future<void> startBenchmark() async {
    isLoading = true;
    update();

    await Future.delayed(const Duration(milliseconds: 250));
    await _storageManager.deleteAll();
    clearDataBenchmark();

    final listInternPos = await _apiService.getData();

    //* =============================== WRITE ===============================
    for (var i = 0; i < 5; i++) {
      //! NOT ENCRYPTED
      final sw1 = Stopwatch()..start();
      await _storageManager.saveData(
        i.toString(),
        json.encode(listInternPos),
      );
      sw1.stop();

      listDataWrite.add(
        BenchmarkData("Test ${i + 1}", (sw1.elapsedMicroseconds / 1000.0)),
      );

      //! ENCRYPTED
      final sw2 = Stopwatch()..start();
      await _storageManager.saveDataEncrypt(
        i.toString(),
        json.encode(listInternPos),
      );
      sw2.stop();

      listDataWriteEncrypted.add(
        BenchmarkData("Test ${i + 1}", (sw2.elapsedMicroseconds / 1000.0)),
      );

      await Future.delayed(const Duration(milliseconds: 250));
    }

    //* ================================ READ ================================
    for (var i = 0; i < 5; i++) {
      //! NOT ENCRYPTED
      final sw1 = Stopwatch()..start();
      final cache1 = _storageManager.getData(i.toString());
      sw1.stop();

      if (i == 0) {
        final data1 = List<InternPosition>.from(
          json.decode(cache1).map((x) => InternPosition.fromJson(x)),
        );

        debugPrint(
          'Data equal: ${deepEq(listInternPos, data1).toString()}',
        );
      }

      listDataRead.add(
        BenchmarkData("Test ${i + 1}", (sw1.elapsedMicroseconds / 1000.0)),
      );

      //! ENCRYPTED
      final sw2 = Stopwatch()..start();
      final cache2 = _storageManager.getDataEncrypt(i.toString());
      sw2.stop();

      if (i == 0) {
        final data2 = List<InternPosition>.from(
          json.decode(cache2).map((x) => InternPosition.fromJson(x)),
        );

        debugPrint(
          'Data encrypted equal: ${deepEq(listInternPos, data2).toString()}',
        );
      }

      listDataReadEncrypted.add(
        BenchmarkData("Test ${i + 1}", (sw2.elapsedMicroseconds / 1000.0)),
      );

      await Future.delayed(const Duration(milliseconds: 250));
    }

    debugPrint("\nWRITE: ");
    debugPrint("Not Encrypted: $listDataWrite");
    debugPrint("Encrypted: $listDataWriteEncrypted");

    debugPrint("\nREAD: ");
    debugPrint("Not Encrypted: $listDataRead");
    debugPrint("Encrypted: $listDataReadEncrypted");

    final max1 = listDataWrite.reduce(
      (a, b) => a.result > b.result ? a : b,
    );
    final max2 = listDataWriteEncrypted.reduce(
      (a, b) => a.result > b.result ? a : b,
    );
    maxWriteValue = (max1.result > max2.result) ? max1.result : max2.result;

    final max3 = listDataRead.reduce(
      (a, b) => a.result > b.result ? a : b,
    );
    final max4 = listDataReadEncrypted.reduce(
      (a, b) => a.result > b.result ? a : b,
    );
    maxReadValue = (max3.result > max4.result) ? max3.result : max4.result;

    isLoading = false;
    update();
  }

  void clearDataBenchmark() {
    listDataWrite.clear();
    listDataWriteEncrypted.clear();
    listDataRead.clear();
    listDataReadEncrypted.clear();
  }
}
