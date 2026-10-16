import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/calculator_models.dart';
import '../../../data/services/finance_calculator_service.dart';

class EmiCalculatorController extends GetxController {
  final FinanceCalculatorService _service = FinanceCalculatorService();

  final principalController = TextEditingController(text: '100000');
  final rateController = TextEditingController(text: '10');
  final tenureController = TextEditingController(text: '12');

  final RxBool isYears = false.obs; // Months as per default in screenshot 2 (12 M)
  final Rxn<EmiResult> result = Rxn<EmiResult>();

  final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
  final currencyFormatterShort = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

  @override
  void onInit() {
    super.onInit();
    calculate();
  }

  void toggleTenure(bool isYear) {
    isYears.value = isYear;
    calculate();
  }

  void calculate() {
    final double principal = double.tryParse(principalController.text) ?? 0;
    final double rate = double.tryParse(rateController.text) ?? 0;
    final int tenure = int.tryParse(tenureController.text) ?? 0;

    result.value = _service.calculateEmi(
      principal: principal,
      annualRate: rate,
      tenureValue: tenure,
      isYears: isYears.value,
    );
  }

  void clear() {
    principalController.clear();
    rateController.clear();
    tenureController.clear();
    result.value = null;
  }

  @override
  void onClose() {
    principalController.dispose();
    rateController.dispose();
    tenureController.dispose();
    super.onClose();
  }
}
