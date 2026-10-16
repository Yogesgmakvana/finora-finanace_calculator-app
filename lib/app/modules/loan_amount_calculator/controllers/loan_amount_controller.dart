import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/calculator_models.dart';
import '../../../data/services/finance_calculator_service.dart';

class LoanAmountController extends GetxController {
  final FinanceCalculatorService _service = FinanceCalculatorService();

  final emiController = TextEditingController(text: '46000');
  final rateController = TextEditingController(text: '10');
  final tenureController = TextEditingController(text: '12');

  final RxBool isYears = false.obs;
  final Rxn<LoanAmountResult> result = Rxn<LoanAmountResult>();

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
    final double emi = double.tryParse(emiController.text) ?? 0;
    final double rate = double.tryParse(rateController.text) ?? 0;
    final int tenure = int.tryParse(tenureController.text) ?? 0;

    result.value = _service.calculateLoanAmount(
      monthlyEmi: emi,
      annualRate: rate,
      tenureValue: tenure,
      isYears: isYears.value,
    );
  }

  void clear() {
    emiController.clear();
    rateController.clear();
    tenureController.clear();
    result.value = null;
  }

  @override
  void onClose() {
    emiController.dispose();
    rateController.dispose();
    tenureController.dispose();
    super.onClose();
  }
}
