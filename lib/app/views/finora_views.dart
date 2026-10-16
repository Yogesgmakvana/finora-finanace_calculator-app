import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/calculator_models.dart';
import '../data/services/finance_calculator_service.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/circular_percentage_gauge.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_card.dart';
import '../widgets/neo_input_field.dart';
import '../widgets/neo_top_pill.dart';

class CalculatorInfo {
  final String title, route, description;
  final IconData icon;
  final Color color;
  const CalculatorInfo(this.title, this.route, this.description, this.icon, this.color);
}

const calculatorItems = <CalculatorInfo>[
  CalculatorInfo('EMI Calculator', Routes.EMI_CALCULATOR, 'Plan your monthly loan payments', Icons.calculate_outlined, AppColors.iconGreen),
  CalculatorInfo('Smart Loan', Routes.LOAN_AMOUNT_CALCULATOR, 'Estimate your eligible loan', Icons.account_balance_outlined, AppColors.iconYellow),
  CalculatorInfo('Compare Loans', Routes.COMPARE_LOANS, 'Compare payments side by side', Icons.compare_arrows, AppColors.iconPurple),
  CalculatorInfo('GST Calculator', Routes.GST_CALCULATOR, 'Add or remove tax in seconds', Icons.receipt_long_outlined, AppColors.iconOrange),
  CalculatorInfo('SIP Calculator', Routes.SIP_CALCULATOR, 'See how investments can grow', Icons.trending_up, AppColors.iconBlue),
  CalculatorInfo('SWP Calculator', Routes.SIP_CALCULATOR, 'Plan systematic withdrawals', Icons.savings_outlined, AppColors.iconTeal),
  CalculatorInfo('FD Calculator', Routes.INTEREST_CALCULATOR, 'Estimate fixed deposit returns', Icons.lock_clock, AppColors.iconCoral),
  CalculatorInfo('Lumpsum', Routes.INTEREST_CALCULATOR, 'Project a one-time investment', Icons.paid_outlined, AppColors.iconPlum),
  CalculatorInfo('PPF Calculator', Routes.INTEREST_CALCULATOR, 'Plan long-term savings', Icons.account_balance_wallet_outlined, AppColors.iconSand),
  CalculatorInfo('Cash Calculator', Routes.CASH_CALCULATOR, 'Count notes and cash totals', Icons.payments_outlined, AppColors.iconTeal),
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
              sliver: SliverList.list(children: [
                Row(children: [
                  Container(width: 46, height: 46, decoration: BoxDecoration(color: AppColors.btnEmeraldGreen, border: Border.all(width: 2), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.currency_exchange, size: 27)),
                  const SizedBox(width: 12),
                  const Text('finora', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -1)),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
                ]),
                const SizedBox(height: 25),
                const Text('FINANCE', style: TextStyle(fontSize: 13, letterSpacing: 3, fontWeight: FontWeight.w800)),
                const SizedBox(height: 5),
                const Text('Make your money\nmake sense.', style: TextStyle(fontSize: 34, height: 1.08, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                Text('Fast, accurate calculations for loans, investments & taxes.', style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black.withValues(alpha: .68))),
                const SizedBox(height: 22),
                NeoCard(backgroundColor: const Color(0xFF171717), padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('YOUR FINANCE TOOLKIT', style: TextStyle(color: Color(0xFFB8F2C4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  const SizedBox(height: 12),
                  const Text('Finance\nCalculator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 29, height: 1.02)),
                  const SizedBox(height: 8),
                  const Text('Clear answers for every money decision.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 18),
                  NeoButton(text: 'Explore calculators', icon: Icons.arrow_forward_rounded, backgroundColor: AppColors.btnEmeraldGreen, onTap: () => Get.toNamed(Routes.FINANCE_HUB)),
                ])),
                const SizedBox(height: 25),
                const _SectionHeading(title: 'Popular calculators', action: 'View all', route: Routes.FINANCE_HUB),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.23),
                  itemBuilder: (_, i) => _CalculatorTile(item: calculatorItems[i]),
                ),
                const SizedBox(height: 22),
                const _SectionHeading(title: 'Smart money tips'),
                const SizedBox(height: 10),
                const NeoCard(backgroundColor: Color(0xFFFFF1C2), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.lightbulb_outline, size: 28), SizedBox(width: 12), Expanded(child: Text('A small change in your interest rate can make a big difference over the life of a loan.', style: TextStyle(fontWeight: FontWeight.w600, height: 1.4)))])),
              ]),
            ),
          ]),
        ),
      );
}

class FinanceHubView extends StatelessWidget {
  const FinanceHubView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Finance Hub', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: AppColors.background),
        body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
          const NeoTopPill(title: 'Your money, made simpler'),
          const SizedBox(height: 12),
          const Text('Finance Calculator', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          _HubGrid(items: calculatorItems.take(5).toList()),
          const SizedBox(height: 24),
          const Text('Value for your Money', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          _HubGrid(items: calculatorItems.skip(5).take(4).toList()),
          const SizedBox(height: 24),
          const Text('Other Calculators', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          _HubGrid(items: calculatorItems.skip(9).toList()),
        ]),
      );
}

class _HubGrid extends StatelessWidget {
  final List<CalculatorInfo> items;
  const _HubGrid({required this.items});
  @override
  Widget build(BuildContext context) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 9, mainAxisSpacing: 11, childAspectRatio: .86),
        itemBuilder: (_, i) => _CalculatorTile(item: items[i], compact: true),
      );
}

class _CalculatorTile extends StatelessWidget {
  final CalculatorInfo item;
  final bool compact;
  const _CalculatorTile({required this.item, this.compact = false});
  @override
  Widget build(BuildContext context) => NeoCard(
        padding: EdgeInsets.all(compact ? 9 : 13),
        onTap: () => Get.toNamed(item.route),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(width: compact ? 39 : 43, height: compact ? 39 : 43, decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(12), border: Border.all(width: 1.5)), child: Icon(item.icon, size: compact ? 21 : 23)),
          const SizedBox(height: 6),
          Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w800, fontSize: compact ? 12 : 14, height: 1.1)),
          if (!compact) Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10.5, color: Colors.black.withValues(alpha: .65), height: 1.2)),
        ]),
      );
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String? action;
  final String? route;
  const _SectionHeading({required this.title, this.action, this.route});
  @override
  Widget build(BuildContext context) => Row(children: [Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)), const Spacer(), if (action != null) TextButton(onPressed: () => Get.toNamed(route!), child: Text(action!))]);
}

enum CalculatorType { emi, loanAmount, sip, gst, interest, compare, cash }

class CalculatorView extends StatefulWidget {
  final CalculatorType type;
  const CalculatorView({super.key, required this.type});
  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _service = FinanceCalculatorService();
  late final TextEditingController amount, rate, tenure, secondAmount, secondRate;
  bool years = false, addGst = true, calculated = true, compound = true;
  double gstRate = 18;
  Object? result;
  final Map<int, int> cashCounts = {for (final value in [2000, 500, 200, 100, 50, 20, 10]) value: 0};

  String get title => switch (widget.type) {
        CalculatorType.emi => 'EMI Calculator', CalculatorType.loanAmount => 'Loan Amount Estimator',
        CalculatorType.sip => 'SIP Calculator', CalculatorType.gst => 'GST Calculator',
        CalculatorType.interest => 'Interest Calculator', CalculatorType.compare => 'Compare Loans', CalculatorType.cash => 'Cash Calculator',
      };
  String get subtitle => switch (widget.type) {
        CalculatorType.emi => 'Smart EMI Planner', CalculatorType.loanAmount => 'Find your eligible loan amount',
        CalculatorType.sip => 'Plan your investments smartly', CalculatorType.gst => 'Add or remove GST with ease',
        CalculatorType.interest => 'Simple & compound interest', CalculatorType.compare => 'Choose the loan that fits you', CalculatorType.cash => 'Count your cash notes',
      };

  @override
  void initState() {
    super.initState();
    amount = TextEditingController(text: widget.type == CalculatorType.loanAmount ? '46000' : widget.type == CalculatorType.gst ? '1000' : '100000');
    rate = TextEditingController(text: widget.type == CalculatorType.sip ? '12' : '10');
    tenure = TextEditingController(text: '12');
    secondAmount = TextEditingController(text: '46000');
    secondRate = TextEditingController(text: '8.5');
    calculate();
  }

  @override
  void dispose() { amount.dispose(); rate.dispose(); tenure.dispose(); secondAmount.dispose(); secondRate.dispose(); super.dispose(); }

  void calculate() {
    final a = double.tryParse(amount.text) ?? 0;
    final r = double.tryParse(rate.text) ?? 0;
    final t = int.tryParse(tenure.text) ?? 0;
    setState(() {
      calculated = true;
      result = switch (widget.type) {
        CalculatorType.emi => _service.calculateEmi(principal: a, annualRate: r, tenureValue: t, isYears: years),
        CalculatorType.loanAmount => _service.calculateLoanAmount(monthlyEmi: a, annualRate: r, tenureValue: t, isYears: years),
        CalculatorType.sip => _service.calculateSip(monthlyInvestment: a, expectedRate: r, tenureValue: t, isYears: years),
        CalculatorType.gst => _service.calculateGst(amount: a, gstRate: gstRate, isAddGst: addGst),
        CalculatorType.interest => _service.calculateInterest(depositAmount: a, annualRate: r, tenureValue: t, isYears: years),
        CalculatorType.compare => _service.calculateEmi(principal: a, annualRate: r, tenureValue: t, isYears: years),
        CalculatorType.cash => null,
      };
    });
  }

  void clear() { amount.clear(); rate.clear(); tenure.clear(); setState(() { result = null; calculated = false; for (final value in cashCounts.keys) { cashCounts[value] = 0; } }); }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: AppColors.background, title: Text(_appBarTitle, style: const TextStyle(fontWeight: FontWeight.w800)), actions: [IconButton(onPressed: clear, tooltip: 'Clear', icon: const Icon(Icons.restart_alt))]),
        body: ListView(padding: const EdgeInsets.fromLTRB(20, 2, 20, 28), children: [
          NeoTopPill(title: subtitle),
          const SizedBox(height: 14),
          _buildForm(),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(child: NeoButton(text: 'Clear', icon: Icons.close, onTap: clear)),
            const SizedBox(width: 8),
            Expanded(child: NeoButton(text: 'Calculate', icon: Icons.calculate_outlined, backgroundColor: AppColors.btnEmeraldGreen, onTap: calculate)),
            if (widget.type == CalculatorType.emi || widget.type == CalculatorType.loanAmount) ...[
              const SizedBox(width: 8),
              Expanded(child: NeoButton(text: 'Statistic', icon: Icons.bar_chart, backgroundColor: AppColors.btnAmberOrange, onTap: _showCurrentSchedule)),
            ],
          ]),
          const SizedBox(height: 21),
          if (result != null || widget.type == CalculatorType.cash) ...[
            if (widget.type == CalculatorType.emi || widget.type == CalculatorType.loanAmount || widget.type == CalculatorType.sip) _buildInvestmentResult(),
            if (widget.type == CalculatorType.gst) _buildGstResult(),
            if (widget.type == CalculatorType.interest) _buildInterestResult(),
            if (widget.type == CalculatorType.compare) _buildCompareResult(),
            if (widget.type == CalculatorType.cash) _buildCashResult(),
          ],
        ]),
      );

  String get _appBarTitle => switch (widget.type) {
        CalculatorType.emi => 'EMI Calculator',
        CalculatorType.loanAmount => 'Loan Amount Calculator',
        CalculatorType.sip => 'SIP Calculator',
        CalculatorType.gst => 'GST Calculator',
        CalculatorType.interest => 'Interest Calculator',
        CalculatorType.compare => 'Compare Loans',
        CalculatorType.cash => 'Cash Calculator',
      };

  Widget _buildForm() {
    if (widget.type == CalculatorType.gst) {
      return NeoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('GST mode', style: TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 10),
        Row(children: [Expanded(child: _modeButton('Add GST', addGst, () => setState(() { addGst = true; calculate(); }))), const SizedBox(width: 8), Expanded(child: _modeButton('Remove GST', !addGst, () => setState(() { addGst = false; calculate(); })))]),
        const SizedBox(height: 15), NeoInputField(label: 'Amount', controller: amount, prefixIcon: const Text('\$', style: TextStyle(fontWeight: FontWeight.w900)), onChanged: (_) => calculate()),
        const SizedBox(height: 12), const Text('GST Rate', style: TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 8),
        Wrap(spacing: 8, children: [5, 12, 18, 28].map((value) => ChoiceChip(label: Text('$value%'), selected: gstRate == value, onSelected: (_) { setState(() => gstRate = value.toDouble()); calculate(); })).toList()),
      ]));
    }
    if (widget.type == CalculatorType.cash) return NeoCard(child: const Text('Add note denominations and quantities below.', style: TextStyle(fontWeight: FontWeight.w700)));
    final amountLabel = switch (widget.type) { CalculatorType.emi => 'Loan Amount', CalculatorType.loanAmount => 'Monthly EMI', CalculatorType.sip => 'Monthly Investment', CalculatorType.interest => 'Deposit Amount', _ => 'Amount' };
    return NeoCard(child: Column(children: [
      NeoInputField(label: amountLabel, controller: amount, prefixIcon: const Text('\$', style: TextStyle(fontWeight: FontWeight.w900)), onChanged: (_) => calculate()),
      const SizedBox(height: 12),
      if (widget.type == CalculatorType.compare) ...[
        NeoInputField(label: 'Second loan interest rate (%)', controller: secondRate, prefixIcon: const Icon(Icons.percent, size: 18), onChanged: (_) => calculate()), const SizedBox(height: 12),
      ],
      NeoInputField(label: widget.type == CalculatorType.sip ? 'Expected annual return (%)' : 'Interest Rate (% per year)', controller: rate, prefixIcon: const Icon(Icons.percent, size: 18), keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => calculate()),
      const SizedBox(height: 12),
      NeoInputField(label: 'Tenure', controller: tenure, prefixIcon: const Icon(Icons.calendar_month_outlined, size: 18), isTenureField: true, isYearSelected: years, onTenureToggle: (value) { setState(() => years = value); calculate(); }, onChanged: (_) => calculate()),
      if (widget.type == CalculatorType.interest) ...[const SizedBox(height: 8), SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Compound interest', style: TextStyle(fontWeight: FontWeight.w700)), value: compound, onChanged: (v) { setState(() => compound = v); calculate(); })],
    ]));
  }

  Widget _modeButton(String label, bool active, VoidCallback tap) => OutlinedButton(onPressed: tap, style: OutlinedButton.styleFrom(backgroundColor: active ? AppColors.btnEmeraldGreen : Colors.white, foregroundColor: Colors.black, side: const BorderSide(color: Colors.black, width: 1.5)), child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)));

  Widget _buildInvestmentResult() {
    final titleLabel = switch (widget.type) { CalculatorType.emi => 'Monthly EMI', CalculatorType.loanAmount => 'Eligible Loan Amount', CalculatorType.sip => 'Maturity Value', _ => 'Result' };
    final amountValue = switch (result) { EmiResult x => x.monthlyEmi, LoanAmountResult x => x.maxLoanAmount, SipResult x => x.maturityAmount, _ => 0.0 };
    final principal = switch (result) { EmiResult x => x.principal, LoanAmountResult x => x.maxLoanAmount, SipResult x => x.totalInvestment, _ => 0.0 };
    final interest = switch (result) { EmiResult x => x.totalInterest, LoanAmountResult x => x.totalInterest, SipResult x => x.totalInterest, _ => 0.0 };
    final payment = switch (result) { EmiResult x => x.totalPayment, LoanAmountResult x => x.totalPayment, SipResult x => x.maturityAmount, _ => 0.0 };
    final interestPercent = payment <= 0 ? 0.0 : (interest / payment * 100).clamp(0.0, 100.0);
    final principalPercent = payment <= 0 ? 0.0 : (principal / payment * 100).clamp(0.0, 100.0);
    return Column(children: [
      NeoCard(backgroundColor: const Color(0xFFD8F5DE), child: Column(children: [Text(titleLabel, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text(_money(amountValue), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text(widget.type == CalculatorType.emi ? 'Based on your loan details' : 'Estimated total value', style: const TextStyle(color: Colors.black54))])),
      const SizedBox(height: 15),
      NeoCard(child: Column(children: [const Align(alignment: Alignment.centerLeft, child: Text('Payment breakdown', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900))), const SizedBox(height: 18), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [CircularPercentageGauge(percentage: principalPercent, label: widget.type == CalculatorType.sip ? 'Invested' : 'Principal', amount: _money(principal), activeColor: AppColors.btnEmeraldGreen, size: 96), CircularPercentageGauge(percentage: interestPercent, label: 'Interest', amount: _money(interest), activeColor: AppColors.iconOrange, size: 96)]), const SizedBox(height: 16), _summaryLine('Total ${widget.type == CalculatorType.sip ? 'maturity' : 'payment'}', _money(payment)), _summaryLine(widget.type == CalculatorType.emi ? 'Monthly payment' : 'Total interest', _money(widget.type == CalculatorType.emi ? amountValue : interest))])),
    ]);
  }

  void _showCurrentSchedule() {
    final rows = switch (result) {
      EmiResult value => value.schedule,
      LoanAmountResult value => value.schedule,
      _ => <AmortizationScheduleItem>[],
    };
    _showSchedule(rows);
  }

  Widget _buildGstResult() {
    final r = result as GstResult;
    return NeoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('GST breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const SizedBox(height: 12), _summaryLine(addGst ? 'Base amount' : 'Amount before GST', _money(r.actualAmount)), _summaryLine('GST ($gstRate%)', _money(r.gstAmount)), const Divider(), _summaryLine(addGst ? 'Total including GST' : 'Total amount', _money(r.netPrice), bold: true)]));
  }

  Widget _buildInterestResult() {
    final r = result as InterestResult;
    // Recalculate the displayed compound toggle directly when selected.
    final years = this.years ? (int.tryParse(tenure.text) ?? 0).toDouble() : (int.tryParse(tenure.text) ?? 0) / 12;
    final p = double.tryParse(amount.text) ?? 0, rateValue = double.tryParse(rate.text) ?? 0;
    final maturity = compound ? p * math.pow(1 + rateValue / 100, years) : p * (1 + rateValue * years / 100);
    final interest = maturity - p;
    return NeoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Investment summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const SizedBox(height: 12), _summaryLine('Investment', _money(r.totalInvestment)), _summaryLine('Interest earned', _money(interest)), const Divider(), _summaryLine('Maturity amount', _money(maturity), bold: true)]));
  }

  Widget _buildCompareResult() {
    final a = result as EmiResult;
    final other = _service.calculateEmi(principal: double.tryParse(amount.text) ?? 0, annualRate: double.tryParse(secondRate.text) ?? 0, tenureValue: int.tryParse(tenure.text) ?? 0, isYears: years);
    return Column(children: [NeoCard(child: Column(children: [const Text('Monthly EMI comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const SizedBox(height: 12), _summaryLine('Loan A · ${rate.text}%', _money(a.monthlyEmi)), _summaryLine('Loan B · ${secondRate.text}%', _money(other.monthlyEmi)), const Divider(), _summaryLine('Monthly difference', _money((a.monthlyEmi - other.monthlyEmi).abs()), bold: true)]))]);
  }

  Widget _buildCashResult() => Column(children: [for (final denomination in cashCounts.keys) Padding(padding: const EdgeInsets.only(bottom: 10), child: NeoCard(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), child: Row(children: [Text('\$$denomination', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)), const Spacer(), IconButton(onPressed: () => setState(() => cashCounts[denomination] = math.max(0, cashCounts[denomination]! - 1)), icon: const Icon(Icons.remove_circle_outline)), Text('${cashCounts[denomination]}', style: const TextStyle(fontWeight: FontWeight.w900)), IconButton(onPressed: () => setState(() => cashCounts[denomination] = cashCounts[denomination]! + 1), icon: const Icon(Icons.add_circle_outline))]))), NeoCard(backgroundColor: const Color(0xFFD8F5DE), child: _summaryLine('Cash total', _money(cashCounts.entries.fold<int>(0, (total, item) => total + item.key * item.value).toDouble()), bold: true))]);

  Widget _summaryLine(String label, String value, {bool bold = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [Expanded(child: Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w600))), Text(value, style: TextStyle(fontWeight: FontWeight.w900, fontSize: bold ? 17 : 14))]));
  String _money(double value) => '\$${value.isFinite ? value.toStringAsFixed(2) : '0.00'}';

  void _showSchedule(List<AmortizationScheduleItem> schedule) => Get.bottomSheet(
        SafeArea(child: Container(height: Get.height * .78, decoration: const BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.vertical(top: Radius.circular(26))), child: Column(children: [
          const SizedBox(height: 14), Container(width: 44, height: 5, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8))),
          Padding(padding: const EdgeInsets.all(18), child: Row(children: [const Expanded(child: Text('Payment schedule', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))), Text('${schedule.length} months') ])),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 14), child: Row(children: [Expanded(child: Text('Month', style: TextStyle(fontWeight: FontWeight.w800))), Expanded(child: Text('Principal', style: TextStyle(fontWeight: FontWeight.w800))), Expanded(child: Text('Interest', style: TextStyle(fontWeight: FontWeight.w800))), Expanded(child: Text('Balance', style: TextStyle(fontWeight: FontWeight.w800)))])),
          const Divider(color: Colors.black),
          Expanded(child: ListView.builder(itemCount: schedule.length, itemBuilder: (_, i) { final row = schedule[i]; return Container(color: i.isEven ? Colors.white.withValues(alpha: .65) : Colors.transparent, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), child: Row(children: [Expanded(child: Text('${row.period}')), Expanded(child: Text(_money(row.principalPaid))), Expanded(child: Text(_money(row.interestPaid))), Expanded(child: Text(_money(row.remainingBalance)))])); })),
        ]))),
        isScrollControlled: true,
      );
}
