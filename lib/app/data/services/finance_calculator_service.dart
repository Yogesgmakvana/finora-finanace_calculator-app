import 'dart:math';
import '../models/calculator_models.dart';

class FinanceCalculatorService {
  /// EMI Calculation
  EmiResult calculateEmi({
    required double principal,
    required double annualRate,
    required int tenureValue,
    required bool isYears,
  }) {
    if (principal <= 0 || annualRate < 0 || tenureValue <= 0) {
      return EmiResult(
        monthlyEmi: 0,
        totalInterest: 0,
        totalPayment: 0,
        principal: principal,
        interestPercentage: 0,
        principalPercentage: 100,
        schedule: [],
      );
    }

    final int totalMonths = isYears ? tenureValue * 12 : tenureValue;
    final double monthlyRate = annualRate / (12 * 100);

    final double emi = monthlyRate == 0
        ? principal / totalMonths
        : (principal * monthlyRate * pow(1 + monthlyRate, totalMonths)) /
            (pow(1 + monthlyRate, totalMonths) - 1);

    final double totalPayment = emi * totalMonths;
    final double totalInterest = totalPayment - principal;

    final double interestPercent = (totalInterest / totalPayment) * 100;
    final double principalPercent = (principal / totalPayment) * 100;

    // Build Amortization Schedule
    final List<AmortizationScheduleItem> schedule = [];
    double remainingBalance = principal;

    for (int month = 1; month <= totalMonths; month++) {
      final double interestForMonth = remainingBalance * monthlyRate;
      final double principalForMonth = emi - interestForMonth;
      remainingBalance = max(0, remainingBalance - principalForMonth);

      schedule.add(
        AmortizationScheduleItem(
          period: month,
          principalPaid: principalForMonth,
          interestPaid: interestForMonth,
          totalPayment: emi,
          remainingBalance: remainingBalance,
        ),
      );
    }

    return EmiResult(
      monthlyEmi: emi,
      totalInterest: totalInterest,
      totalPayment: totalPayment,
      principal: principal,
      interestPercentage: interestPercent,
      principalPercentage: principalPercent,
      schedule: schedule,
    );
  }

  /// Loan Amount Estimator (Calculate max principal from EMI)
  LoanAmountResult calculateLoanAmount({
    required double monthlyEmi,
    required double annualRate,
    required int tenureValue,
    required bool isYears,
  }) {
    if (monthlyEmi <= 0 || annualRate < 0 || tenureValue <= 0) {
      return LoanAmountResult(
        maxLoanAmount: 0,
        totalInterest: 0,
        totalPayment: 0,
        monthlyEmi: monthlyEmi,
        interestPercentage: 0,
        principalPercentage: 100,
        schedule: [],
      );
    }

    final int totalMonths = isYears ? tenureValue * 12 : tenureValue;
    final double monthlyRate = annualRate / (12 * 100);

    final double principal = monthlyRate == 0
        ? monthlyEmi * totalMonths
        : (monthlyEmi * (pow(1 + monthlyRate, totalMonths) - 1)) /
            (monthlyRate * pow(1 + monthlyRate, totalMonths));

    final double totalPayment = monthlyEmi * totalMonths;
    final double totalInterest = totalPayment - principal;

    final double interestPercent = (totalInterest / totalPayment) * 100;
    final double principalPercent = (principal / totalPayment) * 100;

    // Amortization schedule
    final List<AmortizationScheduleItem> schedule = [];
    double remainingBalance = principal;

    for (int month = 1; month <= totalMonths; month++) {
      final double interestForMonth = remainingBalance * monthlyRate;
      final double principalForMonth = monthlyEmi - interestForMonth;
      remainingBalance = max(0, remainingBalance - principalForMonth);

      schedule.add(
        AmortizationScheduleItem(
          period: month,
          principalPaid: principalForMonth,
          interestPaid: interestForMonth,
          totalPayment: monthlyEmi,
          remainingBalance: remainingBalance,
        ),
      );
    }

    return LoanAmountResult(
      maxLoanAmount: principal,
      totalInterest: totalInterest,
      totalPayment: totalPayment,
      monthlyEmi: monthlyEmi,
      interestPercentage: interestPercent,
      principalPercentage: principalPercent,
      schedule: schedule,
    );
  }

  /// SIP Calculator
  SipResult calculateSip({
    required double monthlyInvestment,
    required double expectedRate,
    required int tenureValue,
    required bool isYears,
  }) {
    if (monthlyInvestment <= 0 || expectedRate < 0 || tenureValue <= 0) {
      return SipResult(
        totalInvestment: 0,
        totalInterest: 0,
        maturityAmount: 0,
        schedule: [],
      );
    }

    final int totalMonths = isYears ? tenureValue * 12 : tenureValue;
    final double monthlyRate = expectedRate / (12 * 100);

    final double maturityAmount = monthlyRate == 0
        ? monthlyInvestment * totalMonths
        : monthlyInvestment *
            ((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate) *
            (1 + monthlyRate);

    final double totalInvestment = monthlyInvestment * totalMonths;
    final double totalInterest = maturityAmount - totalInvestment;

    final List<AmortizationScheduleItem> schedule = [];
    double currentWealth = 0;

    for (int month = 1; month <= totalMonths; month++) {
      currentWealth = (currentWealth + monthlyInvestment) * (1 + monthlyRate);
      schedule.add(
        AmortizationScheduleItem(
          period: month,
          principalPaid: monthlyInvestment * month,
          interestPaid: currentWealth - (monthlyInvestment * month),
          totalPayment: monthlyInvestment * month,
          remainingBalance: currentWealth,
        ),
      );
    }

    return SipResult(
      totalInvestment: totalInvestment,
      totalInterest: totalInterest,
      maturityAmount: maturityAmount,
      schedule: schedule,
    );
  }

  /// GST Calculator
  GstResult calculateGst({
    required double amount,
    required double gstRate,
    required bool isAddGst,
  }) {
    if (amount <= 0 || gstRate < 0) {
      return GstResult(actualAmount: 0, gstAmount: 0, netPrice: 0);
    }

    if (isAddGst) {
      final double gstAmount = (amount * gstRate) / 100;
      final double netPrice = amount + gstAmount;
      return GstResult(
        actualAmount: amount,
        gstAmount: gstAmount,
        netPrice: netPrice,
      );
    } else {
      final double actualAmount = (amount * 100) / (100 + gstRate);
      final double gstAmount = amount - actualAmount;
      return GstResult(
        actualAmount: actualAmount,
        gstAmount: gstAmount,
        netPrice: amount,
      );
    }
  }

  /// Simple & Compound Interest
  InterestResult calculateInterest({
    required double depositAmount,
    required double annualRate,
    required int tenureValue,
    required bool isYears,
  }) {
    if (depositAmount <= 0 || annualRate < 0 || tenureValue <= 0) {
      return InterestResult(totalInvestment: 0, totalInterest: 0, maturityAmount: 0);
    }

    final double years = isYears ? tenureValue.toDouble() : tenureValue / 12.0;
    final double maturityAmount = depositAmount * pow(1 + (annualRate / 100), years);
    final double totalInterest = maturityAmount - depositAmount;

    return InterestResult(
      totalInvestment: depositAmount,
      totalInterest: totalInterest,
      maturityAmount: maturityAmount,
    );
  }
}
