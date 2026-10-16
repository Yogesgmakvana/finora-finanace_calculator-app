class EmiResult {
  final double monthlyEmi;
  final double totalInterest;
  final double totalPayment;
  final double principal;
  final double interestPercentage;
  final double principalPercentage;
  final List<AmortizationScheduleItem> schedule;

  EmiResult({
    required this.monthlyEmi,
    required this.totalInterest,
    required this.totalPayment,
    required this.principal,
    required this.interestPercentage,
    required this.principalPercentage,
    required this.schedule,
  });
}

class LoanAmountResult {
  final double maxLoanAmount;
  final double totalInterest;
  final double totalPayment;
  final double monthlyEmi;
  final double interestPercentage;
  final double principalPercentage;
  final List<AmortizationScheduleItem> schedule;

  LoanAmountResult({
    required this.maxLoanAmount,
    required this.totalInterest,
    required this.totalPayment,
    required this.monthlyEmi,
    required this.interestPercentage,
    required this.principalPercentage,
    required this.schedule,
  });
}

class SipResult {
  final double totalInvestment;
  final double totalInterest;
  final double maturityAmount;
  final List<AmortizationScheduleItem> schedule;

  SipResult({
    required this.totalInvestment,
    required this.totalInterest,
    required this.maturityAmount,
    required this.schedule,
  });
}

class GstResult {
  final double actualAmount;
  final double gstAmount;
  final double netPrice;

  GstResult({
    required this.actualAmount,
    required this.gstAmount,
    required this.netPrice,
  });
}

class InterestResult {
  final double totalInvestment;
  final double totalInterest;
  final double maturityAmount;

  InterestResult({
    required this.totalInvestment,
    required this.totalInterest,
    required this.maturityAmount,
  });
}

class AmortizationScheduleItem {
  final int period; // Year or Month
  final double principalPaid;
  final double interestPaid;
  final double totalPayment;
  final double remainingBalance;

  AmortizationScheduleItem({
    required this.period,
    required this.principalPaid,
    required this.interestPaid,
    required this.totalPayment,
    required this.remainingBalance,
  });
}
